# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ReviewsController, type: :controller) do
  before do
    allow(controller).to(receive(:authorize).and_return(true))
  end

  describe 'before actions' do
    describe 'set_review' do
      it 'is expected to define before action' do
        is_expected.to(use_before_action(:set_review))
      end
    end
  end

  # index action
  describe 'GET #index' do
    before do
      get :index
    end

    it 'is expected to assign review instance variable' do
      expect(assigns[:reviews]).to(match_array(Review.all))
    end

    it 'renders index template' do
      is_expected.to(render_template(:index))
    end

    it 'renders application layout' do
      is_expected.to(render_template(:application))
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
          review:
            {
              author_name: 'Some author_name',
              author_email: 'Some author_email',
              body: 'Some body'
            }
        }
      end

      it 'is expected to create new review successfully' do
        expect(assigns[:review]).to(be_instance_of(Review))
      end

      it 'is expected to have author_name assigned to it' do
        expect(assigns[:review].author_name).to(eq('Some author_name'))
      end

      it 'is expected to have author_email assigned to it' do
        expect(assigns[:review].author_email).to(eq('Some author_email'))
      end

      it 'is expected to have body assigned to it' do
        expect(assigns[:review].body).to(eq('Some body'))
      end

      it 'is expected to redirect to reviews path' do
        is_expected.to(redirect_to(reviews_path))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Review was successfully created. It will be checked by admin.'))
      end
    end

    context 'when params are not correct' do
      let(:params) { { review: { author_name: '' } } }

      it 'is expected to render new template' do
        is_expected.to(render_template(:index))
      end

      it 'is expected to add errors to author_name attribute' do
        expect(assigns[:review].errors[:author_name]).to(eq(['can\'t be blank']))
      end
    end
  end

  # update action
  describe 'PATCH #update' do
    before do
      patch :update, params: params
    end

    context 'when review exist in database' do
      let(:review) { FactoryBot.create(:review) }
      let(:params) do
        { id: review.id, review:
          {
            author_name: 'Some author_name',
            author_email: 'Some author_email',
            body: 'Some body'
          } }
      end

      context 'when data is provided is valid' do
        it 'is expected to update review' do
          expect(review.reload.author_name).to(eq('Some author_name'))
          expect(review.reload.author_email).to(eq('Some author_email'))
          expect(review.reload.body).to(eq('Some body'))
        end

        it 'is_expected to redirect_to reviews_path' do
          is_expected.to(redirect_to(reviews_path))
        end

        it 'is expected to set flash message' do
          expect(flash[:notice]).to(eq('Review was checked. It will be displayed to users.')
            .or(eq('Review was unchecked. It won\'t be displayed to users.')))
        end
      end

      context 'when data is invalid' do
        let(:review) { FactoryBot.create(:review) }
        let(:params) { { id: review.id, review: { author_name: '' } } }

        it 'is expected not to update review author_name' do
          expect(review.reload.author_name).not_to(be_empty)
        end

        it 'is expected to render index template' do
          expect(response).to(render_template(:index))
        end

        it 'is expected to add errors to review author_name attribute' do
          expect(assigns[:review].errors[:author_name]).to(eq(['can\'t be blank']))
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
      let(:review) { FactoryBot.create(:review) }
      let(:params) { { id: review.id } }

      it 'is expected to delete review successfully' do
        expect(Review.count).to(eq(0))
      end

      it 'checks that review was destroyed' do
        expect(Review.find_by(id: review.id)).to(be_nil)
      end

      it 'is expected to redirect_to reviews_path' do
        is_expected.to(redirect_to(reviews_path))
      end

      it 'is expected to set flash message' do
        expect(flash[:notice]).to(eq('Review was successfully destroyed.'))
      end
    end
  end
end
