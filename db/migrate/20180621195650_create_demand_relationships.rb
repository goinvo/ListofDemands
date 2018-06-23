class CreateDemandRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :demand_relationships do |t|
      t.references :demand, index: true, foreign_key: true
      t.references :related_demand, index: true

      t.timestamps null: false
    end

    add_foreign_key :demand_relationships, :demands, column: :related_demand_id
    add_index :demand_relationships, [:demand_id, :related_demand_id], unique: true
  end
end
