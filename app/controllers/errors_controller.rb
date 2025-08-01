class ErrorsController < ApplicationController
  before_action :authenticate_user!
  def not_found
  end
end
