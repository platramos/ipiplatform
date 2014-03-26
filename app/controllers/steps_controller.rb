class StepsController < ApplicationController
  before_action :load_journey, only: [:show, :create, :edit,:update, :reorder, :destroy]
  before_action :load_step, only: [:show, :edit, :update, :destroy]

  def index
    @steps = Step.all
  end

  def show
  end

  def new
    @step = Step.new
    @value_proposition_id = params[:value_proposition_id]
    @journey_id = params[:journey_id]
  end

  def new_resource
   @resource = Resource.new
   @step_id = params[:step_id]
  end

  def create_resource

  end

  def edit
    @resources = @step.resources.order(:position)
  end

  def create
    @step = @journey.steps.new(step_params)
    if @step.save
      redirect_to edit_value_proposition_path(@journey.value_proposition_id), notice: 'Step was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @step.update(step_params)
      redirect_to edit_value_proposition_path(@journey.value_proposition_id), notice: 'Step was successfully updated.'
    else
      @resources = @step.resources
      render action: 'edit'
    end
  end

  def destroy
    @step.destroy
    redirect_to edit_value_proposition_path(@journey.value_proposition_id)
  end

  def reorder
    @steps = @journey.steps.order(:position)
    @value_proposition_id = @journey.value_proposition_id
  end

  def sort
    StepsSorter.new.sort(params[:step])
    render nothing: true
  end

  def steps_to_sort
    Step.where("value_proposition_id = ?", params[:value_proposition_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_step
     @step = @journey.steps.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:name, :description, :journey_id)
    end

    def load_journey
      @journey = Journey.find(params[:journey_id])
    end
end
