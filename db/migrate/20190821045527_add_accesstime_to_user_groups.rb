class AddAccesstimeToUserGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :user_groups, :accesstime, :datetime, default:DateTime.now
  end
end
