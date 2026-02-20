# OWL properties

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
