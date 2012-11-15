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

    @prices = params[:prices].nil? ? [] : params[:prices].reject { |p| p.empty? }

    scents = params[:scents]
    if !scents.nil?
      scents.each_with_index do |scent, i|
        s = Scent.find(scent)
        @product.scents << s
        if !@prices[i].nil?
          @product.prices << Price.create(:amount => @prices[i].to_f, :scent_id => s.id)
        end
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
    @product.prices.clear

    @prices = params[:prices].nil? ? [] : params[:prices].reject { |p| p.empty? }

    scents = params[:scents]
    if !scents.nil?
      scents.each_with_index do |scent, i|
        s = Scent.find(scent)
        @product.scents << s
        if !@prices[i].nil?
          @product.prices << Price.create(:amount => @prices[i].to_f, :scent_id => s.id)
        end
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

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  #Images

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

    filepath = AWSHelper.generate_path_for(:product, @product, @image.filename)
    AWSHelper.delete_from_s3(filepath)

    @image.destroy

    redirect_to product_images_path @product
  end

  #Upgrades

  def upgrades
    @product = Product.find(params[:product_id])
  end

  def new_upgrade
    @product = Product.find(params[:product_id])
  end

  def create_upgrade
    p = Product.find(params[:product_id])
    u = Upgrade.create(params)
    if u.valid?
      p.upgrades << u
      p.save
      redirect_to upgrades_path(p, u)
    else
      flash[:errors] = u.errors.full_messages
      redirect_to new_upgrade_path(p)
    end
  end

  def edit_upgrade
    @product = Product.find(params[:product_id])
    @upgrade = Upgrade.find(params[:id])
  end

  def update_upgrade
    p = Product.find(params[:product_id])
    u = Upgrade.find(params[:id])
    if u.update_attributes(params)
      flash[:notice] = "Upgrade has been updated"
      redirect_to upgrades_path(p)
    else
      flash[:errors] = u.errors.full_messages
      redirect_to edit_upgrade_path(p, u)
    end
  end

  def destroy_upgrade
    p = Product.find(params[:product_id])
    u = Upgrade.find(params[:id])
    u.destroy

    flash[:notice] = "Upgrade has been deleted"
    redirect_to upgrades_path(p)
  end

  #Product Types

  def product_types
    @product_types = ProductType.all
  end

  def create_product_type
  end

  def update_product_type
  end

  def destroy_product_type
  end
end
