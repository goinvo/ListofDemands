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

      area_destination_columns = [:name, :type, :created_at, :updated_at]

      Area.bulk_insert(*area_destination_columns, update_duplicates: true) do |worker|
        set = Set.new

        CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
          set << {name: "#{row["city"]}, #{row["county"]}, #{row["state"]}", type: "Municipality"}
          set << {name: "#{row["county"]}, #{row["state"]}", type: "County"}
          set << {name: "#{row["state"]}", type: "State"}
        end

        set.to_a.map do |row|
          worker.add([row[:name], row[:type], Time.now, Time.now])
        end

        worker.save!
      end

      area_definitions_destination_columns = [:zip_code_id, :area_id, :created_at, :updated_at]

      AreaDefinition.bulk_insert(*area_definitions_destination_columns, update_duplicates: true) do |worker|

        zip_codes = ZipCode.all.reduce({}) { |hash, zip| hash[zip.zip] = zip.id; hash }
        areas = Area.all.reduce({}) { |hash, area| hash[area.name] = area.id; hash }


        CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
          worker.add([
            zip_codes[row["zip"]],
            areas["#{row["city"]}, #{row["county"]}, #{row["state"]}"],
            Time.now,
            Time.now
          ])
          worker.add([
            zip_codes[row["zip"]],
            areas["#{row["county"]}, #{row["state"]}"],
            Time.now,
            Time.now
          ])
          worker.add([
            zip_codes[row["zip"]],
            areas["#{row["state"]}"],
            Time.now,
            Time.now
          ])
        end

        worker.save!
      end
    end
  end
end
