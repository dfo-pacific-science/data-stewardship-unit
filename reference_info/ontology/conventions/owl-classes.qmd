# OWL classes

:YourClassName a owl:Class .

rdfs:label

:GeneticSample rdfs:label "Genetic Sample"@en .

(Make sure the label is singular noun (in most cases) and describes the essence of the class. Use plural only if the
concept itself is plural by nature (rare). Only one   rdfs:label   per language is allowed — no duplicates.)

IAO:0000115

:GeneticSample IAO:0000115 "A biological sample taken from a fish (e.g., a fin clip

or scale) for genetic analysis."@en .

(Avoid using the class name in the definition if possible. Ensure the definition would make sense to someone

outside the project. Aim for necessary and sufficient conditions in natural language — what is it, and how is it

different from related things.)
:GeneticSample rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> .

rdfs:isDefinedBy

:EscapementSurveyEvent rdfs:subClassOf dwc:Event .

rdfs:subClassOf

rdfs:subClassOf

SpawnerEstimationSurvey


SpawnerEstimationSurvey subClassOf usesMethod some EnumerationMethod

owl:disjointWith

MaleFish

FemaleFish

dcterms:source

dcterms:source

IAO:0000119

IAO:0000119

:BaselineGeneticDataset IAO:0000115 "A dataset consisting of genetic profiles used

as a reference for stock identification."@en ;

IAO:0000119   "Definition   adapted   from   DFO   (2020)   Genetic   Baseline

documentation."@en ;

dcterms:source <https://doi.org/10.1234/dfogenetics.2020.baseline> .

(This shows someone where the definition came from or where to find more info. It’s optional but very useful,

especially for technical terms.)

IAO:0000112

:Stock IAO:0000112 "Example: The Fraser River Late-Run sockeye stock is a stock that

has specific genetic and life history characteristics."@en .

rdfs:comment

rdfs:comment

oboInOwl:hasExactSynonym "Alternative Name"@en

oboInOwl:hasBroadSynonym

...hasNarrowSynonym

...hasRelatedSynonym

skos:altLabel

skos:altLabel

skos:altLabel

dcterms:subject

gcdfo:module


:ConservationUnit a owl:Class ;

rdfs:label "Conservation Unit"@en ;

IAO:0000115 "A group of wild Pacific salmon sufficiently isolated that

evolutionarily significant differences develop, used as a unit for conservation

and management."@en ;

rdfs:subClassOf :StockAggregation ;

# say we have a class for stock

groupings

rdfs:subClassOf RO:0002161 ;

# for example, RO:0002161 could be

'population group' if exists

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> ;

oboInOwl:hasExactSynonym "CU"@en ;

IAO:0000119 "DFO (2005) Wild Salmon Policy glossary"@en ;

dcterms:source <http://publications.gc.ca/collections/collection_2018/mpo-dfo/

Fs23-604-2005-eng.pdf> .

owl:equivalentClass

OBI:Specimen

WaterSample

OBI:Specimen
