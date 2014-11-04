class StoreRelationship
  include Sidekiq::Worker
  def perform(relationship_data, mirrored)
    2001.upto(2013) do |year|
      relationship_data.send("year_#{year}=".to_sym, relationship_data.send("year_#{year}".to_sym).to_i)
    end
    Relationship.first_or_create(relationship_data.merge(:mirrored => mirrored))
  end
end
