When(/^I press "([^"]+)"$/) do |button|
  begin
    click_button button
  rescue Capybara::ElementNotFound
    click_on button
  end
end


Then(/I should see a flash message matching (\/.+\/i?)/) do |regex_literal|
  if regex_literal =~ %r{^/(.*)/([i]?)$}
    pattern = Regexp.new($1, $2 == 'i' ? Regexp::IGNORECASE : 0)
  else
    pattern = Regexp.new(regex_literal)
  end

  expect(page).to have_css('.flash-div')
  text = page.find('.flash-div').text
  expect(text).to match(pattern)
end
