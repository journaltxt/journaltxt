# encoding: utf-8

module Journaltxt

class Parser

  def self.parse( text )   ## convenience helper
    self.new( text ).parse
  end

  def initialize( text )
    @text = text
  end

  def parse

    puts ":: Text :::::::::::::::::::::"
    puts @text

    ## allow trailing spaces for now
    ##  - allow leadin spaces too - why? why not?

    ## remove leading 1st separator --- first
    text = @text.sub( /^---[ ]*$\n?/, '' )
    b = text.split( /^---[ ]*$\n?/ )

    items = b.each_slice(2).to_a


    ## process meta data blocks convert to hash via yaml

    ##
    ## todo: check for required entries
    ##
    ##   first entry needs/requires:
    ##      year/month/day
    ##   all others requireÖ
    ##      day

    last_page_date = nil

    items = items.each_with_index.map do |item,i|
      page_meta   = YAML.load( item[0] )  ## convert to hash (from yaml text)
      pp page_meta
      page_content = item[1]

      ## remove all (short-cut) date entries
      year  = page_meta.delete( 'year' )
      month = page_meta.delete( 'month' )
      day   = page_meta.delete( 'day' )

      puts "  year: >#{year}< : #{year.class.name}, month: >#{month}< : #{month.class.name}, day: >#{day}< : #{day.class.name}"

      ## convert all date entries to ints
      ##   lets us handle day => Sun 23 etc.

      ##  note: assume year is always a number
      if year.nil?
         if last_page_date
           year = last_page_date.year
         else
           ### fix/todo: throw format/parse exception!!
           puts "** year entry required / expected for first entry / meta data block"
           exit 1
         end
      end


      if day && day.is_a?(String)
         puts "  trying to convert day to int..."
         nums_day = day.scan( /[0-9]+/ )   ## returns array e.g. ['12']
         day = nums_day[0].to_i
         puts "  day:   >#{day}< : #{day.class.name}"
      end

      if day.nil?   ### fix/add - check if day >0 and< 31 why? why not??
        ### fix/todo: throw format/parse exception!!
        puts "** day entry required in meta data block"
        exit 1
      end


      if month && month.is_a?(String)
        puts "  trying to convert month to int..."
        ## for now let stdlib handle conversion
        ##   supports abbreviated names (e.g. Jan) and full names (e.g. January)

        ## todo/fix: check what happens if montn is invalid/unknow
        ##    returns nil? throws exception?
        date_month = Date.parse( "#{year}/#{month}/#{day}" )
        month = date_month.month
        puts "  month: >#{month}< : #{month.class.name}"
      end

      if month.nil?
        if last_page_date
          month = last_page_date.month
        else
          ### fix/todo: throw format/parse exception!!
          puts "** month entry required for first entry / meta data block"
          exit 1
        end
      end


      page_date = Date.new( year, month, day )
      last_page_date = page_date

      ## todo:check if date exists? possible?
      ##     issue warning or something - will get replaced - why? why not?
      page_meta['date']  = page_date

      ## pp YAML.dump( h )

      [page_meta, page_content]
    end
    items
  end  # method parse

end # class Parser
end # module Journaltxt
