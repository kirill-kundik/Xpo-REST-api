And /^I wait for (\d+) seconds$/ do |n|
  sleep n.to_i
end

And /^I stop at breakpoint/ do
  binding.pry
end
