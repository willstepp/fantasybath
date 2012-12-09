class CatalogController < ApplicationController
  def index
    @category_type = params[:catalog_type].nil? ? :products : params[:catalog_type].to_sym
    if @category_type == :products
      @products = Product.all
    else
      @category_type = :scents
      @scents = Scent.all
    end
  end

  def scent
    @scent = Scent.where(:slug => params[:id]).first
    if @scent.nil?
      @scent = Scent.find(params[:id])
    end
  end

  def product
    @product = Product.where(:slug => params[:id]).first
    if @product.nil?
      @product = Product.find(params[:id])
    end
  end
end
