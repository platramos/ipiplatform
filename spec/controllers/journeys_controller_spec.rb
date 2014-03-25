require 'spec_helper'

describe JourneysController do
  let(:mock_journey) { mock_model(Journey, id: "0", title: "JourneyTitle", value_proposition_id: "0") }
  let(:mock_value_proposition) { mock_model(ValueProposition, name: "VpName", description: "description", value_proposition_category: "category")}
  let(:value_proposition_id) { "0" }
  let(:valid_attributes) { { "title"=> "JourneyTitle", "value_proposition_id"=> value_proposition_id } }

  before do
    @admin_user = FactoryGirl.create(:user, :admin)
    ValueProposition.stub(:find).with(value_proposition_id).and_return(mock_value_proposition)
  end

  describe "POST create" do
    before do
      mock_value_proposition.stub_chain(:journeys, :new).with(valid_attributes).and_return(mock_journey)
    end

    it "calls save on the journey" do
      mock_journey.should_receive(:save)
      post :create, { value_proposition_id: value_proposition_id,
                      journey: valid_attributes }
    end
    describe "successful journey save" do
      it "should redirect to value proposition page" do
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
      assigns(:journey).should be_a_new(Journey)
    end

    it "loads the value proposition id" do
      get :new, { value_proposition_id: value_proposition_id}
      assigns(:value_proposition_id).should eq value_proposition_id
    end
  end

  describe "GET edit" do
    it "assigns @journey to journey we want to edit" do
      journey_id_from_param = "0"
      mock_value_proposition.stub_chain(:journeys, :find).with(journey_id_from_param).and_return(mock_journey)
      get :edit, { value_proposition_id: value_proposition_id, id: mock_journey.id}
      assigns(:journey).should eq mock_journey
    end
  end

  describe 'PUT update' do
    context 'as an admin user' do
      before do
        journey_id_from_param = "0"
        mock_value_proposition.stub_chain(:journeys, :find).with(journey_id_from_param).and_return(mock_journey)
      end

      it "calls update on journey" do
        mock_journey.should_receive(:update)
        put :update, { value_proposition_id: value_proposition_id,
                       id: mock_journey.id,
                       journey: valid_attributes,
                       }

      end
      describe "successful journey update" do
        it "should redirect to value proposition page" do
          mock_journey.stub(:update).with(anything()).and_return(true)
          put :update, {  value_proposition_id: value_proposition_id,
                          id: mock_journey.id,
                          journey: valid_attributes}
          response.should redirect_to(value_proposition_path(value_proposition_id))
        end
      end
      describe "journey update failure" do
        it "should render the edit journey page" do
          mock_journey.stub(:update).with(anything()).and_return(false)
          put :update, { value_proposition_id: value_proposition_id,
                         id: mock_journey.id,
                         journey: valid_attributes}
          response.should render_template("edit")

        end
      end
    end
  end
end
