require './lib/outputhandler.rb'

Given "a OutputHandler will be created" do 
end

But "with a String as parameter is should raise a TypeError" do 
  expect { OutputHandler.new("foo")}.to raise_error(TypeError)
end

But "with a Hash as parameter it should not raise" do
  expect { OutputHandler.new({})}.not_to raise_error
end

Given /^an OutputHandler is created with parameter "([^"]*)" set to "([^"]*)"$/ do |param, value|
  File.open(value, "w"){|f| f.write "" } if param == "logfile"
  eval "@output_handler = OutputHandler.new(#{param}:\"#{value}\")"
end

Then /^file "([^"]*)" should contain output "([^"]*)"$/ do |filename, str|
  expect( `cat #{filename} | tail -n1`.split("\r").last.chomp).to eq(str.chomp)
end
  
