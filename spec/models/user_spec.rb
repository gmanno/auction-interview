require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      let(:user) { create(:user) }

      it 'should save' do
        expect(user).to be_valid
      end
    end

    context 'with invalid name' do
      let(:user) { build(:user, name: nil) }

      it 'should not save' do
        expect(user).to_not be_valid
      end
    end

    context 'with invalid email' do
      let(:user) { build(:user, email: 'test') }

      it 'should not save' do
        expect(user).to_not be_valid
      end
    end
  end
end
