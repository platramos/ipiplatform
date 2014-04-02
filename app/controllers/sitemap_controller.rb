class SitemapController < ApplicationController

  def index
    @resources = Resource.all
    @value_proposition_categories = ValuePropositionCategory.all
  end
end
