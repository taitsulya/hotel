# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(HomeController, type: :controller) do
  before do
    allow(controller).to(receive(:authorize).and_return(true))
  end

  describe 'before actions' do
    describe 'set_default_description' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:set_default_description))
      end
    end
  end

  # index action
  describe 'GET #index' do
    before do
      get :index
    end

    it 'is expected to assign home instance variable' do
      expect(assigns[:home]).to(eq(Home.first))
    end

    it 'renders index template' do
      is_expected.to(render_template(:index))
    end

    it 'renders application layout' do
      is_expected.to(render_template(:application))
    end
  end

  # update action
  describe 'PATCH #update' do
    before do
      patch :update, params: params
    end

    context 'when home exist in database' do
      let(:home) { FactoryBot.create(:home) }
      let(:params) { { id: home.id, home: { description: 'Some description' } } }

      context 'when data is provided is valid' do
        it 'is expected to update home' do
          expect(home.reload.description).to(eq('Some description'))
        end

        it 'is_expected to redirect_to root_path' do
          is_expected.to(redirect_to(root_path))
        end

        it 'is expected to set flash message' do
          expect(flash[:notice]).to(eq('Description was successfully updated.'))
        end
      end
    end
  end
end
