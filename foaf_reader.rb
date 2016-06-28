require 'rdf'
require 'sparql'
require 'net/http'
require 'openssl'
require 'linkeddata'
graph = RDF::Graph.load("foaf.rdf")

puts graph.inspect

query ="SELECT * WHERE {?s ?p ?o}"

sse = SPARQL.parse(query)
sse.execute(graph) do |result|
	puts result.o
end