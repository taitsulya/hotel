# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise Pundit::NotAuthorizedError
    end
  end

  describe 'handling NotAuthorizedError' do
    before do
      get :index
    end

    it 'redirects to request.referer or root_path' do
      expect(response).to redirect_to(request.referer || root_path)
    end

    it 'is expected to set flash warning' do
      expect(flash[:warning]).to eq('You don\'t have permissions to perform this action.')
    end
  end
end
