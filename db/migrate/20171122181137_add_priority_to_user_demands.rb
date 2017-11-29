class AddPriorityToUserDemands < ActiveRecord::Migration[5.1]
  def up
    add_column(:user_demands, :priority, :integer)
    UserDemand.reset_column_information

    # default order to created_at for existing demands
    User.find_each do |user|
      priority = 1
      user.user_demands.order('created_at ASC').each do |user_demand|
        user_demand.update_attributes(priority: priority)
        priority += 1
      end
    end

    change_column(:user_demands, :priority, :integer, null: false)
  end

  def down
    remove_column(:user_demands, :priority, :integer)
  end
end
