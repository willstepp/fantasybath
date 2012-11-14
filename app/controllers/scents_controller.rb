class ScentsController < ApplicationController
  http_basic_authenticate_with(:name => ENV['WORKSHOP_USER'], :password => ENV['WORKSHOP_PSWD']) if Rails.env == "production"

  def index
    @scents = Scent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scents }
    end
  end

  def show
    @scent = Scent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scent }
    end
  end

  def new
    @scent = Scent.new
    @products = Product.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scent }
    end
  end

  def edit
    @scent = Scent.find(params[:id])
    @products = Product.all
  end

  def create
    @scent = Scent.new(params[:scent])
    @prices = params[:prices].nil? ? [] : params[:prices].reject { |p| p.empty? }

    products = params[:products]
    if !products.nil?
      products.each_with_index do |product, i|
        p = Product.find(product)
        @scent.products << p
        if !@prices[i].nil?
          @scent.prices << Price.create(:amount => @prices[i].to_f, :product_id => p.id)
        end
      end
    end

    respond_to do |format|
      if @scent.save
        format.html { redirect_to @scent, notice: 'Scent was successfully created.' }
        format.json { render json: @scent, status: :created, location: @scent }
      else
        format.html { render action: "new" }
        format.json { render json: @scent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @scent = Scent.find(params[:id])
    @scent.products.clear
    @scent.prices.clear

    @prices = params[:prices].nil? ? [] : params[:prices].reject { |p| p.empty? }

    products = params[:products]
    if !products.nil?
      products.each_with_index do |product, i|
        p = Product.find(product)
        @scent.products << p
        if !@prices[i].nil?
          @scent.prices << Price.create(:amount => @prices[i].to_f, :product_id => p.id)
        end
      end
      @scent.save
    end

    respond_to do |format|
      if @scent.update_attributes(params[:scent])
        format.html { redirect_to @scent, notice: 'Scent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @scent = Scent.find(params[:id])
    @scent.destroy

    respond_to do |format|
      format.html { redirect_to scents_url }
      format.json { head :no_content }
    end
  end

  def icon
    @scent = Scent.find(params[:id])
  end

  def upload_icon
    @scent = Scent.find(params[:id])
    if params[:image]
      image_id = params[:image_id]
      if image_id
        image = Image.find(image_id)

        #first remove old file
        filepath = AWSHelper.generate_path_for(:scent, @scent, image.filename)
        AWSHelper.delete_from_s3(filepath)

        image.filename = params[:image].original_filename
        image.save
      else
        @scent.images << Image.create(:filename => params[:image].original_filename, :type => :scent)
        @scent.save
      end

      filepath = AWSHelper.generate_path_for(:scent, @scent, params[:image].original_filename)
      AWSHelper.upload_to_s3(params[:image], filepath)
    end
    
    redirect_to scent_icon_path @scent
  end

  def delete_icon
    @scent = Scent.find(params[:id])
    @image = Image.find(params[:image_id])

    filepath = AWSHelper.generate_path_for(:scent, @scent, @image.filename)
    AWSHelper.delete_from_s3(filepath)

    @image.destroy

    redirect_to scent_icon_path @scent
  end
end
