require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      let(:bid) { create(:bid) }

      it 'should save' do
        expect(bid).to be_valid
      end
    end

    context 'with invalid parms' do
      context 'with invalid user' do
        let(:bid) { build(:bid, user: nil) }

        it 'should not save' do
          expect(bid).to_not be_valid
        end
      end

      context 'with invalid amount' do
        let(:bid) { build(:bid, amount: amount) }

        context 'with nil value' do
          let(:amount) { nil }
          it 'should not save' do
            expect(bid).to_not be_valid
          end
        end

        context 'with invalid value' do
          let(:amount) { 'invalid' }
          it 'should not save' do
            expect(bid).to_not be_valid
          end
        end
      end
    end
  end
end
