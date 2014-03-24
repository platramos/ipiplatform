class JourneysController < ApplicationController
  before_filter :load_value_proposition

  def create
    @journey = @value_proposition.journeys.new(journey_params)

    if @journey.save
      redirect_to value_proposition_path(params[:value_proposition_id])
    else
      render action: 'new'
    end
  end

  def new
    @journey = Journey.new
    @value_proposition_id = params[:value_proposition_id]
  end

  def edit
    @journey = load_journey_to_update
  end

  def update
      if load_journey_to_update.update(journey_params)
        redirect_to value_proposition_path(params[:value_proposition_id])
      else
        render action: 'edit'
      end
  end

  def journey_params
    params.require(:journey).permit(:title, :value_proposition_id)
  end

  def load_value_proposition
    @value_proposition = ValueProposition.find(params[:value_proposition_id])
  end

  def load_journey_to_update
    @value_proposition.journeys.find(params[:id])
  end

end
