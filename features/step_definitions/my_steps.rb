Given(/^I am on home page$/) do
  home_url = 'https://jupiter.cloud.planittesting.com/#/home'

  puts "URL : #{home_url}"
  @browser.goto(home_url)

  if @browser.title == 'Certificate Error: Navigation Blocked'
    @browser.goto("javascript:document.getElementById('overridelink').click()")
  end
  load_url(home_url)
  @browser.window.maximize
  $user=Jupiter.new($browser)
end

And(/^I navigate to the "([^"]*)" page$/) do |page|
  type = "#/#{page}"
  puts type
  $user.mega_nav_sel(type)
end

Then(/^I fill all the mandatory fields$/) do
  $fname = (0...8).map { (65 + rand(26)).chr }.join
  $email = (0...8).map { (65 + rand(26)).chr }.join + '@yopmail.com'
  $user.contact_object('TextBox', 'forename').wait_until_present(60)
  $user.contact_object('TextBox', 'forename').set $fname
  $user.contact_object('TextBox', 'email').set $email
  $user.contact_object('msg', 'message').set $email

end

And(/^I click the "([^"]*)" Button$/) do |text|
  @browser.a(text: /#{text}/).click
end

Then(/^I validate the successful submission message$/) do
  $user.success_msg.wait_until_present(60)
  expect($user.success_msg.text.include?('Thanks')).to be true

end