class GroupMailer < ApplicationMailer

  def notice_event(title, body, group_users, group_name)
    @group_users = group_users
    @group_name = group_name
    @title = title
    @body = body
    mail bcc: group_users.pluck(:email), subject: title
  end
end
