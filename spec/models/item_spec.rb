require 'rails_helper'

RSpec.describe Item, type: :model do

    let(:user) { FactoryBot.build(:user) }
    let(:item_icon) { FactoryBot.build(:item_icon) }
    let(:kanzume) { FactoryBot.build(:kanzume) }

  it "is valid with a user, item_icon, kanzume, memo, memo" do
    item = FactoryBot.build(:item)
    expect(item).to be_valid
  end

  context "when kanzume is valid" do

  it "is invalid without item_icon" do
    no_icon_item = FactoryBot.build(:item, item_icon: nil)
    no_icon_item.valid?
    expect(no_icon_item.errors[:item_icon]).to include("を入力してください")
  end

  it "is invalid without kanzume" do
    no_kanzume_item = FactoryBot.build(:item, kanzume: nil)
    no_kanzume_item.valid?
    expect(no_kanzume_item.errors[:kanzume]).to include("を入力してください")
  end

  it "is invalid without name" do
    no_name_item = FactoryBot.build(:item, name: nil)
    no_name_item.valid?
    expect(no_name_item.errors[:name]).to include("を入力してください")
  end

  it "is invalid without memo" do
    no_memo_item = FactoryBot.build(:item, memo: nil)
    no_memo_item.valid?
    expect(no_memo_item.errors[:memo]).to include("を入力してください")
  end

  end

  describe "name max length" do
    context "name length is 30" do
      it "true" do
        item = FactoryBot.build(:item, name: "a" * 30)
        expect(item).to be_valid
      end
    end

    context "name length is 31" do
      it "false" do
        item= FactoryBot.build(:item, name: "a" * 31)
        expect(item).to be_invalid
      end
    end
  end

  describe "memo max length" do
    context "memo length is 255" do
      it "true" do
        item = FactoryBot.build(:item, memo: "a" * 255)
        expect(item).to be_valid
      end
    end

    context "password length is 256" do
      it "false" do
        item= FactoryBot.build(:item, memo: "a" * 256)
        expect(item).to be_invalid
      end
    end
  end

  
end

