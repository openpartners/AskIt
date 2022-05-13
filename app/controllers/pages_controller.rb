# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @name = params[:name] || 'X-Men'
  end
end
