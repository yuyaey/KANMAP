require 'rails_helper'

RSpec.describe User, type: :model do

  context "when user is valid" do
    it "is valid with a name, email, and password" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
    it "is invalid without a email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

  end

  context "when email format is invalid" do
    it "emailのvalidateが正しく機能する" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
      end
    end
  end

  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, 
      email: "aaron@example.com",
    )
    user = FactoryBot.build(:user, 
      email: "aaron@example.com",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "emailを小文字に変換後の値と大文字を混ぜて登録されたアドレスが同じか" do
    user = FactoryBot.create(:user, 
      email: "Foo@ExAMPle.CoM",
    )
    expect(user.reload.email).to eq "foo@example.com"
  end

  describe "name max length" do
    context "name length is 30" do
      it "true" do
        user = FactoryBot.build(:user, name: "a" * 30)
        expect(user).to be_valid
      end
    end

    context "name length is 31" do
      it "false" do
        user = FactoryBot.build(:user, name: "a" * 31)
        expect(user).to be_invalid
      end
    end
  end

end
