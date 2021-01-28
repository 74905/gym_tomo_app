require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Factory::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は○' do
        user.name = Factory::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '15文字以下であること: 15文字○' do
        user.name = Factory::Lorem.characters(number: 15)
        is_expected.to eq true
      end
      it '15文字以下であること: 16文字×' do
        user.name = Factory::Lorem.characters(number: 16)
        is_expected.to false
      end
    end

    describe 'アソシエーションテスト' do
      context 'Chatsモデルとの関係' do
        it '1対Nになっている' do
          expect(User.reflect_on_association(:chats).macro).to eq :has_many
        end
      end

      context 'UserRoomモデルとの関係' do
        it '1対Nになっている' do
          expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
        end
      end
    end
  end
end
