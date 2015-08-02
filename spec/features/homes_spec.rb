# coding: utf-8
require 'rails_helper'
describe "Home page" do
  it "entra na home" do
    visit root_path
    page.has_content?('Home')
  end
  it "permite postagens ao usuário logado", js: true do
    user = FactoryGirl.create(:user)
    login_as(user, :run_callbacks => false)
    visit root_path
    fill_in (I18n.t "activerecord.attributes.post.body"), :with => 'esse céu azul estrelado me faz ter vontade de viver'
    click_button(I18n.t "helpers.submit.create", model: 'moss')
    expect(page).to have_content('esse céu azul estrelado me faz ter vontade de viver')
  end
end
