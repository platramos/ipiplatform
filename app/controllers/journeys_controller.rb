class JourneysController < ApplicationController
  before_filter :load_value_proposition
  before_action :load_journey, only: [:destroy]
  def new
    @journey = Journey.new
    @value_proposition_id = params[:value_proposition_id]
  end

  def create
    @journey = @value_proposition.journeys.new(journey_params)

    if @journey.save
      redirect_to edit_value_proposition_path(params[:value_proposition_id]), notice: 'Journey was successfully created'
    else
      render action: 'new'
    end
  end

  def edit
    @journey = load_journey_to_update
  end

  def update
      if load_journey_to_update.update(journey_params)
        redirect_to edit_value_proposition_path(params[:value_proposition_id]), notice: 'Journey was successfully updated'
      else
        render action: 'edit'
      end
  end

  def destroy
    @journey.destroy
    redirect_to edit_value_proposition_path(@journey.value_proposition_id)
  end

  private

  def journey_params
    params.require(:journey).permit(:title, :value_proposition_id)
  end

  def load_value_proposition
    @value_proposition = ValueProposition.find(params[:value_proposition_id])
  end

  def load_journey_to_update
    @value_proposition.journeys.find(params[:id])
  end

  def load_journey
    @journey = @value_proposition.journeys.find(params[:id])
  end

end
