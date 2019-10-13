require 'rails_helper'

RSpec.describe Kanzume, type: :model do

  let(:user) { FactoryBot.build(:user) }
  let(:kanzume_icon) { FactoryBot.build(:kanzume_icon) }

  it "is valid with a user, kanzume_icon, name" do
    kanzume = FactoryBot.build(:kanzume)
    expect(kanzume).to be_valid
  end

  context "when kanzume is valid" do

  it "is invalid without kanzume_icon" do
    no_icon_kanzume = FactoryBot.build(:kanzume, kanzume_icon: nil)
    no_icon_kanzume.valid?
    expect(no_icon_kanzume.errors[:kanzume_icon]).to include("を入力してください")
  end

  it "is invalid without name" do
    no_name_kanzume = FactoryBot.build(:kanzume, name: nil)
    no_name_kanzume.valid?
    expect(no_name_kanzume.errors[:name]).to include("を入力してください")
  end

  end

  it "does not allow duplicate kanzume name per user" do
    Kanzume.create(user: user, name: "Kanzume", kanzume_icon: kanzume_icon)
    second_kanzume =  Kanzume.new(user: user, name: "Kanzume", kanzume_icon: kanzume_icon)
    second_kanzume.valid?
    expect(second_kanzume.errors[:name]).to include("はすでに存在します")
  end

  it "allows two users to share a kanzume name" do
    new_kanzume = FactoryBot.build(:kanzume, 
      user: user,
      kanzume_icon: kanzume_icon,
      name: "Test Kanzume",
    )
    other_user = User.create(
      name: "Jane",
      email: "janetester@example.com",
      password: "password",
    )
    other_kanzume = other_user.kanzumes.build(
      name: "Test Kanzume",
      kanzume_icon: kanzume_icon,
    )
    expect(other_kanzume).to be_valid
  end

  describe "name max length" do
    context "name length is 30" do
      it "true" do
        kanzume = FactoryBot.build(:kanzume, name: "a" * 30)
        expect(kanzume).to be_valid
      end
    end

    context "name length is 31" do
      it "false" do
        kanzume = FactoryBot.build(:kanzume, name: "a" * 31)
        expect(kanzume).to be_invalid
      end
    end
  end
end
