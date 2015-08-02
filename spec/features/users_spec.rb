# coding: utf-8
require 'rails_helper'
feature 'Login' do
  before do
    FactoryGirl.build(:post)
    visit root_path
    click_link I18n.t "devise.sessions.new.sign_in"
  end

  scenario "with valid user/password", js: true do
    fill_in (I18n.t "activerecord.attributes.user.email"), :with => "test@example.com"
    fill_in (I18n.t "activerecord.attributes.user.password"), :with => 'f4k3p455w0rd'
    click_button I18n.t 'devise.sessions.new.sign_in'
    expect(page).to have_content(I18n.t "devise.sessions.signed_in")
  end

  scenario "with wrong user/password", js: true do
    fill_in (I18n.t "activerecord.attributes.user.email"), :with => 'failed@login.com'
    fill_in (I18n.t "activerecord.attributes.user.password"), :with => 'something failed'
    click_button I18n.t 'devise.sessions.new.sign_in'
    expect(page).to have_content(I18n.t "devise.failure.invalid")
  end
end
feature "signup" do
  before do
    FactoryGirl.build(:post)
    visit root_path
    click_link I18n.t "devise.registrations.new.sign_up"
  end
  scenario "with valid info", js: true do
    fill_in (I18n.t "activerecord.attributes.user.email"), :with => 'teste@example.com'
    fill_in (I18n.t "activerecord.attributes.user.password"), :with => 'password'
    fill_in (I18n.t "activerecord.attributes.user.password_confirmation"), :with => 'password'
    click_button I18n.t 'devise.registrations.new.sign_up'
    expect(page).to have_content(I18n.t "devise.registrations.signed_up")
  end
  scenario "with missing info", js: true do
    fill_in (I18n.t "activerecord.attributes.user.email"), :with => 'example.com'
    fill_in (I18n.t "activerecord.attributes.user.password"), :with => 'password'
    click_button I18n.t 'devise.registrations.new.sign_up'
    expect(page).to have_content((I18n.t "errors.messages.not_saved.other")[0..22])
  end
end
feature 'signout' do
  before do
    user = FactoryGirl.create(:user, :email => "test@example.com", :password => "password")
    login_as(user, :run_callbacks => false)
  end

  scenario "with valid user/password", js: true do
    visit root_path
    click_link I18n.t 'devise.sessions.new.sign_out'
    expect(page).to have_content(I18n.t "devise.sessions.signed_out")
  end
end
