class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :dogs, :user_id, false
  end
  
  def down
    change_column_null :dogs, :user_id, true
  end
end
