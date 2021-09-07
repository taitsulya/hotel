# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomPolicy do
  subject { RoomPolicy.new(admin, room) }

  let(:room) { FactoryBot.create(:room) }

  context 'for an admin' do
    let(:admin) { FactoryBot.create(:admin) }
    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:new) }
    it { should permit(:edit) }
    it { should permit(:create) }
    it { should permit(:update) }
    it { should permit(:destroy) }
    it { should permit(:delete_image) }
  end

  context 'for a visitor' do
    let(:admin) { nil }
    it { should permit(:index) }
    it { should permit(:show) }
    it { should_not permit(:new) }
    it { should_not permit(:edit) }
    it { should_not permit(:create) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
    it { should_not permit(:delete_image) }
  end
end
