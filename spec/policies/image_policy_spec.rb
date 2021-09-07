# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagePolicy do
  subject { ImagePolicy.new(admin, image) }

  let(:room) { FactoryBot.create(:room) }
  let(:image) { FactoryBot.create(:image, room_id: room.id) }

  context 'for an admin' do
    let(:admin) { FactoryBot.create(:admin) }
    it { should permit(:index) }
    it { should permit(:edit) }
    it { should permit(:create) }
    it { should permit(:destroy) }
  end

  context 'for a visitor' do
    let(:admin) { nil }
    it { should permit(:index) }
    it { should_not permit(:edit) }
    it { should_not permit(:create) }
    it { should_not permit(:destroy) }
  end
end
