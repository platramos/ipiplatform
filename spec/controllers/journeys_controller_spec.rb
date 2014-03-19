require 'spec_helper'

describe JourneysController do
  let(:valid_attributes) { { title: "JourneyTitle" } }

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created journey as @journey" do
        expect{
          post :create, {:journey => valid_attributes}
        }.to change(Journey, :count).by(1)
      end
    end
  end
end
