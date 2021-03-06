# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[update destroy]

  def index
    @reviews = Review.order(created_at: :desc)
    @reviews = Review.checked_and_sorted unless current_admin
    authorize(@reviews)
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    authorize(@review)
    respond_to do |format|
      if @review.save
        format.html do
          redirect_to(reviews_url, notice: 'Review was successfully created. It will be checked by admin.')
        end
        format.json { render(:index, status: :created, location: @review) }
      else
        format.html do
          @reviews = Review.checked_and_sorted
          render(:index, status: :unprocessable_entity)
        end
        format.json { render(json: @review.errors, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html do
          flash[:notice] =
            if review_params[:checked] == '1'
              'Review was checked. It will be displayed to users.'
            else
              "Review was unchecked. It won't be displayed to users."
            end
          redirect_to(reviews_url)
        end
        format.json { render(:index, status: :ok, location: @review) }
      else
        format.html { render(:index, status: :unprocessable_entity) }
        format.json { render(json: @review.errors, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to(reviews_url, notice: 'Review was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
    authorize(@review)
  end

  def review_params
    params.require(:review).permit(:author_name, :author_email, :body, :checked)
  end
end
