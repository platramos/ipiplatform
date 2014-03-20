require 'spec_helper'

describe JourneysController do
  let(:journey) { mock_model(Journey, title: "JourneyTitle") }
  # @journey = mock_model(Journey, title: "JourneyTitle")
  let(:valid_attributes) { { title: "JourneyTitle" } }

  before do
    Journey.stub(:new).and_return(journey)
  end

  describe "POST create" do
      it "calls save on the journey" do
        journey.should_receive(:save)
       #expect(journey).to receive(:save).and_return(true)
        post :create, { value_proposition_id: 0,
                        journey: valid_attributes }
      end
    describe "successful journey save" do
      it "should redirect to root path" do
        journey.stub(:save).and_return(true)
        post :create, { value_proposition_id: 0,
                        journey: valid_attributes}
        response.should redirect_to(root_path)
      end
    end
    describe "fail to save journey" do
      it "should render new" do
        journey.stub(:save).and_return(false)
        post :create, { value_proposition_id: 0,
                        journey: valid_attributes}
        response.should render_template("new")
      end
    end
  end

#    describe "with valid params" do
#      it "assigns a newly created journey as @journey" do
#        expect{
#          post :create, {:journey => valid_attributes}
#        }.to change(Journey, :count).by(1)
#      end
#    end
#  end
end
