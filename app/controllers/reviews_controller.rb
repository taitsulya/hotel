# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[update destroy]

  # GET /reviews or /reviews.json
  def index
    @reviews = if current_admin
                 Review.all.order(created_at: :desc)
               else
                 Review.where(checked: true).order(created_at: :desc)
               end
    authorize @reviews
    @review = Review.new
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    authorize @review
    respond_to do |format|
      if @review.save
        format.html { redirect_to reviews_url, notice: 'Review was successfully created. It will be checked by admin.' }
        format.json { render :index, status: :created, location: @review }
      else
        format.html do
          @reviews = Review.where(checked: true).order(created_at: :desc)
          render :index, status: :unprocessable_entity
        end
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html do
          redirect_to reviews_url, notice: if review_params[:checked] == '1'
                                             'Review was checked. It will be displayed to users.'
                                           else
                                             "Review was unchecked. It won't be displayed to users."
                                           end
        end
        format.json { render :index, status: :ok, location: @review }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:author_name, :author_email, :body, :checked)
  end
end
