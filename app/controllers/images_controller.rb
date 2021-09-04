# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_image, only: :destroy
  before_action :current_room

  # GET /images or /images.json
  def index
    @images = @room.images
    authorize @images
  end

  def edit
    @images = @room.images
    authorize @images
  end

  # POST /images or /images.json
  def create
    @image = @room.images.build(image_params)
    authorize @image

    respond_to do |format|
      if @image.save
        format.html { redirect_to "#{room_images_path(@room)}/edit", notice: 'Image was successfully uploaded.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to room_images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
    authorize @image
  end

  def current_room
    @room = Room.find(params[:room_id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:room_image, :room_id)
  end
end
