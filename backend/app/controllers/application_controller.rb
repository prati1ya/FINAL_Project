class ApplicationController < ActionController::API
    before_action :check_authentication
    # , only: [:purchases, :customers[:show, :delete, :profile]

   def encode_token(payload)
    JWT.encode(payload,'app_wide_secret_for_every_user')
   end

    def auth_header
        request.headers['Authorization']
    end

    def current_customer
    if decoded_token
    customer_id = decoded_token[0]["customer_id"]
    customer = Customer.find(id: customer_id)
    end
    end

    def decoded_token
    if auth_header
    token = auth_header.split(' ')[1]

    begin
        JWT.decode(token, 'app_wide_secret_for_every_user')[0]
    rescue JWT::DecodeError
        nil
     end
    end
   end

   def check_authentication
    render json: { error: 'Please log in' }, status: 401 if !logged_in?
  end

  def logged_in?
    !!current_customer
  end




end