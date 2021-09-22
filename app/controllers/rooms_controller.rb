# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy delete_image]

  def index
    @rooms = Room.order(updated_at: :desc)
    authorize(@rooms)
  end

  def show; end

  def new
    @room = Room.new
    authorize(@room)
  end

  def edit; end

  def create
    @room = Room.new(room_params)
    authorize(@room)

    respond_to do |format|
      if @room.save
        format.html { redirect_to(@room, notice: 'Room was successfully created.') }
        format.json { render(:show, status: :created, location: @room) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @room.errors, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to(@room, notice: 'Room was successfully updated.') }
        format.json { render(:show, status: :ok, location: @room) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @room.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to(rooms_url, notice: 'Room was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  def delete_image
    respond_to do |format|
      if @room.update(main_image: nil)
        format.html { redirect_to(edit_room_path, notice: 'Image was successfully deleted.') }
        format.json { render(:show, status: :ok, location: @room) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @room.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
    authorize(@room)
  end

  def room_params
    params.require(:room).permit(:name, :room_type, :price, :short_description, :full_description, :main_image)
  end
end
