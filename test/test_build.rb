###
#  to run use
#     ruby -I ./lib -I ./test test/test_build.rb
#  or better
#     rake test

require 'helper'


class TestParser < MiniTest::Test

  def test_journal
    text = read_text( 'journal' )

    Journaltxt.build( text, name: 'Journal', outpath: './tmp' )

    assert true
  end

  def test_vienna
    text = read_text( 'vienna' )

    Journaltxt.build( text, name: 'Vienna', outpath: './tmp' )

    assert true
  end


end # class TestParser
