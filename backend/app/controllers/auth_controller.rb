class AuthController < ApplicationController
        skip_before_action :check_authentication
        # , only: [:login, :customer_login_params]
        
          
        def login
          # byebug
          customer = Customer.find_by(name: params[:name])
          # byebug
           if customer && customer.authenticate(params[:password])

            render json: { name: customer.name, customerId: customer.id, token: encode_token({ customer_id: customer.id })
          }
          else
                render json: { 
                    error: 'Invalid password' 
                    }
          end
        end


        private
 
  def customer_login_params
    params.permit(:customer).permit(:name, :password)
  end


end

      

