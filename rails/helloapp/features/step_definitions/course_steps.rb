Then(/^there should be a course with name "([^"]*)"$/) do |name|
  expect(::Course.find_by(name: name)).to be
end

And(/^there exists course with name "([\w\s]*)"$/) do |name|
  ::Course.create name: name
end

Given(/^the course exists with the name "([^"]+)"$/) do |name|
  FactoryBot.create :course, name: name
end
