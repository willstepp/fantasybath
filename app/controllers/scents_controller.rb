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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scent }
    end
  end

  def edit
    @scent = Scent.find(params[:id])
  end

  def create
    @scent = Scent.new(params[:scent])

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
end
