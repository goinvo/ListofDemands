class SearchDemand < ApplicationRecord

  belongs_to :demanded_by_user, class_name: "User"
  belongs_to :demand

  # see https://github.com/thoughtbot/scenic#faqs
  # Why do I get an error when querying a view-backed model with find, last, or first?
  self.primary_key = :demand_id

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  def readonly?
    true
  end
end
