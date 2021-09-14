# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(BookingsController, type: :controller) do
  before do
    allow(controller).to(receive(:authorize).and_return(true))
  end

  describe 'before actions' do
    describe 'set_booking' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:set_booking))
      end
    end

    describe 'current_room' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:current_room))
      end
    end

    describe 'current_room_images' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:current_room_images))
      end
    end
  end

  # index action
  describe 'GET #index' do
    before do
      get :index
    end

    it 'is expected to assign booking instance variable' do
      expect(assigns[:bookings]).to(match_array(Booking.all))
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

    context 'when no booking given' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { room_id: room.id } }

      it 'is expected to redirect to rooms path' do
        is_expected.to(redirect_to(rooms_path))
      end
    end
  end

  # new action
  describe 'GET #new' do
    before do
      get :new, params: params
    end

    context 'when room is present' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { room_id: room.id } }

      it 'is expected to assign booking as new instance variable' do
        expect(assigns[:booking]).to(be_instance_of(Booking))
      end

      it 'renders new template' do
        is_expected.to(render_template(:new))
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
      let(:params) do
        {
          booking:
            {
              name: 'Some name',
              email: 'Some email',
              mobile_phone: '88005553535',
              arrival: Date.current,
              departure: Date.current
            },
          room_id: room.id
        }
      end

      it 'is expected to create new booking successfully' do
        expect(assigns[:booking]).to(be_instance_of(Booking))
      end

      it 'is expected to have name assigned to it' do
        expect(assigns[:booking].name).to(eq('Some name'))
      end

      it 'is expected to have email assigned to it' do
        expect(assigns[:booking].email).to(eq('Some email'))
      end

      it 'is expected to have mobile_phone assigned to it' do
        expect(assigns[:booking].mobile_phone).to(eq('88005553535'))
      end

      it 'is expected to have arrival assigned to it' do
        expect(assigns[:booking].arrival).to(eq(Date.current))
      end

      it 'is expected to have departure assigned to it' do
        expect(assigns[:booking].departure).to(eq(Date.current))
      end

      it 'is expected to have room_id assigned to it' do
        expect(assigns[:booking].room_id).to(eq(room.id))
      end

      it 'is expected to render show template' do
        is_expected.to(render_template(:show))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Booking was successfully created.'))
      end
    end

    context 'when params are not correct' do
      let(:room) { FactoryBot.create(:room) }
      let(:params) { { booking: { name: '' }, room_id: room.id } }

      it 'is expected to render new template' do
        is_expected.to(render_template(:new))
      end

      it 'is expected to add errors to name attribute' do
        expect(assigns[:booking].errors[:name]).to(eq(['can\'t be blank']))
      end
    end
  end

  # update action
  describe 'PATCH #update' do
    before do
      patch :update, params: params
    end

    context 'when booking exist in database' do
      let(:room) { FactoryBot.create(:room) }
      let(:booking) { FactoryBot.create(:booking, room_id: room.id) }
      let(:params) do
        { id: booking.id, booking:
          {
            name: 'Some name',
            email: 'Some email',
            mobile_phone: '88005553535',
            arrival: Date.current,
            departure: Date.current
          }, room_id: room.id }
      end

      context 'when data provided is valid' do
        it 'is expected to update booking' do
          expect(booking.reload.name).to(eq('Some name'))
          expect(booking.reload.email).to(eq('Some email'))
          expect(booking.reload.mobile_phone).to(eq('88005553535'))
          expect(booking.reload.arrival).to(eq(Date.current))
          expect(booking.reload.departure).to(eq(Date.current))
          expect(booking.reload.room_id).to(eq(room.id))
        end

        it 'is_expected to redirect_to bookings_path' do
          is_expected.to(redirect_to(bookings_path))
        end

        it 'is expected to set flash message' do
          expect(flash[:notice]).to(eq('Booking was successfully updated.'))
        end
      end

      context 'when data is invalid' do
        let(:room) { FactoryBot.create(:room) }
        let(:booking) { FactoryBot.create(:booking, room_id: room.id) }
        let(:params) do
          { id: booking.id, booking: { name: '' }, room_id: room.id }
        end

        it 'is expected not to update booking name' do
          expect(booking.reload.name).not_to(be_empty)
        end

        it 'is expected to render index template' do
          expect(response).to(render_template(:index))
        end

        it 'is expected to add errors to booking name attribute' do
          expect(assigns[:booking].errors[:name]).to(eq(['can\'t be blank']))
        end
      end
    end
  end

  # destroy action
  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: params
    end

    context 'when booking exist in database' do
      let(:room) { FactoryBot.create(:room) }
      let(:booking) { FactoryBot.create(:booking, room_id: room.id) }
      let(:params) { { id: booking.id } }

      it 'is expected to delete booking successfully' do
        expect(Booking.count).to(eq(0))
      end

      it 'checks that booking was destroyed' do
        expect(Booking.find_by(id: booking.id)).to(be_nil)
      end

      it 'is expected to redirect_to bookings_path' do
        is_expected.to(redirect_to(bookings_path))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Booking was successfully destroyed.'))
      end
    end
  end
end
