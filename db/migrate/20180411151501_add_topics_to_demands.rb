class AddTopicsToDemands < ActiveRecord::Migration[5.1]
  def change
    add_column(:demands, :topic, :string)
  end
end
