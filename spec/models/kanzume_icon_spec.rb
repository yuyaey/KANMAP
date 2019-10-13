require 'rails_helper'

RSpec.describe KanzumeIcon, type: :model do

  it "is invalid without name" do
    no_name_kanzume = FactoryBot.build(:kanzume_icon, name: nil)
    no_name_kanzume.valid?
    expect(no_name_kanzume.errors[:name]).to include("を入力してください")
  end

  describe "name max length" do
    context "name length is 30" do
      it "true" do
        kanzume_icon = FactoryBot.build(:kanzume_icon, name: "a" * 30)
        expect(kanzume_icon).to be_valid
      end
    end

    context "name length is 31" do
      it "false" do
        kanzume_icon = FactoryBot.build(:kanzume_icon, name: "a" * 31)
        expect(kanzume_icon).to be_invalid
      end
    end
  end
end
