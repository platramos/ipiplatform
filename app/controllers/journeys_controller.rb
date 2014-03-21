class JourneysController < ApplicationController
  def create
    @journey = Journey.new(journey_params)

    if @journey.save
      redirect_to root_path
    else
       render action: 'new'
    end
  end

  def new
    @journey = Journey.new
    @value_proposition_id = params[:value_proposition_id]
  end

  def journey_params
    params.require(:journey).permit(:title, :value_proposition_id)
  end
end
