class UserMailer < ApplicationMailer
  default from: "stockpro@example.com"

  def approval_email
    @user = params[:user]
    mail(to: @user.email, subject: "Approved")
  end
end
