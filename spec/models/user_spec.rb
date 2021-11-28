require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    it "nicknameとemail,passwordとpassword_confirmationが存在すれば登録できる" do
      expect(@user).to be_valid
    end
    it "nicknameが空では登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it "emailがからでは登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it "passwordがからでは登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it "passwordとpassword_confirmationが不一致では登録できない" do
      @user.password_confirmation = Faker::Internet.password(min_length: 6)
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it "nicknameが7文字以上では登録できない" do
      @user.nickname = "aaaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname is too long (maximum is 6 characters)"
    end
    it "重複したemailが存在する場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "passwordが5文字以下では登録できない" do
      @user.password = Faker::Internet.password(min_length: 0, max_length: 5)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
  end
end