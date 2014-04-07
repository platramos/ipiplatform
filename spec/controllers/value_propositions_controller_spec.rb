require 'spec_helper'

describe ValuePropositionsController do
  before do
    @okta_user_id = 3
    ApplicationController.stub(:okta_user).and_return(@okta_user_id)
    session[:userinfo] = @okta_user_id
  end

  describe 'POST create' do
    before :each do
      @description = 'as in tasty carrots'
      @name = 'orange'
      @value_proposition_category = FactoryGirl.create(:value_proposition_category, name: 'Hats and bowties', description: 'are good for events')
      @create_params = { value_proposition: {
                                name: @name,
                                description: @description,
                                },
                         value_proposition_category_id: @value_proposition_category.id
                        }
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        ValuePropositionCategory.stub(:find).and_return(@value_proposition_category)
      end

      it 'should create a value proposition' do
        patch :create, @create_params

        @value_proposition = ValueProposition.all.first

        expect(@value_proposition.name).to eql 'orange'
        expect(@value_proposition.description).to eql @description
      end

      it 'should be able to attach associated value proposition category' do
        ValuePropositionCategory.should_receive(:find).exactly(1).times

        patch :create, @create_params
      end
    end

    context 'as a user' do
      it 'should not be able to create a value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :create, @create_params

        expect(ValueProposition.all.count).to eql(0)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        patch :create, @create_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to create a value proposition' do
        patch :create, @create_params

        expect(ValueProposition.all.count).to eql(0)
      end
    end
  end

  describe '#destroy' do
    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: @value_proposition_category)
      @destroy_params = {id: value_proposition.id}
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should delete a value proposition' do
        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql(0)
      end

      it 'should be able to detatch associated value proposition category' do
        @value_proposition_category.value_propositions.count.should eql(1)

        delete :destroy, @destroy_params

        expect(@value_proposition_category.value_propositions.count).to eql(0)
      end
    end

    context 'as a user' do
      it 'should not be able to delete a value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql(1)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        delete :destroy, @destroy_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to delete a value proposition' do
        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql(1)
      end
    end
  end

  describe '#index' do
    before :each do
      value_proposition_category = FactoryGirl.create(:value_proposition_category)
      value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: value_proposition_category)
      @get_params = {id: value_proposition.id}
    end

    context 'as an admin user' do
      it 'should show the list of value propositions' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_propositions_path)
      end
    end

    context 'as a user' do
      it 'should redirect the user to the root path' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        get :index, @get_params

        response.should redirect_to root_path
      end
    end

    context 'while not signed in' do
      it 'should redirect the user to the new sessions path' do
        get :index, @get_params

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#show' do
    before :each do
      value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: value_proposition_category)
      @get_params = {id: @value_proposition.id}
    end

    context 'as an admin user' do
     it 'should show the requested value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end

    context 'as a user' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end

    context 'while not signed in' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end
  end

  describe 'PATCH update' do
    before :each do
      @value_proposition_params = { name: "name",
                                    description: "description",
                                    value_proposition_category_id: 1 }
      @update_params = { id: 0, value_proposition: @value_proposition_params }

      @mock_value_proposition = stub_model(ValueProposition, id: 0)
      ValueProposition.stub(:find).and_return(@mock_value_proposition)
    end

    context 'as an admin' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized)
      end

      context 'when update returns true' do
        it 'should update value proposition' do
          @mock_value_proposition.should_receive(:update).and_return(true)
          patch :update, @update_params
        end


        it 'should redirect to value proposition show page' do
          @mock_value_proposition.stub(:update).and_return(true)
          patch :update, @update_params
          response.should redirect_to value_proposition_path(@mock_value_proposition.id)
        end
      end

      context 'when update returns false' do
        before :each do
          @mock_value_proposition.stub(:update).and_return(false)
        end

        it 'should re-render edit template' do
          patch :update, @update_params
          response.should render_template('edit')
        end

      end
    end

    context 'as a user' do
      before do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should not update value proposition' do
        @mock_value_proposition.should_not_receive(:update)
        patch :update, @update_params
      end

      it 'should redirect to root' do
        patch :update, @update_params
        response.should redirect_to root_path
      end
    end

    context 'while not signed in' do
      it 'should not update value proposition' do
        @mock_value_proposition.should_not_receive(:update)
        patch :update, @update_params
      end

      it 'should redirect to new session' do
        patch :update, @update_params
        response.should redirect_to new_session_path
      end
    end
  end

  describe "GET edit" do
    it 'should assign @value_proposition to value proposition' do
      ValueProposition.stub(:find).with(anything()).and_return(@mock_value_proposition)
      get :edit, {id: "0"}
      assigns(:value_proposition).should eq(@mock_value_proposition)
    end
  end
end
