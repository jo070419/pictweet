require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe "ツイートの保存" do
    context "ツイートが投稿できる場合" do
      it "画像とテキストを投稿できる" do
        expect(@tweet).to be_valid
      end
      it "テキストのみで投稿できる" do
        @tweet.image = ""
        expect(@tweet).to be_valid
      end
    end
    context "ツイートが保存できない場合" do
      it "テキストが空では投稿できない" do
      end
      it "ユーザーが紐付いてなければ投稿できない" do
      end
    end
  end
end
