class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # implement HTTP basic auth here?
  
  private
  
  # in this controller, this is the part which defines the cookie
  # ":cart" 
  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
    # puts '@enhanced_cart:'
    # puts @enhanced_cart
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # method to handle the current logged in user from the maina pplication controller
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # method to handle the current logged in user from the maina pplication controller
  def authorize
    redirect_to '/login' unless current_user
  end

end


