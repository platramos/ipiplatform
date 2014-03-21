require 'spec_helper'

describe JourneysController do
  let(:mock_journey) { mock_model(Journey, title: "JourneyTitle", value_proposition_id: "0") }
  let(:mock_value_proposition) { mock_model(ValueProposition, name: "VpName", description: "description", value_proposition_category: "category")}
  let(:valid_attributes) { { title: "JourneyTitle", value_proposition_id: "0"} }
  let(:value_proposition_id) { "0" }

  before do
    Journey.stub(:new).and_return(mock_journey)
    ValueProposition.stub(:find).with(value_proposition_id).and_return(mock_value_proposition)
    journeys_proxy = mock("association proxy", {"new" => Journey.new})
    mock_value_proposition.stub(:journeys).and_return(journeys_proxy)
  end

  describe "POST create" do
    it "calls save on the journey" do
      mock_journey.should_receive(:save)
      post :create, { value_proposition_id: value_proposition_id,
                      journey: valid_attributes }
    end
    describe "successful journey save" do
      it "should redirect to root path" do
        mock_journey.stub(:save).and_return(true)
        post :create, { value_proposition_id: value_proposition_id,
                        journey: valid_attributes}
        response.should redirect_to(value_proposition_path(value_proposition_id))
      end
    end
    describe "fail to save journey" do
      it "should render new" do
        mock_journey.stub(:save).and_return(false)
        post :create, { value_proposition_id: value_proposition_id,
                        journey: valid_attributes}
        response.should render_template("new")
      end
    end
  end

  describe "GET new" do
    it "loads a new journey" do
      Journey.should_receive(:new)
      get :new, { value_proposition_id: value_proposition_id}
    end

    it "assigns @journey to new journey" do
      get :new, { value_proposition_id: value_proposition_id}
      assigns(:journey).should eq mock_journey
    end

    it "loads the value proposition id" do
      get :new, { value_proposition_id: 0}
      assigns(:value_proposition_id).should eq value_proposition_id
    end
  end
end
