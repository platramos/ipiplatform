require 'spec_helper'

describe StepsController do

  let(:valid_attributes) { { "name" => "MyString" } }
  let(:journey_id) { "2" }

  let(:mock_step) { mock_model(Step, id:"0", name: "stepName", journey_id: journey_id)}
  let(:mock_journey) { mock_model(Journey, title: "JourneyTitle", value_proposition_id: "0")}

  describe "GET index" do
    it "assigns all steps as @steps" do
      Step.stub(:all).and_return([mock_step])
      get :index, {}
      assigns(:steps).should eq([mock_step])
    end
  end

  describe "GET show" do
    it "assigns the requested step as @step" do
      mock_journey.stub_chain(:steps, :find).with(mock_step.id).and_return(mock_step)
      Journey.stub(:find).with(journey_id).and_return(mock_journey)
      get :show, {:journey_id => journey_id, :id => mock_step.id}
      assigns(:step).should eq(mock_step)
    end
  end

  describe "GET new" do
    it "loads a new step" do
      Step.should_receive(:new)
      get :new, {journey_id: journey_id}
    end

    it "assigns @step to new step" do
      get :new, { journey_id: journey_id}
      assigns(:step).should be_a_new(Step)
    end

    it "loads the journey id" do
      get :new, { journey_id: journey_id}
      assigns(:journey_id).should eq journey_id
    end
  end

  describe "GET edit" do
    let(:mock_resources) { mock_model(Resource) }

    before do
      mock_journey.stub_chain(:steps, :find).with(mock_step.id).and_return(mock_step)
      Journey.stub(:find).with(journey_id).and_return(mock_journey)
      mock_step.stub_chain(:resources,:order).with(anything()).and_return(mock_resources)
    end

    it "assigns the requested step as @step" do
      get :edit, { journey_id: journey_id, id: mock_step.id}
      assigns(:step).should eq(mock_step)
    end

    it 'should assign resources ordered by position' do
      ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

      get :edit, {journey_id: journey_id, :id => mock_step.id }
      assigns(:resources).should eq(mock_resources)
    end
  end

  describe "POST create" do
    before do
      mock_journey.stub_chain(:steps, :new).with(valid_attributes).and_return(mock_step)
      Journey.stub(:find).with(journey_id).and_return(mock_journey)
    end

    it "calls save on the step" do
      mock_step.should_receive(:save)
      post :create, { journey_id: journey_id, step: valid_attributes}
    end

    describe "successful step save" do
      it "should redirect to edit journey page" do
        mock_step.stub(:save).and_return(true)
        post :create, {journey_id: journey_id, step: valid_attributes}
        response.should redirect_to(edit_value_proposition_path("0"))
      end
    end

    describe "failed step save" do
      it "should render new step page" do
        mock_step.stub(:save).and_return(false)
        post :create, {journey_id: journey_id, step: valid_attributes}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      Journey.stub(:find).with(journey_id).and_return(mock_journey)
      mock_journey.stub_chain(:steps, :find).with(mock_step.id).and_return(mock_step)
      mock_step.stub(:update).and_return(true)
    end

    describe "with valid params" do
      it "updates the requested step" do
        mock_step.should_receive(:update).with(valid_attributes)
        put :update, {:journey_id => journey_id, :id => mock_step.id, :step => valid_attributes}
      end

      it "assigns the requested step as @step" do
        put :update, {:journey_id => journey_id, :id => mock_step.id, :step => valid_attributes}
        assigns(:step).should eq(mock_step)
      end

      it "redirects to edit value proposition on successful update" do
        put :update, {:journey_id => journey_id, :id => 0, :step => valid_attributes}
        response.should redirect_to(edit_value_proposition_path(mock_journey.value_proposition_id))
      end
    end

    describe "with invalid params" do
      let(:mock_resource) { mock_model(Resource) }

      before do
        mock_step.stub(:update).and_return(false)
        mock_step.stub(:resources).and_return([mock_resource])
      end

      it "assigns resources for invalid params" do
        put :update, {:journey_id => journey_id, :id => mock_step.id, :step => { "name" => "invalid value"}}
        assigns(:resources).should  eq([mock_resource])
      end

      it "assigns the step as @step" do
        put :update, {:journey_id => journey_id, :id => mock_step.id, :step => { "name" => "invalid value" }}
        assigns(:step).should eq(mock_step)
      end

      it "re-renders the 'edit' template" do
        put :update, {:journey_id => journey_id, :id => mock_step.id, :step => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Journey.stub(:find).with(journey_id).and_return(mock_journey)
      mock_journey.stub_chain(:steps, :find).with(mock_step.id).and_return(mock_step)
    end

    it "should call destroy on step" do
      mock_step.should_receive(:destroy)
      delete :destroy, {:journey_id => journey_id, :id => mock_step.id}
    end

    it "redirects to edit value proposition" do
      mock_step.stub(:destroy)
      delete :destroy, {:journey_id => journey_id, :id => 0}
      response.should redirect_to(edit_value_proposition_path(mock_journey.value_proposition_id))
    end
  end

  describe 'GET reorder' do
    let(:mock_steps) {[mock_step]}

    before :each do
      Journey.stub(:find).with(journey_id).and_return(mock_journey)
      mock_journey.stub(:steps).and_return(mock_steps)
      mock_steps.should_receive(:order).with(:position).and_return(mock_steps)
    end

    it 'should assign steps ordered by position' do
      get :reorder, {journey_id: journey_id}
      assigns(:steps).should eql mock_steps
    end

    it 'should assign @value_proposition_id to value proposition id' do
      mock_journey.should_receive(:value_proposition_id).and_return("4")
      get :reorder, {journey_id: journey_id}
      assigns(:value_proposition_id).should eql "4"
    end
  end

  describe "POST sort" do
    it 'should make a call to sort on sorter ' do
      StepsSorter.any_instance.should_receive(:sort).and_return(nil)
      post :sort, {step: [6,5,7]}
    end
  end
end
