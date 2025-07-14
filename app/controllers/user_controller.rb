class UserController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def dashboard
    #where we put links to other options
  end

end
