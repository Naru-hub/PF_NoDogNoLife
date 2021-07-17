class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # validates :report_id, uniqueness: { scope: [:post_id, :user_id] }
end
