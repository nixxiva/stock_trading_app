class Admin::TransactionsController < ApplicationController
    layout 'admin'
    before_action :authorize_admin!

    def index
			@transactions = Transaction.includes(:user, :stock).order(created_at: :desc)
			@total_transactions = @transactions.count
    end

end
