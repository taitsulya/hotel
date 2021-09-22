# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :set_booking, only: %i[update destroy]
  before_action :current_room, :current_room_images, only: %i[new create show]

  def index
    @bookings = Booking.all.order(created_at: :desc)
    authorize(@bookings)
    actual_bookings = @bookings.where(actual: true)
    respond_to do |format|
      format.html
      format.csv { send_data(actual_bookings.to_csv) }
      format.xlsx { send_data(actual_bookings.to_xlsx) }
    end
  end

  def show
    redirect_to(rooms_path) unless @booking
  end

  def new
    @booking = @room.bookings.build
    authorize(@booking)
  end

  def create
    @booking = @room.bookings.build(booking_params)
    authorize(@booking)
    respond_to do |format|
      if @booking.save
        format.html do
          flash.now[:notice] = 'Booking was successfully created.'
          render(:show)
        end
        format.json { render(:show, status: :created, location: @booking) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @booking.errors, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to(bookings_url, notice: 'Booking was successfully updated.') }
        format.json { render(:index, status: :ok, location: @booking) }
      else
        format.html { render(:index, status: :unprocessable_entity) }
        format.json { render(json: @booking.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to(bookings_url, notice: 'Booking was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize(@booking)
  end

  def current_room
    @room = Room.find(params[:room_id])
  end

  def current_room_images
    @images = @room.images
  end

  def booking_params
    params.require(:booking).permit(:name, :email, :mobile_phone, :arrival, :departure, :room_id, :actual)
  end
end
