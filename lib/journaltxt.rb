# encoding: utf-8


# core and stdlibs

require 'yaml'
require 'date'
require 'time'
require 'pp'
require 'optparse'


# our own code
require 'journaltxt/version'  # let it always go first
require 'journaltxt/parser'


module Journaltxt

  def self.main
    process( ARGV )
  end


  DEFAULTS = { outpath: '.',
             date:    true,      # include date in (auto-)title
             verbose: false,
             name:    'Journal'
           }

  def self.process( args )

    config = {}   ## note: keep use supplied and defaults separated!!! entry nil - if not set!!

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: journaltxt [OPTS]"

      opts.on("-v", "--[no-]verbose", "Show debug messages") do |verbose|
        config[:verbose] = verbose
      end

      ## use --outdir or outputdir or something or output
      opts.on("-o", "--output=PATH", "Output path (default: #{DEFAULTS[:outpath]})") do |outpath|
        config[:outpath] = outpath
      end

      opts.on("-n", "--name=NAME", "Journal name (default: #{DEFAULTS[:name]})") do |name|
        config[:name] = name
      end

      opts.on("--[no-]date", "Add date to page title (default: #{DEFAULTS[:date]})") do |date|
        config[:date] = date
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    parser.parse!(args)

    puts ":: Config :::"
    pp config
    puts ":: Args :::"
    pp args

    if args.size == 0   ## default to journal.txt  if no filename passed along
      args << 'journal.txt'
    end

    args.each do |arg|
      build_file( arg, config )
    end
  end


  def self.build_file( path, opts={} )
    text = File.open( path, 'r:bom|utf-8' ).read

    ## note: remove .txt extension if present for basename
    basename = File.basename( path, '.txt' )
    puts "basename:"
    pp basename

    ## note: only overwrite if NOT user-supplied
    opts[:name] ||= basename

    build( text, opts )
  end


  def self.build( text, opts={} )
    puts ":: Opts :::"
    pp opts

    outpath   = opts[:outpath]  || DEFAULTS[:outpath]
    name      = opts[:name]     || DEFAULTS[:name]
    add_date  = opts.fetch( :date, DEFAULTS[:date] )  ## special case boolean flag migth be false


    items = Parser.parse( text  )

    items.each_with_index do |item,i|
      ## add page_title
      ##   todo/fix:  check if title exists? do NOT overwrite - why? why not?

      page_meta = item[0]
      page_date = page_meta['date']

      page_title = ''
      if name.downcase == 'journal'  ## note: special case (do NOT auto-add journal to title)
        ## dont't add "default/generic" journal to title
      else
        page_title << "#{name} - "
      end
      page_title << "Day #{i+1}"
      page_title << " - #{page_date.strftime('%a, %-d %b')}"   if add_date

      page_meta['title'] = page_title
    end


    items.each_with_index do |item,i|
       page_meta    = item[0]
       page_content = item[1]

       page_date    = page_meta['date']
       page_title   = page_meta['title']

       path = ''
       path << "#{outpath}/#{page_date}"
       path << "-#{name.downcase}.md"      ## note: journal gets auto-added to the name too

       ##
       ##  check if path exits?
       page_root = File.dirname( File.expand_path( path ) )
       unless File.directory?( page_root )
         puts "   make (missing) output dirs >#{page_root}...<"
         FileUtils.makedirs( page_root )
       end


       puts "Writing entry #{i+1}/#{items.size} >#{page_title}< to #{path}..."

       ### todo:
       ##   add a comment in the yaml meta data block e.g.
       ##   #  Journal.TXT entry 1/4 - auto-built on xxxx by journaltxt v1.2.3
       ##   or something

       comment = "Journal.TXT entry #{i+1}/#{items.size} - auto-built on #{Time.now} by journaltxt/#{Journaltxt.version}"

       yaml_text = YAML.dump( page_meta )
       ## todo: check better way to add an upfront comment?
       ##   for now just replace leading --- with leading --- with comment
       yaml_text = yaml_text.sub( /^---[ ]*$\n?/, "---\n# #{comment}\n" )

       File.open( path, 'w:utf-8' ) do |f|
         f.write yaml_text
         f.write "---\n\n"
         f.write page_content
       end
    end
  end

end # module Journaltxt


# say hello
puts Journaltxt.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
