class UserMailer < ApplicationMailer
  default from: "StockPro <fernandez.sjackson@gmail.com>"

  def approval_email
    @user = params[:user]
    mail(to: @user.email, subject: "Approved")
  end
end
