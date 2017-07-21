# encoding: utf-8

module Journaltxt

class Parser

  def self.parse( text, name: nil )   ## convenience helper
    self.new( text, name: name ).parse
  end

  def initialize( text, name: nil )
    @text = text
    @name = name
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

    last_date = nil

    items = items.each_with_index.map do |item,i|
      h = YAML.load( item[0] )
      pp h

      ## remove all (short-cut) date entries
      year  = h.delete( 'year' )
      month = h.delete( 'month' )
      day   = h.delete( 'day' )

      puts "  year: >#{year}< : #{year.class.name}, month: >#{month}< : #{month.class.name}, day: >#{day}< : #{day.class.name}"

      ## convert all date entries to ints
      ##   lets us handle day => Sun 23 etc.

      ##  note: assume year is always a number
      if year.nil?
         if last_date
           year = last_date.year
         else
           puts "** year entry required for first entry / meta data block"
           exit 1
         end
      end


      if day && day.is_a?(String)
         puts "  trying to convert day to int..."
         nums_day = day.scan( /[0-9]+/ )   ## returns array e.g. ['12']
         day = nums_day[0].to_i
         puts "  day:   >#{day}< : #{day.class.name}"
      end

      if day.nil?
        puts "** day entry required in meta data block"
        exit 1
      end


      if month && month.is_a?(String)
        puts "  trying to convert month to int..."
        ## for now let stdlib handle conversion
        ##   supports abbreviated names (e.g. Jan) and full names (e.g. January)
        date_month = Date.parse( "#{year}/#{month}/#{day}" )
        month = date_month.month
        puts "  month: >#{month}< : #{month.class.name}"
      end

      if month.nil?
        if last_date
          month = last_date.month
        else
          puts "** month entry required for first entry / meta data block"
          exit 1
        end
      end


      date = Date.new( year, month, day )
      last_date = date
      h['date']  = date


      ## add title
      ##   todo/fix:  check if title exists? do NOT overwrite - why? why not?
      title = ''
      if @name
        title << "#{@name} - "
      end
      title << "Day #{i+1} - "
      title << "#{date.strftime('%a, %-d %b')}"

      h['title'] = title

      ## pp YAML.dump( h )

      [h, item[1]]
    end
    items
  end  # method parse

end # class Parser
end # module Journaltxt
