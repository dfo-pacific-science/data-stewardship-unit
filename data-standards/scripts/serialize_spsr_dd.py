import pandas as pd
import json
from rdflib import Graph, Namespace, URIRef, Literal
from rdflib.namespace import RDF, RDFS, SKOS

# --- Step 1: Load the data dictionary from Excel ---
excel_path = "data-standards\data-dictionaries\spsr_standardized_data_dictionary.csv"
df = pd.read_csv(excel_path)

# --- Step 2: Clean and normalize (if needed) ---
# Fill NaNs with empty strings for export
df = df.fillna("")

# --- Step 3: Export to plain JSON ---
json_data = df.to_dict(orient="records")
json_output_path = "data-standards/vocab/spsr_vocab.json"
with open(json_output_path, "w") as f:
    json.dump(json_data, f, indent=2)

# --- Step 4: Export to JSON-LD ---
jsonld_data = {
    "@context": {
        "term_id": "@id",
        "label": "rdfs:label",
        "definition": "skos:definition",
        "definition_uri": {"@id": "rdfs:isDefinedBy", "@type": "@id"},
        "data_type": "spsr:dataType",
        "method": "spsr:method",
        "unit": "spsr:unit",
        "unit_uri": {"@id": "spsr:unitURI", "@type": "@id"},
        "accepted_values": "spsr:acceptedValues",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "skos": "http://www.w3.org/2004/02/skos/core#",
        "spsr": "http://example.org/spsr/"
    },
    "@graph": []
}

for _, row in df.iterrows():
    uri = row["definition_uri"] if row["definition_uri"].startswith("http") else f"http://example.org/spsr/{row['variable_name'].lower()}"
    jsonld_data["@graph"].append({
        "@id": uri,
        "rdfs:label": row["label"],
        "skos:definition": row["definition"],
        "spsr:dataType": row["data_type"],
        "spsr:method": row["method"],
        "spsr:unit": row["unit"],
        "spsr:unitURI": row["unit_uri"],
        "spsr:acceptedValues": row["accepted_values"]
    })

jsonld_output_path = "data-standards/vocab/spsr_vocab.jsonld"
with open(jsonld_output_path, "w") as f:
    json.dump(jsonld_data, f, indent=2)

# --- Step 5: Export to Turtle (TTL) format using RDFLib ---
ttl_graph = Graph()
SPSR = Namespace("http://example.org/spsr/")
ttl_graph.bind("spsr", SPSR)
ttl_graph.bind("skos", SKOS)
ttl_graph.bind("rdfs", RDFS)

for _, row in df.iterrows():
    uri = URIRef(row["definition_uri"]) if row["definition_uri"].startswith("http") else URIRef(f"http://example.org/spsr/{row['variable_name'].lower()}")
    ttl_graph.add((uri, RDF.type, SKOS.Concept))
    ttl_graph.add((uri, SKOS.prefLabel, Literal(row["label"], lang="en")))
    ttl_graph.add((uri, SKOS.definition, Literal(row["definition"], lang="en")))
    if row["data_type"]:
        ttl_graph.add((uri, SPSR.dataType, Literal(row["data_type"])))
    if row["method"]:
        ttl_graph.add((uri, SPSR.method, Literal(row["method"])))
    if row["unit"]:
        ttl_graph.add((uri, SPSR.unit, Literal(row["unit"])))
    if row["unit_uri"].startswith("http"):
        ttl_graph.add((uri, SPSR.unitURI, URIRef(row["unit_uri"])))
    if row["accepted_values"]:
        ttl_graph.add((uri, SPSR.acceptedValues, Literal(row["accepted_values"])))

ttl_output_path = "data-standards/vocab/spsr_vocab.ttl"
ttl_graph.serialize(destination=ttl_output_path, format='turtle')

json_output_path, jsonld_output_path, ttl_output_path
