class OrdersController < ApplicationController

  def new
    @user = User.find(session[:uid])
    @order = Order.new
    @carts = Cart.where(:user_id => session[:uid]).all
    @total = 0
  end

  def show

  end

  def check

  end

  def create
    @order = Order.new(order_params)
    @order.save
    @carts = Cart.where(:user_id => session[:uid]).all
    @carts.each do |cart|
      cart.destroy
    end
  # you can also use...
    # Cart.where(user_id: session[:uid]).destroy_all
    redirect_to("/orders/complete")
  end

  private

    def order_params
      params.require(:order).permit(:username, :phone, :address, :email, :delivery, :payment, :gift)
    end
end
