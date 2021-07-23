class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # いいね機能の定義、存在していればtrue、存在していなければfalseを返す
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # 通報ボタンの定義
  def reported_by?(user)
    reports.where(user_id: user.id).empty?
  end

  attachment :image

  enum dog_size: {"小型犬":0, "中型犬":1, "大型犬":2, "超大型犬":3 }

  # 住所と場所の検索
  def self.search(search)
    if search != ""
      @posts = Post.where("address LIKE? OR place LIKE?", "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end

  # バリデーション
  with_options presence: true do
    validates :place
    validates :introduction, length: { maximum: 1000 }
    validates :address
    validates :latitude
    validates :longitude
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end


  # コメント機能のメソッド
 def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end


