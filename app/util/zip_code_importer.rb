require 'csv'

module Util
  class ZipCodeImporter
    def self.run
      Area.delete_all
      AreaDefinition.delete_all
      ZipCode.delete_all
  
      
      ZipCode.bulk_insert(:zip, :city, :state, :state_abbreviation, :county, :latitude, :longitude) do |worker|
        CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
          worker.add([
            row["zip"],
            row["city"],
            row["state"],
            row["state_abbreviation"],
            row["county"],
            row["latitude"],
            row["longitude"]
          ])
        end
  
        worker.save!
      end
  
      Area.bulk_insert(:name, :created_at, :updated_at) do |worker|
        set = Set.new
  
        CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
          set << "#{row["city"]}, #{row["state"]}"
        end
  
        set.to_a.map do |name|
          worker.add([name, Time.now, Time.now])
        end
  
        worker.save!
      end
  
      AreaDefinition.bulk_insert(:zip_code_id, :area_id, :created_at, :updated_at) do |worker|
  
        zip_codes = ZipCode.all.reduce({}) { |hash, zip| hash[zip.zip] = zip.id; hash }
        areas = Area.all.reduce({}) { |hash, area| hash[area.name] = area.id; hash }
  
        CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
          worker.add([
            zip_codes[row["zip"]],
            areas["#{row["city"]}, #{row["state"]}"],
            Time.now,
            Time.now
          ])
        end
  
        worker.save!
      end
    end
  end
end