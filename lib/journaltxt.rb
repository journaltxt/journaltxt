# encoding: utf-8


# core and stdlibs

require 'yaml'
require 'date'
require 'time'
require 'pp'



# 3rd party gems/libs
## require 'logutils'


# our own code
require 'journaltxt/version'  # let it always go first
require 'journaltxt/parser'


module Journaltxt

  def self.main(args)
    args.each do |arg|
      ## note: remove .txt extension if present for basename
      basename = File.basename( arg, '.txt' )
      puts "basename:"
      pp basename

      text = File.open( arg, 'r:bom|utf-8' ).read
      build( text, name: basename )
    end
  end

  def self.build( text, name: 'journal', outpath: '.' )

    if name.downcase == 'journal'   ## note: special case (do NOT auto-add journal to title)
      items = Parser.parse( text, name: nil )
    else
      items = Parser.parse( text, name: name )
    end

    items.each_with_index do |item,i|
       page_meta = item[0]
       page_text = item[1]

       page_date  = page_meta['date']
       page_title = page_meta['title']

       path = ''
       path << "#{outpath}/#{page_date}"
       path << "-#{name.downcase}.md"      ## note: journal gets auto-added to the name too

       puts "Writing entry #{i+1} >#{page_title}< to #{path}..."

       ### todo:
       ##   add a comment in the yaml meta data block e.g.
       ##   #  Journal.TXT entry 1/4 - auto-built on xxxx by journaltxt v1.2.3
       ##   or something

       File.open( path, 'w:utf-8' ) do |f|
         f.write YAML.dump( page_meta )
         f.write "---\n\n"
         f.write page_text
       end
    end
  end

end # module Journaltxt


# say hello
puts Journaltxt.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
