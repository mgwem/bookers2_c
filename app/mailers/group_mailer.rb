class GroupMailer < ApplicationMailer
  
  def notice_event
    @group = params[:group]
    @title = params[:title]
    @body = params[:body]
    mail(to: @user.email, subject: @title)
  end
end
