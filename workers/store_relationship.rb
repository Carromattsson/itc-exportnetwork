class StoreRelationship
  include Sidekiq::Worker
  def perform(relationship_data)
    #do our row-level cleaning here.
    relationship_data.year_2008 = relationship_data.year_2008.to_i
    relationship_data.year_2009 = relationship_data.year_2009.to_i
    relationship_data.year_2010 = relationship_data.year_2010.to_i
    relationship_data.year_2011 = relationship_data.year_2011.to_i
    relationship_data.year_2012 = relationship_data.year_2012.to_i
    Relationship.first_or_create(relationship_data)
  end
end