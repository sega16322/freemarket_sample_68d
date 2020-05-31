module NotificationsHelper
  def notification_form(notification)
    @sender = notification.sender
    @comment = nil
    your_item = link_to 'あなたの投稿', users_item_path(notification), style:"font-weight: bold;"
    @sender_comment = notification.comment_id
    #notification.actionがlikeかcommentか
    case notification.action
      when "like" then
        tag.a(notification.sender.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @sender_comment)&.content
          tag.a(@sender.name, href:users_user_path(@sender), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
