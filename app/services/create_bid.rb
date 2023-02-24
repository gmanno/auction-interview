# frozen_string_literal: true

class CreateBid
  def self.call(**args)
    new(**args).update
  end

  def initialize(params:)
    @params = params
    @user_id = params[:user_id]
    @amount = params[:amount]
    @errors = []
  end

  def update
    validate_required_params

    return false unless valid?

    validate_bid_amount
    validate_last_bid_user

    return false unless valid?

    new_bid = Bid.create(params)

    if new_bid.persisted?
      true
    else
      errors << new_bid.errors.full_messages
      false
    end
  end

  attr_accessor :params, :user_id, :amount, :errors

  private

  def valid?
    errors.empty?
  end

  def validate_last_bid_user
    return if last_bid.nil? || user_id.to_i != last_bid.user_id

    errors << 'You cannot bid twice in a row'
  end

  def validate_bid_amount
    return if last_bid.nil? || amount.to_f > last_bid.amount

    errors << 'You cannot bid less than the last bid'
  end

  def last_bid
    Bid.last
  end

  def validate_required_params
    errors << 'User id is required' if user_id.nil?
    errors << 'Amount is required' if amount.nil?
  end
end
