class Admin::TransactionsController < ApplicationController
  layout 'admin'
  before_action :authorize_admin!

  def index
    @q = Transaction.ransack(params[:q])
    @transactions = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
    @total_transactions = @transactions.total_count
  end
end
