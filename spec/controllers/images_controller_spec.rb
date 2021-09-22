# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ImagesController, type: :controller) do
  before do
    allow(controller).to(receive(:authorize).and_return(true))
  end

  describe 'before actions' do
    describe 'set_image' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:set_image))
      end
    end

    describe 'current_room' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:current_room))
      end
    end
  end

  # index action
  describe 'GET #index' do
    before do
      get :index, params: params
    end

    context 'when room id is valid' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { room_id: room.id } }

      it 'is expected to assign image instance variable' do
        expect(assigns[:images]).to(match_array(room.images))
      end

      it 'renders index template' do
        is_expected.to(render_template(:index))
      end

      it 'renders application layout' do
        is_expected.to(render_template(:application))
      end
    end
  end

  # create action
  describe 'POST #create' do
    before do
      post :create, params: params
    end

    context 'when params are correct' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { image: { room_image: 'Some url' }, room_id: room.id } }

      it 'is expected to create new image successfully' do
        expect(assigns[:image]).to(be_instance_of(Image))
      end

      it 'is expected to have room_id assigned to it' do
        expect(assigns[:image].room_id).to(eq(room.id))
      end

      it 'is expected to redirect to images edit path' do
        is_expected.to(redirect_to("#{room_images_path(room)}/edit"))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Image was successfully uploaded.'))
      end
    end
  end

  # edit action
  describe 'GET #edit' do
    before do
      get :edit, params: params
    end

    context 'when room id is valid' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { room_id: room.id } }

      it 'is expected to render edit template' do
        is_expected.to(render_template(:edit))
      end
    end
  end

  # destroy action
  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: params
    end

    context 'when image exist in database' do
      let(:room) { FactoryBot.create(:room) }
      let(:image) { FactoryBot.create(:image, room_id: room.id) }
      let(:params) { { id: image.id, room_id: room.id } }

      it 'is expected to delete image successfully' do
        expect(Image.count).to(eq(0))
      end

      it 'checks that image was destroyed' do
        expect(Image.find_by(id: image.id)).to(be_nil)
      end

      it 'is expected to redirect_to room_images_url' do
        is_expected.to(redirect_to(room_images_url(room.id)))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Image was successfully destroyed.'))
      end
    end
  end
end
