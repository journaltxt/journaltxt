## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'textutils'


## our own code
require 'journaltxt'



LogUtils::Logger.root.level = :debug


def read_text( name )
  text = File.open( "#{Journaltxt.root}/test/data/#{name}.txt", 'r:bom|utf-8' ).read
  text
end
