class Relationship
  include MongoMapper::Document
  key :country, String
  key :alter_country, String
  key :mirrored, Boolean
  key :year_2001, Integer
  key :year_2002, Integer
  key :year_2003, Integer
  key :year_2004, Integer
  key :year_2005, Integer
  key :year_2006, Integer
  key :year_2007, Integer
  key :year_2008, Integer
  key :year_2009, Integer
  key :year_2010, Integer
  key :year_2011, Integer
  key :year_2012, Integer
  key :year_2013, Integer
end
# Relationship.ensure_index([[:country, 1], [:alter_country, 1], [:year_2008, 1], [:year_2009, 1], [:year_2010, 1], [:year_2011, 1], [:year_2012, 1]])
