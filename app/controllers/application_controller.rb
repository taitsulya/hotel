# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_admin

  private

  def pundit_user
    current_admin
  end

  def not_admin
    flash[:warning] = "You don't have permissions to perform this action."
    redirect_to(request.referer || root_path)
  end
end
