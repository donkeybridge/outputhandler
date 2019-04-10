Given /a new OutputHandler is created/ do
  require './lib/outputhandler.rb' 
  @output_handler = OutputHandler.new
end

Then "it should return an object of class OutputHandler"  do
  expect(@output_handler).to be_instance_of(OutputHandler)
end

Then /^it should have an instance variable "([^"]*)"$/  do |var|
  expect(@output_handler.instance_variable_defined?(var.to_sym)).to be true
end

Then /^"([^"]*)" should be a Boolean$/ do |var|
  expect(@output_handler.instance_variable_get(var.to_sym)).to be_instance_of(TrueClass).or be_instance_of(FalseClass)
end

Then /^"([^"]*)" should be nil$/ do |var|
  expect(@output_handler.instance_variable_get(var.to_sym)).to be_nil
end

Then /^"([^"]*)" should be a "([^"]*)"$/ do |var, klass|
  expect(@output_handler.instance_variable_get(var.to_sym)).to be_instance_of(Object.const_get(klass))
end

Then "it should be not paused?" do
  expect(@output_handler.paused?).to be false
end

Then "it should not respond to #foo"  do
  expect(@output_handler).not_to respond_to(:foo)
end

Then /^it should respond to "([^"]*)"$/ do |method|
  expect(@output_handler).to respond_to(method.to_sym)
end


Then /^#(out!?) should send output with newline to console$/ do |method|
  expect{@output_handler.send(method.to_sym,"foo"); sleep 0.25}.to output("foo\n").to_stdout_from_any_process
end

Then /^#(out!?) should send output to console without newline when added parameter false$/ do |method|
  expect{@output_handler.send(method.to_sym,"foo",false); sleep 0.1}.to output("foo").to_stdout
end


