# SKOS vocabularies

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
