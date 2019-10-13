require 'rails_helper'

RSpec.describe ItemIcon, type: :model do
  it "is invalid without name" do
    no_name_item = FactoryBot.build(:item_icon, name: nil)
    no_name_item.valid?
    expect(no_name_item.errors[:name]).to include("を入力してください")
  end

  describe "name max length" do
    context "name length is 30" do
      it "true" do
        item_icon = FactoryBot.build(:item_icon, name: "a" * 30)
        expect(item_icon).to be_valid
      end
    end

    context "name length is 31" do
      it "false" do
        item_icon = FactoryBot.build(:item_icon, name: "a" * 31)
        expect(item_icon).to be_invalid
      end
    end
  end
end
