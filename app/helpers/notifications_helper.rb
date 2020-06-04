module NotificationsHelper
  def notification_form(notification)
    notification.each do|notice|
    @sender = notice.sender
    @comment = nil
    @item = notice.item
    # your_item = link_to 'あなたの商品', user_item_path(notice), style:"font-weight: bold;"
    @sender_comment = notice.comment_id
    #notice.actionがlikeかcommentか
    # case notice.action
    #   when "like" then
    #     tag.a(@sender.nickname)+"が"+tag.a("#{@item.name}", style:"font-weight: bold;")+"にいいねしました"
    #   when "comment" then
    #     #コメントの内容と投稿のタイトルを取得   
    #     @comment = Comment.find_by(id: @sender_comment)
    #     @comment_content =@comment.content
    #     @item_title =@comment.item.title
    #     tag.a(@sender.nickname) + 'が' + tag.a("#{@item.name}") + 'にコメントしました'
    # end
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
