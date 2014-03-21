require 'spec_helper'

describe JourneysController do
  let(:mock_journey) { mock_model(Journey, title: "JourneyTitle") }
  let(:valid_attributes) { { title: "JourneyTitle" } }
  let(:value_proposition_id) { "0" }

  before do
    Journey.stub(:new).and_return(mock_journey)
  end

  describe "POST create" do
    it "calls save on the journey" do
      mock_journey.should_receive(:save)
      #expect(journey).to receive(:save).and_return(true)
      post :create, { value_proposition_id: 0,
                      journey: valid_attributes }
    end
    describe "successful journey save" do
      it "should redirect to root path" do
        mock_journey.stub(:save).and_return(true)
        post :create, { value_proposition_id: 0,
                        journey: valid_attributes}
        response.should redirect_to(root_path)
      end
    end
    describe "fail to save journey" do
      it "should render new" do
        mock_journey.stub(:save).and_return(false)
        post :create, { value_proposition_id: 0,
                        journey: valid_attributes}
        response.should render_template("new")
      end
    end
  end

  describe "GET new" do
    it "loads a new journey" do
      Journey.should_receive(:new)
      get :new, { value_proposition_id:0}
    end

    it "assigns @journey to new journey" do
      get :new, { value_proposition_id:0}
      assigns(:journey).should eq mock_journey
    end

    it "loads the value proposition id" do
      get :new, { value_proposition_id: 0}
      assigns(:value_proposition_id).should eq value_proposition_id
    end
  end
end
