class CartsController < ApplicationController
  def new
    @cart = Cart.new
  end

  def show
    # @cart = Cart.find(params[:id])
    # @cart = Cart.where(:user_id => session[:uid]).order("id desc").first
    # names = @cart.product_name
    # @product = Product.find_by(:name => names)

    @carts = Cart.where(:user_id => session[:uid]).order("id desc")
    @total = 0
  end

  def index
    @carts = Cart.where(:user_id => session[:uid]).all

    # @images = []
    # @carts.each do |cart|
    #   names = cart.product_name
    #   product = Product.find_by(:name => names)
    #   @images.push(product.img_name)
    # end
  end

  def create
    # @product_id = 0
    @cart = Cart.new(carts_params)

    if session[:username].blank?
      redirect_to login_url
    else
      @cart.save
      if params[:buy_now]
        redirect_to("/orders/new")
      else
        redirect_to("/carts/show")
      end
    end
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.quantity = params[:quantity]
    @cart.save
    redirect_to("/carts/show")

    # @temp_cart = Cart.new(carts_params)
    # @cart = Cart.find_by(:id => @temp_cart.id)
    # @cart.destroy
    # @temp_cart.save
    # redirect_to("/carts/show")
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to("/carts/show")
  end

  def carts_params
    params.require(:cart).permit(:user_id, :product_name, :price, :quantity, :total)
  end
end
