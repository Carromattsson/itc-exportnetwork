class Relationship
  include MongoMapper::Document
  key :country, String
  key :alter_country, String
  key :year_2008, Integer
  key :year_2009, Integer
  key :year_2010, Integer
  key :year_2011, Integer
  key :year_2012, Integer
end