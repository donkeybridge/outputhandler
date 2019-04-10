Given("a new instance is created") do
  require './lib/outputhandler.rb'
  @output_handler = OutputHandler.new 
end

Given("it is paused") do
  @output_handler.pause
end

Then("#out! should send output") do
  expect { @output_handler.out!("foo")}.to output("foo\n").to_stdout
end

Then("#out should not send output") do
  expect { @output_handler.out("foo")}.not_to output().to_stdout_from_any_process
end

Given("output is send to #out") do
  @output_handler.out("foo")
end

Given /^output "([^"]*)" is send to #out$/ do |str|
  @output_handler.out(str)
  sleep 0.1
end

Then "#out should not send immediate output" do 
  expect { @output_handler.out("foo"); sleep 0.25 }.not_to output.to_stdout_from_any_process
end

Then "#out should send immediate output when unpausing" do
  expect { @output_handler.unpause; sleep 0.25 }.to output("foo\n").to_stdout_from_any_process
end

Given /^it is paused for (\d+) seconds$/ do |seconds|
  @output_handler.pause(seconds)
end

Then /^should arrive after (\d+) seconds$/ do |seconds|
  expect{ sleep seconds; }.to output("foo\n").to_stdout_from_any_process
end

Then "it should send immediate upon #flush" do
  expect { @output_handler.flush; sleep 0.25 }.to output("foo\nfoo\n").to_stdout_from_any_process
end

Then "it should not send immediate upon silent #flush" do
  expect { @output_handler.flush(true); sleep 0.25 }.not_to output.to_stdout_from_any_process
end

Then "#out should not send immediate output when unpausing" do
  expect { @output_handler.unpause; sleep 0.25}.not_to output.to_stdout_from_any_process
end




