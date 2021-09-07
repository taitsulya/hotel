# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingPolicy do
  subject { BookingPolicy.new(admin, booking) }

  let(:room) { FactoryBot.create(:room) }
  let(:booking) { FactoryBot.create(:booking, room_id: room.id) }

  context 'for an admin' do
    let(:admin) { FactoryBot.create(:admin) }
    it { should permit(:index) }
    it { should_not permit(:show) }
    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'for a visitor' do
    let(:admin) { nil }
    it { should_not permit(:index) }
    it { should permit(:show) }
    it { should permit(:new) }
    it { should permit(:create) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end
end
