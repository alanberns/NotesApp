class Api::CategoriesController < ApplicationController

  # GET /categories
  def index
    @categories = Category.all

    render json: @categories.to_json( :only => [:id, :name] )
  end
end
