# encoding: utf-8


# core and stdlibs

require 'strscan'    ## StringScanner
require 'json'
require 'yaml'
require 'date'
require 'time'
require 'pp'



# 3rd party gems/libs
require 'logutils'
require 'props'     ## used for IniFile.parse


# our own code
require 'journaltxt/version'  # let it always go first



# say hello
puts Journaltxt.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
