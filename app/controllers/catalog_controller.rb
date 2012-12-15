class CatalogController < ApplicationController
  def index
    @category_type = params[:catalog_type].nil? ? :products : params[:catalog_type].to_sym
    if @category_type == :products
      @products = Product.all
      if params[:f]
        @products = @products.find_all { |p| p.product_type.nil? ? false : p.product_type.id.to_s == params[:f] }
        @selected_product_type = params[:f]
      end
      @product_types = ProductType.all
    else
      @category_type = :scents
      @scents = Scent.all
      if params[:f]
        @scents = @scents.find_all do |s| 
          if s.scent_categories.empty?
            false
          else
            ids = s.scent_categories.map { |sc| sc.id.to_s }
            ids.include? params[:f]
          end
        end
        @selected_scent_category = params[:f]
      end
      @scent_categories = ScentCategory.all
    end
  end

  def scent
    @page_name = "Scent"

    @scent = Scent.where(:slug => params[:id]).first
    if @scent.nil?
      @scent = Scent.find(params[:id])
    end
  end

  def product
    @page_name = "Product"
    
    @product = Product.where(:slug => params[:id]).first
    if @product.nil?
      @product = Product.find(params[:id])
    end
  end
end
