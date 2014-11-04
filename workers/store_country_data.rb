class StoreCountryData
  include Sidekiq::Worker
  def perform(file_location, mirrored=false)
    cleaned_dataset(file_location).each do |relationship|
      StoreRelationship.perform_async(relationship.merge(country: country_name_by_file_location(file_location)), mirrored)
    end
  end

  def cleaned_dataset(file_location)
    raw = parsed_dataset(file_location)
    keys = raw[1].collect{|x| x.gsub("Importers", "alter_country").gsub("Exported value in ", "year_")}
    raw[3..-1].map do |r|
      Hash[keys.zip(r)]
    end
  end

  def parsed_dataset(file_location)
    File.read(file_location).split("\r\n").collect{|r| r.split("\t").collect{|c| c.gsub("\"", "")}}
  end

  def country_name_by_file_location(filename)
    offset = filename.downcase.include?("mirror") ? -2 : -1
    filename.split("/").last.split("_")[12..offset].join(" ").gsub(".txt", "")
  end

end
