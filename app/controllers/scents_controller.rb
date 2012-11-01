class ScentsController < ApplicationController
  http_basic_authenticate_with(:name => ENV['WORKSHOP_USER'], :password => ENV['WORKSHOP_PSWD']) if Rails.env == "production"
  # GET /scents
  # GET /scents.json
  def index
    @scents = Scent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scents }
    end
  end

  # GET /scents/1
  # GET /scents/1.json
  def show
    @scent = Scent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scent }
    end
  end

  # GET /scents/new
  # GET /scents/new.json
  def new
    @scent = Scent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scent }
    end
  end

  # GET /scents/1/edit
  def edit
    @scent = Scent.find(params[:id])
  end

  # POST /scents
  # POST /scents.json
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

  # PUT /scents/1
  # PUT /scents/1.json
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

  # DELETE /scents/1
  # DELETE /scents/1.json
  def destroy
    @scent = Scent.find(params[:id])
    @scent.destroy

    respond_to do |format|
      format.html { redirect_to scents_url }
      format.json { head :no_content }
    end
  end
end
