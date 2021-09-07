# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_default_description

  def index
    @home = Home.first
    @images = Image.all
    @rooms = Room.where.not(main_image: nil)
  end

  def update
    if Home.first.update(home_params)
      redirect_to root_path, notice: 'Description was successfully updated.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_default_description
    Home.create(description: 'The best hotel ever') if Home.all.count.zero?
  end

  def home_params
    params.require(:home).permit(:description)
  end
end
