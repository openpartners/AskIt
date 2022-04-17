class PagesController < ApplicationController
  def index
    params[:name] ? @name = params[:name] : @name = "X-Men" 
  end
end