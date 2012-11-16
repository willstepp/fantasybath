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
    @scent_categories = ScentCategory.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scent }
    end
  end

  def edit
    @scent = Scent.find(params[:id])
    @products = Product.all
    @scent_categories = ScentCategory.all
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

    scent_categories = params[:scent_categories]
    if !scent_categories.nil?
      scent_categories.each do |scent_category|
        sc = ScentCategory.find(scent_category)
        @scent.scent_categories << sc
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
    @scent.scent_categories.clear

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

    scent_categories = params[:scent_categories]
    if !scent_categories.nil?
      scent_categories.each do |scent_category|
        sc = ScentCategory.find(scent_category)
        @scent.scent_categories << sc
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

  #Scent Categories

  def scent_categories
    @scent_categories = ScentCategory.all
  end

  def new_scent_category
  end

  def create_scent_category
    name = params[:name]
    sc = ScentCategory.where(:name => name).first
    if sc.nil? and !name.blank?
      sc = ScentCategory.create(:name => name)
      redirect_to scent_categories_path
    else
      redirect_to new_scent_category_path
    end
  end

  def edit_scent_category
    @sc = ScentCategory.find(params[:id])
  end

  def update_scent_category
    @sc = ScentCategory.find(params[:id])
    @sc.update_attributes(params)
    if @sc.valid?
      flash[:notice] = "Success"
      redirect_to scent_categories_path
    else
      flash[:error] = @sc.errors.full_messages
      redirect_to edit_scent_categories_path(@sc)
    end
  end

  def destroy_scent_category
    @sc = ScentCategory.find(params[:id])
    @sc.destroy
    redirect_to scent_categories_path
  end
end
