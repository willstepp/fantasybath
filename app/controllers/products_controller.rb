class ProductsController < ApplicationController
  http_basic_authenticate_with(:name => ENV['WORKSHOP_USER'], :password => ENV['WORKSHOP_PSWD']) if Rails.env == "production"

  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new
    @product_types = ProductType.all
    @scents = Scent.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
    @product_types = ProductType.all
    @scents = Scent.all
  end

  def create
    @product = Product.new(params[:product])

    scents = params[:scents]
    if !scents.nil?
      scents.each do |scent|
        s = Scent.find(scent)
        @product.scents << s
      end
    end

    respond_to do |format|
      if @product.save
        format.html { flash[:notice] = 'Product was successfully created.'; redirect_to product_images_path @product }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.scents.clear

    scents = params[:scents]
    if !scents.nil?
      scents.each do |scent|
        s = Scent.find(scent)
        @product.scents << s
      end
    @product.save
    end

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def images
    @product = Product.find(params[:id])
  end

  def upload_image
    @product = Product.find(params[:id])
    if params[:image]
      image_id = params[:image_id]
      if image_id
        image = Image.find(image_id)

        #first remove old file
        filepath = AWSHelper.generate_path_for(:product, @product, image.filename)
        AWSHelper.delete_from_s3(filepath)

        image.filename = params[:image].original_filename
        image.save
      else
        @product.images << Image.create(:filename => params[:image].original_filename, :type => :product)
        @product.save
      end

      filepath = AWSHelper.generate_path_for(:product, @product, params[:image].original_filename)
      AWSHelper.upload_to_s3(params[:image], filepath)
    end
    
    redirect_to product_images_path @product
  end

  def delete_image
    @product = Product.find(params[:id])
    @image = Image.find(params[:image_id])

    filepath = AWSHelper.generate_path_for(:products, @product, @image.filename)
    AWSHelper.delete_from_s3(filepath)

    @image.destroy

    redirect_to product_images_path @product
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
