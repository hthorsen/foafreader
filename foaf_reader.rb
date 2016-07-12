require 'rdf'
require 'sparql'
require 'net/http'
require 'openssl'
require 'linkeddata'
graph = RDF::Graph.load("foaf.rdf")

puts graph.inspect

query ="
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
SELECT DISTINCT ?o
WHERE { ?s foaf:knows ?o}
"

puts "Before loading"
sparql_query = SPARQL.parse(query)
sparql_query.execute(graph) do |result|
	#puts result.inspect
	puts result.o
	graph.load(result.o)
end

puts "After loading"
sparql_query.execute(graph) do |result|
	puts result.o
end

interest_query = "
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
SELECT DISTINCT ?o
WHERE { ?s foaf:interest ?o }
"

tmp_query = "PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dbo: <http://dbpedia.org/ontology/>
SELECT ?abs
WHERE { ?s dbo:abstract ?abs
FILTER (lang(?abs) = 'en')}"

tmp_graph = RDF::Graph.load("http://dbpedia.org/resource/Quilting")
sse_abstracts = SPARQL.parse(tmp_query)
sse_abstracts.execute(tmp_graph) do |res|
	puts res.abs
end
