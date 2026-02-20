# Schema vs data (TBox vs ABox)

(The table of contents below mirrors the structure of the guide for easy navigation.)

📚


(Use the links above to jump to the relevant section in this Markdown, especially if viewing through WIDOCO or

GitHub.)

SurveyEvent

GeneticSample

Stock

Stock

:SkeenaSnorkelSurvey2022_001

EscapementSurveyEvent

rdf:type

:FraserCohoStock

SonarCounting

skos:Concept

Measurement

Stock

dfo:hasMember

dfo:aboutStock


ManagementUnit

ConservationUnit

dwc:measurementValue

1250

schema

data

ontology/dfo-salmon.ttl

only if

EscapementSurveyEvent

Stock

Measurement

ConservationUnit

usesEnumerationMethod

aboutStock

hasMember

proportion

:SnorkelSurvey

:SonarCounting

skos:Concept

:EscapementMethodScheme

owl:equivalentClass

owl:equivalentProperty

rdfs:subClassOf

:SkeenaSurvey2022_Aug15


survey-2022.ttl

In the ontology (schema) file:

data/

:EscapementSurveyEvent a owl:Class ;

rdfs:label "Escapement Survey Event"@en ;

IAO:0000115 "A salmon escapement survey at a particular time and place,

measuring spawning metrics."@en ;

rdfs:subClassOf dwc:Event ;

# aligning with Darwin Core's Event class

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> .

:SnorkelSurvey a skos:Concept ;

skos:prefLabel "Snorkel Survey"@en ;

skos:definition

"A survey method where observers count fish while snorkeling in the

stream."@en ;

skos:inScheme :EscapementMethodScheme ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> .

In a separate data file (e.g., data/escapement-2022.ttl ):

# Individual survey event in 2022 using snorkel method

:SkeenaEscapementSurvey_2022_08_15 a :EscapementSurveyEvent ;

dfo:usesEnumerationMethod :SnorkelSurvey ;

# link to the SKOS concept

dfo:measuredVisits 6 ;

# datatype property (6

visits)

dfo:measuredReachCoverage 0.85 ;

# 85% reach coverage

dwc:eventDate "2022-08-15"^^xsd:date ;


dfo:locatedIn :SkeenaRiverWatershed .

# suppose we have a property for location

EscapementSurveyEvent means

SnorkelSurvey

(For more on this, see also [W3C Best Practice] on separating ontology TBox from data ABox, and OBO’s stance on

release files.)

Stock

EscapementSurveyEvent

dwc:Event

ForkLength

concrete or conceptual entities

ConservationUnit

that might appear in dropdown lists

skos:Concept

categorical values, methods, classifications,

terms


skos:broader

skos:narrower

skos:Concept

rdfs:subClassOf

SonarCounting

dfo:usesMethod

Female

Male

Red Zone

subClassOf

Stock

rdf:type


rdf:type

Population

(For the curious: W3C’s SKOS Reference notes that treating OWL classes as instances of skos:Concept leads to OWL

Full semantics

5

. Our approach using separate SKOS individuals avoids this issue entirely.)

OBI:0001479
