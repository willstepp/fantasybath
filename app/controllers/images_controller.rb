class ImagesController < ApplicationController
  before_filter :get_return

  def detail
    @product = Product.find(params[:product_id])
    @scent = Scent.find(params[:scent_id])

    @image = Image.all_of({:product_id => params[:product_id]}, {:scent_id => params[:scent_id]}).first
  end

  def upload_detail
    @product = Product.find(params[:product_id])
    @scent = Scent.find(params[:scent_id])
    if params[:image]
      image_id = params[:image_id]
      if image_id
        @image = Image.find(image_id)

        #first remove old file
        filepath = AWSHelper.generate_path_for(:detail, @image, @image.filename)
        AWSHelper.delete_from_s3(filepath)

        @image.filename = params[:image].original_filename
        @image.save
      else
        @image = Image.create(:product_id => @product.id, :scent_id => @scent.id, :type => :detail, :filename => params[:image].original_filename)
      end

      filepath = AWSHelper.generate_path_for(:detail, @image, params[:image].original_filename)
      AWSHelper.upload_to_s3(params[:image], filepath)
    end
    
    redirect_to image_detail_path(@product.id, @scent.id, :r => @return)
  end

  def delete_detail
    @image = Image.find(params[:image_id])

    filepath = AWSHelper.generate_path_for(:detail, @image, @image.filename)
    AWSHelper.delete_from_s3(filepath)

    @image.destroy

    redirect_to image_detail_path(@image.product.id, @image.scent.id, :r => @return)
  end

  protected

  def get_return
    @return = params[:r].to_sym
  end
end
