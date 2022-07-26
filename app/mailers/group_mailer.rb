class GroupMailer < ApplicationMailer

  def notice_event(title, content, group_users, group_name)
    @group_users = group_users
    @group_name = group_name
    @title = title
    @content = content
    mail bcc: group_users.pluck(:email), subject: title
  end
end
