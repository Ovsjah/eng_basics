require 'rails_helper'

RSpec.describe FibsController, type: :controller do
  subject { JSON.parse(response.body) }

  let(:valid_attributes) { {size: 10} }
  let(:invalid_attributes) { {size: ' '} }

  before(:each) { @fib = Fib.create! valid_attributes }

  describe "GET #index" do
    it "responds with JSON body containing fibs" do
      get :index
      expect(subject.size).to eq(1)
    end
  end

  describe "GET #show" do
    it "responds with JSON body containing Fib attributes" do
      get :show, params: {id: @fib.to_param}
      expect(subject['genrated_fibs']).to match(@fib.attributes[:generated_fibs])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Fib" do
        expect {
          post :create, params: {fib: valid_attributes}
        }.to change(Fib, :count).by(1)
      end

      it "renders a JSON response with the new fib" do
        post :create, params: {fib: valid_attributes}
        expect(subject['size']).to eq(10)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new fib" do
        post :create, params: {fib: invalid_attributes}
        expect(subject['size']).to eq(["can't be blank", "is not a number"])
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) { {size: 2} }

      it "updates the requested fib" do
        patch :update, params: {id: @fib.to_param, fib: new_attributes}
        expect(subject['generated_fibs'].size).to eq(@fib.reload.size)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the fib" do
        patch :update, params: {id: @fib.to_param, fib: invalid_attributes}
        expect(subject['size']).to eq(["can't be blank", "is not a number"])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested fib" do
      expect {
        delete :destroy, params: {id: @fib.to_param}
      }.to change(Fib, :count).by(-1)
    end
  end
end
