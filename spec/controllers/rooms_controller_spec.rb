# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(RoomsController, type: :controller) do
  before do
    allow(controller).to(receive(:authorize).and_return(true))
  end

  describe 'before actions' do
    describe 'set_room' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:set_room))
      end
    end
  end

  # index action
  describe 'GET #index' do
    before do
      get :index
    end

    it 'is expected to assign room instance variable' do
      expect(assigns[:rooms]).to(match_array(Room.all))
    end

    it 'renders index template' do
      is_expected.to(render_template(:index))
    end

    it 'renders application layout' do
      is_expected.to(render_template(:application))
    end
  end

  # show action
  describe 'GET #show' do
    before do
      get :show, params: params
    end

    context 'when room id is valid' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { id: room.id } }

      it 'is expected to set room instance variable' do
        expect(assigns[:room]).to(eq(Room.find_by(id: params[:id])))
      end

      it 'is expected to render show template' do
        is_expected.to(render_template(:show))
      end
    end
  end

  # new action
  describe 'GET #new' do
    before do
      get :new
    end

    it 'is expected to assign room as new instance variable' do
      expect(assigns[:room]).to(be_instance_of(Room))
    end

    it 'renders new template' do
      is_expected.to(render_template(:new))
    end
  end

  # create action
  describe 'POST #create' do
    before do
      post :create, params: params
    end

    context 'when params are correct' do
      let(:params) do
        {
          room:
            {
              name: 'Some name',
              room_type: 'Some room_type',
              price: 100.0,
              short_description: 'Some short_description',
              full_description: 'Some full_description'
            }
        }
      end

      it 'is expected to create new room successfully' do
        expect(assigns[:room]).to(be_instance_of(Room))
      end

      it 'is expected to have name assigned to it' do
        expect(assigns[:room].name).to(eq('Some name'))
      end

      it 'is expected to have room_type assigned to it' do
        expect(assigns[:room].room_type).to(eq('Some room_type'))
      end

      it 'is expected to have price assigned to it' do
        expect(assigns[:room].price).to(eq(100.0))
      end

      it 'is expected to have short_description assigned to it' do
        expect(assigns[:room].short_description).to(eq('Some short_description'))
      end

      it 'is expected to have full_description assigned to it' do
        expect(assigns[:room].full_description).to(eq('Some full_description'))
      end

      it 'is expected to redirect to room path' do
        is_expected.to(redirect_to(room_path(assigns[:room].id)))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Room was successfully created.'))
      end
    end

    context 'when params are not correct' do
      let(:params) { { room: { name: '' } } }

      it 'is expected to render new template' do
        is_expected.to(render_template(:new))
      end

      it 'is expected to add errors to name attribute' do
        expect(assigns[:room].errors[:name]).to(eq(['can\'t be blank']))
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
      let(:params) { { id: room.id } }

      it 'is expected to set room instance variable' do
        expect(assigns[:room]).to(eq(Room.find_by(id: params[:id])))
      end

      it 'is expected to render edit template' do
        is_expected.to(render_template(:edit))
      end
    end
  end

  # update action
  describe 'PATCH #update' do
    before do
      patch :update, params: params
    end

    context 'when room exist in database' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) do
        { id: room.id, room:
        {
          name: 'Some name',
          room_type: 'Some room_type',
          price: 100.0,
          short_description: 'Some short_description',
          full_description: 'Some full_description'
        } }
      end

      context 'when data is provided is valid' do
        it 'is expected to update room' do
          expect(room.reload.name).to(eq('Some name'))
          expect(room.reload.room_type).to(eq('Some room_type'))
          expect(room.reload.price).to(eq(100.0))
          expect(room.reload.short_description).to(eq('Some short_description'))
          expect(room.reload.full_description).to(eq('Some full_description'))
        end

        it 'is_expected to redirect_to room_path' do
          is_expected.to(redirect_to(room_path))
        end

        it 'is expected to set flash message' do
          expect(flash[:notice]).to(eq('Room was successfully updated.'))
        end
      end

      context 'when data is invalid' do
        let(:room) { FactoryBot.create(:room) }
        let(:params) { { id: room.id, room: { name: '' } } }

        it 'is expected not to update room name' do
          expect(room.reload.name).not_to(be_empty)
        end

        it 'is expected to render edit template' do
          expect(response).to(render_template(:edit))
        end

        it 'is expected to add errors to room name attribute' do
          expect(assigns[:room].errors[:name]).to(eq(['can\'t be blank']))
        end
      end
    end
  end

  # destroy action
  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: params
    end

    context 'when room exist in database' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { id: room.id } }

      it 'is expected to delete room successfully' do
        expect(Room.count).to(eq(0))
      end

      it 'checks that room was destroyed' do
        expect(Room.find_by(id: room.id)).to(be_nil)
      end

      it 'is expected to redirect_to rooms_path' do
        is_expected.to(redirect_to(rooms_path))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Room was successfully destroyed.'))
      end
    end
  end

  # delete_image action
  describe 'PATCH #delete_image' do
    before do
      patch :delete_image, params: params
    end

    context 'when room exist in database' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { id: room.id } }

      context 'when data is provided is valid' do
        let(:params) { { id: room.id } }

        it 'is expected to update room' do
          expect(room.reload.main_image.url).to(eq(nil))
        end

        it 'is_expected to redirect_to room_path' do
          is_expected.to(redirect_to(edit_room_path(room.id)))
        end

        it 'is expected to set flash message' do
          expect(flash[:notice]).to(eq('Image was successfully deleted.'))
        end
      end
    end
  end
end
