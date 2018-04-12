require 'csv'

namespace :migration_helpers do
  desc "Aid the addition of types of Areas (Municipality, County, State). Convert existing Area's into Municipality types with proper naming, and add Counties and States."
  task area_segments: :environment do
    zips = ZipCode.all.reduce({}) { |hash, zip| hash[zip.zip] = zip.id; hash }

    # First, to satisfy the indexing uniqueness validation, update all Muni names
    # so that a County isn't attempted to be made with the same name
    # (for instance "Hampden, MA" town of "Hampden, MA" county)
    CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
      # Update the existing Muni entry if it hasn't been updated already
      # Note: type: [nil, '', 'Municipality'] is basically just because I don't know
      # what the type would be immediately after the migration. Presumably nil
      # but I'm not positive. The combination of name + one of those types should
      # always find the appropriate record though.
      @muni = Area.where(name: "#{row["city"]}, #{row["state"]}", type: [nil, '', 'Municipality']).take

      if @muni.present?
        @muni.update(name: "#{row["city"]}, #{row["county"]}, #{row["state"]}", type: "Municipality")
      end
    end

    # Now that Muni's are all set, make the new types, Counties and States,
    # as well as AreaDefitions for each Zip/County Zip/State combination
    CSV.foreach(Rails.root.join('data', 'us_postal_codes.csv'), headers: true) do |row|
      # Create County and State areas if they don't already exist
      @county = Area.where(name: "#{row["county"]}, #{row["state"]}", type: "County").first_or_create!
      @state = Area.where(name: "#{row["state"]}", type: "State").first_or_create!

      # Then create the AreaDefitition for County/State with current Zip if they don't already exist
      @county_def = AreaDefinition.where(zip_code_id: zips[row["zip"]], area_id: @county.id).first_or_create!
      @state_def = AreaDefinition.where(zip_code_id: zips[row["zip"]], area_id: @state.id).first_or_create!
    end
  end

end
