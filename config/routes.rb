Rails.application.routes.draw do
  post 'bid', to: 'bids#bid', as: :bid
  get 'view/(:user_id)', to: 'bids#view', as: :view
end
