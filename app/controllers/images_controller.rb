# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_image, only: :destroy
  before_action :set_images, only: %i[index edit]
  before_action :current_room

  def index; end

  def edit; end

  def create
    @image = @room.images.build(image_params)
    authorize(@image)

    respond_to do |format|
      if @image.save
        format.html { redirect_to("#{room_images_path(@room)}/edit", notice: 'Image was successfully uploaded.') }
        format.json { render(:show, status: :created, location: @image) }
      else
        format.html { render(:index, status: :unprocessable_entity) }
        format.json { render(json: @image.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to(room_images_url, notice: 'Image was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_image
    @image = Image.find(params[:id])
    authorize(@image)
  end

  def set_images
    @images = @room.images
    authorize @images
  end

  def current_room
    @room = Room.find(params[:room_id])
  end

  def image_params
    params.require(:image).permit(:room_image, :room_id)
  end
end
