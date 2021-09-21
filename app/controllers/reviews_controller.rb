# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[update destroy]

  def index
    @reviews = if current_admin
                 Review.all.order(created_at: :desc)
               else
                 Review.where(checked: true).order(created_at: :desc)
               end
    authorize @reviews
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    respond_to do |format|
      if @review.save
        format.html { redirect_to reviews_url, notice: t('reviews.created') }
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

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html do
          redirect_to reviews_url, notice: if review_params[:checked] == '1'
                                             t('reviews.checked')
                                           else
                                             t('reviews.unchecked')
                                           end
        end
        format.json { render :index, status: :ok, location: @review }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: t('reviews.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def review_params
    params.require(:review).permit(:author_name, :author_email, :body, :checked)
  end
end
