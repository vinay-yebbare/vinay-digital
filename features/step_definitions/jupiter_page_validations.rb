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

Then(/^I fill all the mandatory fields for (.*) customers$/) do |different|
  $fname = (0...8).map { (65 + rand(26)).chr }.join
  $email = (0...8).map { (65 + rand(26)).chr }.join + '@yopmail.com'
  $user.contact_object('TextBox', 'forename').wait_until_present(60)
  $user.contact_object('TextBox', 'forename').set different
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

And(/^I add "([^"]*)" item "([^"]*)" to the cart$/) do |items, product|
  $user.product_selected(0).wait_until_present(60)
  items = items.to_i
  counter = $user.item_counter.count
  if $summary_details.nil?
    $summary_details = {}
    $total_items = 0
  end
  (0..counter - 1).each do |phone_index|
    if $user.product_selected(phone_index).text.include? product
    $product_selected = $user.product_selected(phone_index).text.split("\n")[0]
    $product_cost = $user.product_selected(phone_index).text.split("\n")[1].split("$")[1].to_f
    puts "Selected product cost is :- #{$product_cost}"
    (1..items).each do
    $user.product_selected(phone_index).a.click
    end
    $total_items = $total_items + items
    $product_values = []
    $product_values.push(items)
    $product_values.push($product_cost*items)
    $summary_details.store($product_selected, $product_values)
    end
  end
end

Then(/^I verify added items are in the cart$/) do
  $user.cart_msg.wait_until_present(30)
  count = $user.cart_msg_item.text.to_i
  expect(count == $total_items).to be true
  cart_item_count = $user.cart_items
  (0..cart_item_count - 1).each do |item_ind|
    if $user.cart_item(item_ind).include? $summary_details.keys[item_ind]
      expect($user.cart_item_cost(item_ind)[0].delete(" ") == $summary_details.keys[item_ind].delete(" ")).to be true
      puts "validated for #{$summary_details.keys[item_ind]}"
    end
  end
end

Then(/^I verify sub\-total for each product$/) do
  $user.cart_msg.wait_until_present(30)
  cart_item_count = $user.cart_items
  (0..cart_item_count - 1).each do |item_ind|
    if $user.cart_item(item_ind).include? $summary_details.keys[item_ind]
      expect($user.cart_item_cost(item_ind)[2].to_f == $summary_details.values[item_ind][1]).to be true
      puts "validated for #{$summary_details.keys[item_ind]}"
    end
  end
end