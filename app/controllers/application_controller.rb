# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  alias current_user current_admin

  rescue_from Pundit::NotAuthorizedError, with: :not_admin

  private

  def not_admin
    flash[:warning] = t('not_permitted')
    redirect_to(request.referer || root_path)
  end
end
