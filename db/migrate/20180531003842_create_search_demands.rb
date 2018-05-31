class CreateSearchDemands < ActiveRecord::Migration[5.2]
  def change
    create_view :search_demands, materialized: true
  end
end
