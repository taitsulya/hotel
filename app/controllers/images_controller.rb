# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_image, only: :destroy
  before_action :current_room

  def index
    @images = @room.images
    authorize @images
  end

  def edit
    @images = @room.images
    authorize @images
  end

  def create
    @image = @room.images.build(image_params)
    authorize @image

    respond_to do |format|
      if @image.save
        format.html { redirect_to "#{room_images_path(@room)}/edit", notice: t('images.uploaded') }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to room_images_url, notice: t('images.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_image
    @image = Image.find(params[:id])
    authorize @image
  end

  def current_room
    @room = Room.find(params[:room_id])
  end

  def image_params
    params.require(:image).permit(:room_image, :room_id)
  end
end
