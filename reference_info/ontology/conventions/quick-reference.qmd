# Quick reference

# Ontology Conventions

> Extracted from: *DFO Salmon Ontology Conventions – Compliance and Improvement Analysis* (downloaded markdown) > > This page includes the **conventions guide content** and omits the earlier analysis/preamble where possible.

(This rewritten guide integrates the analysis and recommendations above. It is structured for clarity, with minimal

redundancy, and aligns with OWL 2 DL, OBO Foundry principles, and contributor usability. All key modeling rules

are retained.)


## How

If you’re an experienced contributor looking for a quick reference, this section is for you. It summarizes the most

essential conventions at a glance.

OWL classes/properties: rdfs:label "Preferred Name"@en


SKOS concepts: skos:prefLabel "Preferred Name"@en

(Use English labels; one preferred label per language.)

OWL classes/properties: IAO:0000115 "Concise definition of the term."@en

SKOS concepts:

skos:definition   "Concise   definition   of   the   concept."@en

(Aim for 1–2 sentences capturing the meaning. Avoid circular phrasing.)

(This IRI points to our ontology and signals where the term is defined. Include it for every term.)

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon>

"CODE"^^ex:DataType

dcterms:identifier   "DFO-SALMON:000123"

skos:notation

(Do  not  put   IDs   or   codes   in   the   rdfs:label!   Keep   labels   readable,   and   use   skos:notation   or
dcterms:identifier  for machine-oriented codes.)

IAO:0000119 "Reference for definition."@en

dcterms:source <DOI or URL>

(Include these if the definition was taken from or inspired by an external source. They give credit and

context.)

context."@en

IAO:0000112 "Example usage of this term in a sentence or

(Optional, but great for clarity. Provide if the meaning might be unclear or the reviewer requested it.)

oboInOwl:hasExactSynonym   "Synonym   Term"@en

skos:altLabel

(Optional. Use OBO’s synonym properties for classes/properties with scope (exact, broad, narrow, related)
. For SKOS, you can use multiple  skos:altLabel  entries for informal synonyms or abbreviations.

98

Mark all alt labels with language tags.)

EscapementSurveyEvent

GeneticSample

aboutStock

hasMember

usesMethod

SonarCounting

Type2


### Rationale

salmon.ttl

Why:

Chinook_SpeciesCode

dfo-

Stock

SurveyEvent

Measurement

Never model the same term as both an OWL class and a SKOS concept

is a type of

hasMember

hasMemberCU

hasMemberStock

hasMember

:FraserCUCoho

### Example
hasMemberStock :FraserCohoStock

:BCInteriorMU hasMemberCU :FraserCUCoho

:BCInteriorMU

hasMember :FraserCohoStock

### Tip

a owl:TransitiveProperty


dwc:measurementType

dwciri:measurementType

dwc:measurementValue

dwc:measurementUnit

dwciri:measurementUnit

dfo:aboutStock

dfo:observedDuring

dfo:usesMethod

(These properties are defined in our ontology or reused; see Measurement Patterns for details.)

### Example
EscapementMeasurement

rdfs:subClassOf sosa:Observation

:SomeObservation

rdf:type iop:Variable

### Example

RO:0002351 (has member)

dfo:hasMember

rdfs:seeAlso

owl:equivalentClass

owl:equivalentProperty

rdfs:seeAlso

not OWL reasoning


EscapementSurveyEvent

dfo:measuredVisits

### Example
dfo:usesEnumerationMethod

dfo:measuredVisits ≥

EscapementSurveyEvent

### Bottom line

ENVO:lake

owl:ObjectProperty

owl:DatatypeProperty

report

robot reason

verify

dwc:Event

owl:Thing
