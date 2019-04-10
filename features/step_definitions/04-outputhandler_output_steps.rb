require './lib/outputhandler.rb'

Then /^output should contain a NL but no CR when sent to "([^"]*)"$/ do |method|
  expect { @output_handler.send(method.to_sym, "foo"); sleep 0.25}.
    to output("foo\n").to_stdout_from_any_process
end

Then /^output should contain a NL with leading CR when sent to "([^"]*)" with param true$/ do |method|
  expect { @output_handler.send(method.to_sym, "foo", true); sleep 0.25}.
    to output("\rfoo\n").to_stdout_from_any_process
end

Then /^output should contain neither NL nor CR when sent to "([^"]*)"$/ do |method|
  expect { @output_handler.send(method.to_sym, "foo"); sleep 0.25 }.
    to output("foo").to_stdout_from_any_process
end

Then /^output should contain a leading CR but no NL when sent to "([^"]*)" with param true$/ do |method|
  expect { @output_handler.send(method.to_sym, "foo", true); sleep 0.25 }.
    to output("\rfoo").to_stdout_from_any_process
end

Given "{string} is sent to the handler with print" do |string|
  puts "sent str is #{string}"
  @output_handler.print(string)
  sleep 0.1
end

Given "{string} is sent to the handler with print and param true" do |string|
  puts "sent string is #{string}"
  @output_handler.print(string, true)
  sleep 0.1
end

#Then /^file "([^"]*)" should contain "([^"]*)"$/ do |filename, str|
#  expect(File.read(filename)).to eq("\r#{str}")
#end
