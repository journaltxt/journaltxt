###
#  to run use
#     ruby -I ./lib -I ./test test/test_parser.rb
#  or better
#     rake test

require 'helper'


class TestParser < MiniTest::Test

  def test_journal
    text = read_text( 'journal' )

    items = Journaltxt::Parser.parse( text )

    puts ":: Blocks ::::::::::::::::::::::"
    pp items

    assert true
  end

  def test_vienna
    text = read_text( 'vienna' )

    items = Journaltxt::Parser.parse( text )

    puts ":: Blocks ::::::::::::::::::::::"
    pp items

    assert true
  end


end # class TestParser
