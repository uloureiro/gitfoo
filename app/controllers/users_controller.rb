require_relative '../../lib/github/request.rb'

class UsersController < ApplicationController
  def index
  end

  def show
    @user = Request.get('users', params[:id])
    render json: @user
  end
end