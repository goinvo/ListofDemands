class ChangeProblemNameColumnToText < ActiveRecord::Migration[5.2]
  def change
    change_column :problems, :name, :text
  end
end
