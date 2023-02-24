class BidsController < ApplicationController
  before_action :check_user

  def bid
    new_bid = CreateBid.new(params: bid_params)

    json_response = if new_bid.update
                      { message: 'Bid created successfully', status: :ok }
                    else
                      { message: new_bid.errors, status: :unprocessable_entity }
                    end

    render json: json_response, status: json_response[:status]
  end

  def view
    render json: view_response, status: :ok
  end

  private

  def bid_params
    params.permit(:user_id, :amount)
  end

  def view_response
    return current_bid_response.merge(highest_bid_response) unless params[:user_id].nil?

    highest_bid_response
  rescue NoMethodError
    { message: 'No bids yet' }
  end

  def current_bid_response
    {
      current_bid: {
        amount: Bid.current_by_user(params[:user_id]).amount
      }
    }
  end

  def highest_bid_response
    {
      highest_bid: {
        amount: higher_bid.amount,
        owner: higher_bid.user_id == params[:user_id].to_i
      }
    }
  end

  def higher_bid
    Bid.higher
  end

  def check_user
    return true if params[:user_id].nil?

    return if User.exists?(params[:user_id])

    render json: { error_message: 'User not found' }, status: :not_found
  end
end
