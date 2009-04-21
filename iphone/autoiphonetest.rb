#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/autotest'

require 'rubygems'

gem 'paulanthonywilson-osx_watchfolder'
gem 'rake'

require 'osx_watchfolder'

ARGV.clear
ARGV << 'auto:test:all'


AutoTest::test_and_report

OsxWatchfolder::FolderWatcher.new("Classes", "UnitTests") do 
  AutoTest::test_and_report
end.start