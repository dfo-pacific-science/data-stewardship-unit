# Full (raw)

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

:yourProperty a owl:ObjectProperty .

rdfs:label

owl:ObjectProperty


:usesMethod rdfs:label "uses method"@en .

:hasMember rdfs:label "has member"@en .

(We try to name properties from the perspective of the subject, and often use conventional verb phrasing. Avoid

overly long labels; a couple of words is fine.)

IAO:0000115

:usesMethod  IAO:0000115  "Relates  an  observation  or  measurement  to  the  method  or

protocol employed to obtain it."@en .

:aboutStock IAO:0000115 "Indicates which fish stock an observation or measurement is

about or pertains to."@en .

(The definition should clarify directionality and intent: e.g., “X usesMethod Y means X employed Y as a method.”)

rdfs:isDefinedBy

rdfs:isDefinedBy   <https://w3id.org/gcdfo/salmon>

rdfs:domain

rdfs:range

dfo:hasMember

:hasMemberStock rdfs:domain :ConservationUnit ; rdfs:range :Stock .

hasMemberStock

dfo:usesMethod

owl:FunctionalProperty

owl:TransitiveProperty.

owl:FunctionalProperty

owl:inverseOf

owl:TransitiveProperty

owl:SymmetricProperty

:hasMember a

:isColleagueOf

dfo:hasBroodYear

:hasBroodYear a

:hasParent

:hasOffspring

:hasOffspring   owl:inverseOf   :hasParent.

rdfs:subPropertyOf

RO:0002351 (has member)

dfo:hasMember

owl:equivalentProperty


:hasMember rdfs:subPropertyOf RO:0002351 ; owl:equivalentProperty RO:0002351 .

dfo:

subproperty

import and reuse RO properties, or if needed make a

dwc:eventDate

dfo:eventDate

dwc:eventDate

:escapementDate

subPropertyOf dwc:eventDate

skos:exactMatch

closeMatch

rdfs:seeAlso

owl:Thing

skos:prefLabel

rdfs:label

rdfs:comment

IAO:0000112

skos:prefLabel

rdfs:label

:observedDuring a owl:ObjectProperty ;

rdfs:label "observed during"@en ;

IAO:0000115 "Links an observation or measurement to an event during which it

was made.

The subject is typically a data item or result, and the

object is an Event (e.g., a Survey event)."@en ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> ;

rdfs:domain :Observation ;

# if we have a class for observations/

measurements

rdfs:range dwc:Event ;

# aligning to Darwin Core Event

rdfs:subPropertyOf prov:used ;

# we align this as a specialization of

PROV-O used (an activity used an entity)

dcterms:source <https://dwc.tdwg.org/terms/#dwc:eventID> .

# maybe we cite

DwC or PROV as inspiration


(Note: prov:used has domain prov:Activity and range prov:Entity. By subProperty, we imply our Observation is

a kind of Activity using an Event (Entity). That’s a bit semantically odd because one might think Observation is an

entity not an activity – we’d double-check alignment. But this is just illustrative.)

axioms

hasMember

hasMember

hasMemberCU

hasMemberStock

hasMemberCU o hasMemberStock -> hasMemberStock

owl:propertyChainAxiom


owl:DatatypeProperty .

rdfs:label

:yourDataProp a

dfo:proportion rdfs:label

"proportion"@en .

dfo:measuredWeight rdfs:label "measured weight"@en .

IAO:0000115

:proportion   IAO:0000115   "The   proportion   of   the   sample   belonging   to   a   specified

category, expressed as a decimal fraction (0–1)."@en .

:streamName   IAO:0000115   "The   name   of   the   stream   or   river   where   the   activity

occurred, as a text string."@en .

rdfs:isDefinedBy

dfo:proportion

:GSICompositionMeasurement

:forkLength

:Fish

rdfs:domain

:forkLength rdfs:range xsd:decimal .

:eventDate rdfs:range xsd:date .

:speciesCode rdfs:range xsd:string .

forkLength

forkLength

rdfs:comment

:forkLength skos:note "Unit: centimeters."@en

dwc:eventDate

dfo:eventDate

schema:latitude

owl:equivalentProperty

dfo:basedOnSamples

dcterms:source

IAO:0000119


rdfs:comment

:proportion rdfs:comment

"Expected value between 0 and 1."@en.

rdfs:label

:proportion a owl:DatatypeProperty ;

rdfs:label "proportion"@en ;

IAO:0000115 "The proportion of the sample or collection belonging to a

specific category (e.g., genetic stock), expressed as a value between 0 and

1."@en ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> ;

rdfs:domain :GSICompositionMeasurement ;

rdfs:range xsd:decimal ;

dcterms:identifier "PROP" ;

# maybe it corresponds to a code in some system,

included as literal identifier

skos:note "Value 0.0 to 1.0 (unitless fraction)."@en .

:tagCode a owl:DatatypeProperty ;

rdfs:label "tag code"@en ;

IAO:0000115 "Identifier code read from a physical tag (e.g., PIT tag or

spaghetti tag) attached to a fish."@en ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> ;

rdfs:domain :Fish ;

rdfs:range xsd:string ;

skos:note "Typically a alphanumeric string, length varies by tag type."@en .

dcterms:identifier


SKOS concepts

skos:Concept

skos:Concept

:SonarCounting   a   skos:Concept   .

skos:prefLabel

:SonarCounting skos:prefLabel "Sonar counting"@en .

(Use sentence case or title case as appropriate. Unlike class labels, concept labels can be more free-form (they

often match how it’s written in docs). Only one prefLabel per language per concept, by SKOS spec.)

skos:inScheme

skos:ConceptScheme

:SonarCounting skos:inScheme :EscapementMethodScheme .

skos:ConceptScheme

:EscapementMethodScheme   a   skos:ConceptScheme;   skos:prefLabel   "Escapement   Method

Scheme"@en   .

skos:definition

:SonarCounting skos:definition "A fish counting method using active acoustic devices

(e.g., DIDSON/ARIS sonar) to estimate escapement."@en .

rdfs:isDefinedBy   <https://

w3id.org/gcdfo/salmon>

dcterms:source <URL or DOI>

IAO:0000119 "Source text or citation."@en

skos:notation

skos:notation


:SonarCounting skos:notation "ESC-001"^^ex:DFOEscMethodCode .

ex:DFOEscMethodCode

skos:broader

skos:narrower

skos:related

:SnorkelSurvey skos:broader :EscapementSurveyMethod .

skos:altLabel

:SonarCounting skos:altLabel "Sonar"@en ; skos:altLabel "Didson count"@en .

not

equivalent concept>

Do not

skos:exactMatch <IRI of

skos:closeMatch <IRI>

:ChinookSalmon   skos:exactMatch   <http://id.gbif.org/species/2398734>   .

:SonarCounting rdfs:subClassOf ...

skos:ConceptScheme

skos:ConceptScheme

a

EscapementMethodScheme

LifeStageScheme

CoverageCategoryScheme

skos:hasTopConcept

:EscapementMethodScheme   skos:hasTopConcept   :CountingMethod   .

dcterms:description

:EscapementMethodScheme a skos:ConceptScheme ;

skos:prefLabel "Escapement Enumeration Method Scheme"@en ;

dcterms:description "Controlled vocabulary of methods used to estimate salmon


escapement."@en ;

dcterms:creator "DFO Pacific Region"@en ;

skos:hasTopConcept :CountingMethod .

# top category concept

:CountingMethod a skos:Concept ;

skos:prefLabel "Counting method"@en ;

skos:definition "A general method for counting or estimating fish in the

river."@en ;

skos:inScheme :EscapementMethodScheme ;

skos:narrower :SonarCounting , :SnorkelSurvey , :WeirCount ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> .

:SonarCounting a skos:Concept ;

skos:prefLabel "Sonar counting"@en ;

skos:definition "Counting fish using active acoustic devices (sonar cameras

like DIDSON/ARIS) to estimate passage."@en ;

skos:inScheme :EscapementMethodScheme ;

skos:broader :CountingMethod ;

skos:notation "ESC-001"^^ex:DFOEscMethodCode ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> ;

dcterms:source <https://doi.org/10.1234/dfo-esc-methods-2023> ;

IAO:0000119 "DFO (2023) Escapement Survey Methods Manual."@en .

:SnorkelSurvey a skos:Concept ;

skos:prefLabel "Snorkel survey"@en ;

skos:definition

"A method where divers snorkel through the river to count fish visually."@en ;

skos:inScheme :EscapementMethodScheme ;

skos:broader :CountingMethod ;

skos:altLabel "Snorkeling count"@en ;

skos:notation "ESC-002"^^ex:DFOEscMethodCode ;
rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> .

(In this example, “CountingMethod” is a broader category concept, with SonarCounting and SnorkelSurvey as

narrower. We gave them notation codes ESC-001, ESC-002, presumably defined by DFO for each method.)

skos:prefLabel

rdfs:label

rdfs:label

rdfs:label


a skos:Concept

skos:prefLabel

skos:inScheme

skos:notation

Do not use subclass or domain/range with these.

dfo:usesMethod

rdfs:label

“Smith et al (2020) defined escapement as...”

“From FAO Fisheries Glossary (2008).”

dcterms:source

IAO:0000119

:Escapement IAO:0000115 "The estimated number of fish that escape fisheries and

reach the spawning grounds."@en ;

IAO:0000119 "Defined in Pacific Salmon Treaty, Glossary (2009)."@en ;

dcterms:source <https://example.org/PST2009Glossary> .

(This is hypothetical.)

@en


dc:creator

prov:wasAttributedTo

dcterms:creator

dcterms:creator "DFO Salmon Team"

dcterms:modified

dcterms:created

skos:note

oboInOwl:consider

oboInOwl:note

skos:scopeNote

skos:editorialNote

rdfs:comment

“This class is provisional, pending review by WG.”
skos:editorialNote "Provisional term - definition to be finalized."@en .

IAO:0000112

IAO:0000112

rdfs:isDefinedBy

rdfs:label

IAO:0000115

rdfs:isDefinedBy   <http://purl.obolibrary.org/obo/bfo.owl>

dcterms:source

oboInOwl:hasDefinitionSource

bfo:0000015 a owl:Class ;

rdfs:label "process"@en ;

IAO:0000115 "An occurrent that has temporal parts."@en ;

rdfs:isDefinedBy <http://purl.obolibrary.org/obo/bfo.owl> .

owl:versionInfo

owl:versionIRI


dcterms:license

dcterms:creator

dcterms:issued

dc:date

rdfs:seeAlso

rdfs:seeAlso   <https://open.canada.ca/data/en/dataset/escapement-survey-

EscapementSurveyEvent

manual-2023> .

dcterms:identifier

dcterms:identifier

skos:notation

:SnorkelSurveyShape  a  sh:NodeShape;  rdfs:label  "Snorkel  survey  data  completeness

shape"@en; sh:targetClass :EscapementSurveyEvent; ...

rdfs:label

rdfs:comment

:StockAssessmentReport a owl:Class ;

rdfs:label "Stock Assessment Report"@en ;

IAO:0000115 "A document presenting the analysis and results of a stock

assessment for a fish population."@en ;

rdfs:isDefinedBy <https://w3id.org/gcdfo/salmon> ;

IAO:0000119 "Term and definition from DFO Stock Assessment Manual

(2021)."@en ;

dcterms:source <https://doi.org/10.1234/DFO-SA-Manual-2021> ;

dcterms:creator "DFO Science Branch, Pacific Region"@en ;

rdfs:seeAlso <https://pacific-salmon-library.example.org/stock-assessment-

reports> .


rdfs:label

IAO:0000115

oboInOwl:hasScope

hasExactSynonym

IAO:0000122

dcterms:license

owl:deprecated true

skos:editorialNote

dc:subject

rdfs:label

oboInOwl:hasExactSynonym

oboInOwl:hasBroadSynonym

oboInOwl:hasNarrowSynonym

oboInOwl:hasRelatedSynonym


oboInOwl:SynonymType

skos:altLabel

skos:hiddenLabel

@en

@en

@fr

@cr

not

escapement"@en

rdfs:label

"Salmon escapement"

"Salmon

GeneticSample

skos:prefLabel   "ESC-001   Sonar   counting"

skos:notation

dcterms:identifier

owl:deprecated true

rdfs:comment "This term is deprecated, use XYZ instead."

oboInOwl:consider

owl:equivalentClass

:EscapementMeasurement a owl:Class ;

rdfs:label "Escapement Measurement"@en ;


IAO:0000115 "A measurement related to salmon escapement (e.g., count of

fish passing a site)."@en ;

oboInOwl:hasExactSynonym "Escapement Count"@en ;

oboInOwl:hasNarrowSynonym "Fence Count"@en ;

# fence count is a specific type of escapement count

...

:SpawningCategory a skos:Concept ;

skos:prefLabel "Spawning observed"@en ;

skos:altLabel "Spawning present"@en ;

skos:altLabel "Spawning seen"@en ;

skos:definition "Indicates that spawning activity was observed in the

survey."@en ;

skos:inScheme :ObservationOutcomeScheme .

:EscapementMeasurement rdfs:label "Mesure d'échappée"@fr .

:EscapementMeasurement IAO:0000115 "Mesure du nombre de poissons échappant

à la pêche et atteignant les frayères."@fr .

@en

oboInOwl:hasExactSynonym

skos:prefLabel


(End of Section 2. Core Conventions. The following sections would continue as per the Table of Contents, applying
