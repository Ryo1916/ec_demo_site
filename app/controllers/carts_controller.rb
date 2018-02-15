class CartsController < ApplicationController
  def new
    @cart = Cart.new
  end

  def show
    @product = Product.find(@cart.product_id)
    @cart = Cart.where(:user_id => session[:uid]).order("id desc").first
    # above line is equal to the below line.
    # @cart = Cart.where(:user_id => session[:uid]).last

  # If use product name, it's not unique id, so it cannot use as a display the product image.
  # When you use product name as a reference, you cannot display the image because of duplication of the product name.
    # names = @cart.product_name
    # @product = Product.find_by(:name => names)
  end

  def index
    @carts = Cart.where(:user_id => session[:uid]).all
    @total = 0
    # @images = []
    # @carts.each do |cart|
    #   names = cart.product_name
    #   product = Product.find_by(:name => names)
    #   @images.push(product.img_name)
    # end
  end

  def create
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
    params.require(:cart).permit(:user_id, :product_id, :product_name, :price, :quantity, :total)
  end
end
