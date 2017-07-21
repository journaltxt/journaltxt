###
#  to run use
#     ruby -I ./lib -I ./test test/test_build.rb
#  or better
#     rake test

require 'helper'


class TestParser < MiniTest::Test

  def xxx_test_journal
    text = read_text( 'journal' )

    Journaltxt.build( text, name: 'journal', outpath: './tmp' )

    assert true
  end

  def test_journal_ii
    Journaltxt.build_file( "#{Journaltxt.root}/test/data/journal.txt", outpath: './tmp' )

    assert true
  end

  def test_vienna
    text = read_text( 'vienna' )

    Journaltxt.build( text, name: 'Vienna', outpath: './tmp', date: false )

    assert true
  end


end # class TestParser
