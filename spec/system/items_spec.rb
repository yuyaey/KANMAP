require 'rails_helper'
include LoginSupport

RSpec.describe "Items", type: :system do
  it "user creates a new Item", js: true do
    user = FactoryBot.create(:user)
    kanzume_icon = FactoryBot.create(:kanzume_icon)
    kanzume = FactoryBot.create(:kanzume, kanzume_icon: kanzume_icon, user: user)
    item_icon = FactoryBot.create(:item_icon)

    sign_in_as user
    click_on("kanzume-button")
    click_on("TestKanzume1")
    click_on("アイテムを追加")
  
    expect {
      fill_in "item-name", with: "Test Item"
      fill_in "item_memo", with: "This is a test memo"
      select "TestItemIcon", from: "item[item_icon_id]"
      click_button "登録する"
    expect(page).to have_content "「Test Item」を追加しました。"
    expect(page).to have_content "Test Item"
    expect(page).to have_content "#{user.name}"
    }.to change(user.items, :count).by(1)
  end

end