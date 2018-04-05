class AddTypeToArea < ActiveRecord::Migration[5.1]
  def change
    add_column(:areas, :type, :text)
  end
end
