# coding: utf-8
require 'rails_helper'
def wait_for_ajax
  counter = 0
  while page.execute_script("return $.active").to_i > 0
    counter += 1
    sleep(0.1)
    raise "AJAX request took longer than 5 seconds." if counter >= 50
  end
end
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
  it "permite comentários ao usuário logado", js: true do
    user = FactoryGirl.create(:user)

    post = FactoryGirl.create(:post, user: user)

    login_as(user, :run_callbacks => false)
    visit root_path
    page.find("#reply_to_#{post.id}").click
    #expect(page.find("#comments_form_#{post.id}")).to be true
    within("#comments_form_#{post.id}") do
      fill_in (I18n.t "activerecord.attributes.post.body"), :with => 'esse céu amarelo estrelado me faz ter vontade de viver'
      click_button(I18n.t "helpers.submit.create", model: 'moss')
    end
    expect(page).to have_content('esse céu amarelo estrelado me faz ter vontade de viver')
  end
end
