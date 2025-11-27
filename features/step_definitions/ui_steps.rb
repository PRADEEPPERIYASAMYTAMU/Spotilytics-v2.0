When(/I press "([^"]+)"/) do |button|
  # Click a button by text or value anywhere on the page. Prefer `click_button` which
  # matches <button> and <input type="submit"> elements; fall back to `click_on`.
  begin
    click_button button
  rescue Capybara::ElementNotFound
    click_on button
  end
end


Then(/I should see a flash message matching (\/.+\/i?)/) do |regex_literal|
  # Accepts a literal regex string like /Playlist created/i
  if regex_literal =~ %r{^/(.*)/([i]?)$}
    pattern = Regexp.new($1, $2 == 'i' ? Regexp::IGNORECASE : 0)
  else
    pattern = Regexp.new(regex_literal)
  end

  # Flash messages render in .flash-div as .flash-notice or .flash-alert
  expect(page).to have_css('.flash-div')
  text = page.find('.flash-div').text
  expect(text).to match(pattern)
end
