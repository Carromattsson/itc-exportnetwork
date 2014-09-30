class GenerateYear
  attr_accessor :year, :graph
  def initialize(year)
    @year = year
    @graph = {nodes: [], edges: []}
  end

  def query
    Relationship.fields(("year_"+@year.to_s).to_sym, :alter_country, :country)
  end

  def generate_nodes
    query.distinct(:country).map do |c|
      {id: c, label: c}
    end
  end
  
  def generate_edges
    query.map do |relationship|
      {source: relationship.country, target: relationship.alter_country, attributes: [{:for => "Year #{@year}", :value => relationship.send("year_#{@year}")}]}
    end
  end

  def generate
    @graph.nodes = generate_nodes
    @graph.edges = generate_edges
  end
  def to_graph
    generate
    Graph.new(@graph)
  end
end