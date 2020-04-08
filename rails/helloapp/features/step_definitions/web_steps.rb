Given /^I am on login page$/ do
  visit user_session_path
end

And /^I go to (\w+)$/ do |page|
  visit __send__("#{page}_path")
end

When /^I fill in "(.+)" field with "(.+)"$/ do |field_name, value|
  fill_in(field_name, with: value)
end

When /^I click on "(.+)"$/ do |text|
  click_link_or_button(text)
end

Then /^I should see text "(.+)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should see text ([\w\s]+)$/ do |text|
  expect(page).to have_content(text)
end
