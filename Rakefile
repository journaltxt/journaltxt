require 'hoe'
require './lib/journaltxt/version.rb'

Hoe.spec 'journaltxt' do

  self.version = Journaltxt::VERSION

  self.summary = "journaltxt - reads Journal.TXT and writes out a blog (w/ Jekyll posts etc.)"
  self.description = summary

  self.urls    = ['https://github.com/journaltxt/journaltxt']

  self.author  = 'Gerald Bauer'
  self.email   = 'wwwmake@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.licenses = ['Public Domain']

  ### todo
  ##   add deps e.g. props gem for INI.load


  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end
