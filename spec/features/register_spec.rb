require 'spec_helper'

# http://robots.thoughtbot.com/rspec-integration-tests-with-capybara
# https://github.com/rspec/rspec-rails#request-specs
# https://github.com/jnicklas/capybara#using-capybara-with-rspec
feature 'Cat register and login' do

  scenario 'with valid email and password' do
    name = "Tsuki"
    email = "tsuki@catbook.com"
    password = "marrameu"

    visit register_path

    register_with(name, email, password)

    login_with(email, password)

    expect(page).to have_content "Welcome #{name}"
  end

  scenario 'with blank email and password' do
    visit register_path

    register_with('Akira', '', '')

    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_content 'Password can\'t be blank'
  end

  def login_with(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_button 'Login'
  end

  def register_with(name, email, password)
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_button 'Create Cat'
  end

end
