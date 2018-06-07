require 'csv'

namespace :migration_helpers do
  desc "Seed the database with ZipCodes, Areas, and AreaDefinitions."
  task area_seed: :environment do
    Area.delete_all
    AreaDefinition.delete_all
    ZipCode.delete_all

    ZipCode.bulk_insert(:zip, :city, :state, :state_abbreviation, :county, :latitude, :longitude) do |worker|
      puts "Seeding ZipCodes."
      count = 0
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
        count = count + 1
        if count % 1000 == 0
          puts "Processed #{count} rows"
        end
      end
      worker.save!
    end

    Area.bulk_insert(:name, :type, :created_at, :updated_at) do |worker|
      puts "Seeding Areas."
      count = 0
      municipalities_added = {}
      counties_added = {}
      states_added = {}

      CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
        municipality_name = "#{row["city"]}, #{row["county"]}, #{row["state"]}"
        county_name = "#{row["county"]}, #{row["state"]}"
        state_name = "#{row["state"]}"

        if !municipalities_added[municipality_name]
          worker.add([
            "#{row["city"]}, #{row["county"]}, #{row["state"]}",
            "Municipality",
            Time.now,
            Time.now
          ])
          municipalities_added[municipality_name] = true
        end

        if !counties_added[county_name]
          worker.add([
            county_name,
            "County",
            Time.now,
            Time.now
          ])
          counties_added[county_name] = true
        end

        if !states_added[state_name]
          worker.add([
            state_name,
            "State",
            Time.now,
            Time.now
          ])
          states_added[state_name] = true
        end

        count = count + 1
        if count % 1000 == 0
          puts "Processed #{count} rows"
        end
      end

      worker.save!
    end

    AreaDefinition.bulk_insert(:zip_code_id, :municipality_id, :county_id, :state_id, :created_at, :updated_at) do |worker|

      zip_codes = ZipCode.all.reduce({}) { |hash, zip| hash[zip.zip] = zip.id; hash }
      areas = Area.all.reduce({}) { |hash, area| hash[area.name] = area.id; hash }

      puts "Seeding Areas."
      count = 0

      CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
        worker.add([
          zip_codes[row["zip"]],
          areas["#{row["city"]}, #{row["county"]}, #{row["state"]}"],
          areas["#{row["county"]}, #{row["state"]}"],
          areas["#{row["state"]}"],
          Time.now,
          Time.now
        ])

        count = count + 1
        if count % 1000 == 0
          puts "Processed #{count} rows"
        end
      end

      worker.save!
    end
  end

  desc "Add short_names to Area records."
  task add_area_short_names: :environment do
    puts "Deleting Areas with empty name"
    Area.where(name: [nil, '']).destroy_all

    puts "Adding short_name's to Area."
    count = 0
    Area.find_each do |area|
      area.short_name = area.name.split(",")[0].strip()
      area.save!

      count += 1
      if count % 1000 == 0
        puts "Processed #{count} rows"
      end
    end
  end

  desc "Add national level area (USA) to database and creation AreaDefinitions."
  task add_usa: :environment do
    usa = Area.new(name: "United States of America", short_name: "USA", type: "Country")
    usa.save!

    puts "Updating AreaDefinitions with USA Country field."
    AreaDefinition.update_all country_id: usa.id
  end
end
