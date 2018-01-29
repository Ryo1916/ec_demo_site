class ProductsController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :js, :json, :html

  # GET /products
  # GET /products.json
  def index
    @user = User.new
    @products = Product.all
    @cats = Cat.all
    @temps = Product.where(category_id: params[:id])
    if @temps.blank?
      respond_to do |format|
        format.html
        format.json { render json: @products }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: @temps }
      end
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @products = Product.where(:category_id => @product.category_id).all

    @user = User.new
    @admin = User.find_by(id: 2)
    @cart = Cart.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :category_id, :img_name)
    end
end
