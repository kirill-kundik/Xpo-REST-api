Given /^user exists$/ do
  @user = ::FactoryBot.create :user, email: 'test@example.com'
end

Given /^admin user exists$/ do
  @user = ::FactoryBot.create :user, email: 'test@example.com', is_admin: true
end

Given /^user is logged in$/ do
  login_as(@user)
end

Given /^user is admin$/ do
  @user.update_column(:is_admin, true)
end
