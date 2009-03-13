
BUILD_STATUS_FILE=".built"

class String
  attr_accessor :colour
  RESET="\e[00;m"

  def coloured(colour = nil)
    colour||=@colour
    "#{colour_code(colour)}#{self}#{RESET}"
  end

  private 
  def colour_code colour
    case colour
    when :red : "\e[01;31m"
    when :green : "\e[01;32m"
    end
  end
end

file BUILD_STATUS_FILE => Dir.glob("Classes/*.[hm]") + Dir.glob("UnitTests/*.m") do
  failure_line = AutoTest::test
  if failure_line
    notice = ['Fail', failure_line.chomp]
  else
    notice = ['Pass']
  end
  AutoTest::growl *notice
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



module AutoTest
  def self.test
    output = `xcodebuild -target "Unit Test" -configuration Debug -sdk iphonesimulator2.1`
    failure_line = nil
    output.each do |line|
      if line =~ /error:|^Executed.*(\d+) failures/
        if $1.nil? || $1.to_i > 0
          failure_line||= line
          line.colour = :red
        else
          line.colour = :green
        end
      end
      print line.coloured
    end
    failure_line
  end

  def self.growl title, msg =""
    img = "~/.autotest_images/#{title.downcase}.png"
    `growlnotify -H localhost -n autotest --image #{img} -p 0 -m #{msg.inspect} #{title}` 
  end

end