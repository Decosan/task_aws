class AddSortExpiredToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :sort_expired, :date
  end
end
