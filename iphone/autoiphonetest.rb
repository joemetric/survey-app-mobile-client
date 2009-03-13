#!/usr/bin/env ruby

require 'rubygems'

gem 'paulanthonywilson-osx_watchfolder'
gem 'rake'

require 'osx_watchfolder'

ARGV.clear
ARGV << 'auto:test:all'


fork do
  load 'rake'
end
OsxWatchfolder::FolderWatcher.new("Classes", "UnitTests") do 
  fork{load 'rake'}
end.start