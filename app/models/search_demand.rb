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

  # TODO: refactor these in views after we cut over to fancy search
  def name
    problem
  end

  UserDemandsStruct = Struct.new(:count)

  def user_demands
    UserDemandsStruct.new(demand_count)
  end

  AreaStruct = Struct.new(:short_name)
  def area
    AreaStruct.new(short_name)
  end
end
