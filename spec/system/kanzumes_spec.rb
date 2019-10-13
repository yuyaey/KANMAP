require 'rails_helper'
include LoginSupport

RSpec.describe "Kanzumes", type: :system do
  it "user creates a new Kanzume", js: true do
    user = FactoryBot.create(:user)
    kanzume_icon = FactoryBot.create(:kanzume_icon)

    sign_in_as user
    visit '/kanzumes/new?address_name=%E6%97%A5%E6%9C%AC%E3%80%81%E3%80%92100-0005%20%E6%9D%B1%E4%BA%AC%E9%83%BD%E5%8D%83%E4%BB%A3%E7%94%B0%E5%8C%BA%E4%B8%B8%E3%81%AE%E5%86%85%EF%BC%91%E4%B8%81%E7%9B%AE%EF%BC%99%20JR%20%E6%9D%B1%E4%BA%AC%E9%A7%85&address_latitude=35.68111056610887&address_longitude=139.76725570521194'
    expect {
      fill_in "kanzume_name", with: "Test Kanzume"
      select "TestKanzumeIcon", from: "kanzume[kanzume_icon_id]"
      click_button "登録する"
    expect(page).to have_content "「Test Kanzume」を追加しました。"
    expect(page).to have_content "Test Kanzume"
    expect(page).to have_content "#{user.name}"
    }.to change(user.kanzumes, :count).by(1)
  end

end