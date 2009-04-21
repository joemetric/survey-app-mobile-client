require File.dirname(__FILE__) + '/autotest'

BUILD_STATUS_FILE=".built"


file BUILD_STATUS_FILE => Dir.glob("Classes/*.[hm]") + Dir.glob("UnitTests/*.m") do
  notice = AutoTest::test_and_report
  File.open(BUILD_STATUS_FILE, 'w') {|f| f.write(notice * ": ")}  
end


task 'auto:remove_built_file' do
  FileUtils.rm_f(BUILD_STATUS_FILE)
end

desc "build and run the tests "
task 'auto:test:all'=>['auto:remove_built_file', 'auto:test']

desc "build and run the tests if changed"
task 'auto:test'=>[BUILD_STATUS_FILE] do
  out =  File.open('.built') {|f| f.read}
  print out.coloured(out =~ /Pass/ ? :green : :red) + "\n"
end



