# 🧾 README: Instructions for Completing the Data Dictionary Template

This document is a detailed guide for completing the **Data Dictionary Template** provided by the Data Stewardship Unit. The goal is to help you describe your dataset's variables clearly, consistently, and in a machine-readable format so they can be harmonized with the **Salmon Population Summary Repository (SPSR)** data model and used in integrated data products and scientific assessments.

We’ve designed this template to be accessible for scientists who may be unfamiliar with data standards, controlled vocabularies, or semantic technologies.

---

## 📋 Overview of Tabs in the Spreadsheet

- **README** – This page
- **Metadata** – General information about your project and submission
- **Data Dictionary** – A row for each variable in your dataset

---

## 📘 Definitions and Concepts

### URI (Uniform Resource Identifier)

A **URI** is a web link (like a URL) that uniquely identifies a concept, such as a variable or unit. In our template, URIs point to definitions in controlled vocabularies or ontologies so others (including machines and software tools) can unambiguously understand what a variable means.

> 🧠 Example:  
> `http://purl.dataone.org/odo/SALMON_00000782` identifies a specific concept in a salmon ontology.

---

## 🧾 Column-by-Column Instructions

### `data_file` (Required)

- **What to enter**: The exact name of the dataset file where this variable appears.
- **Purpose**: Helps link variables to their origin for traceability.
- **Example**: `escapement_2022.csv`

---

### `variable_name` (Required)

- **What to enter**: The **exact column name** as it appears in the data file.
- **Purpose**: Ensures technical alignment for merging or validation.
- **Example**: `Spawner_Count`

---

### `label` (Recommended)

- **What to enter**: A human-readable version of the variable name.
- **Purpose**: Improves readability and presentation for dashboards or reports.
- **Example**: `Spawner Count`

---

### `data_type` (Recommended)

- **What to enter**: One of the following standard options:

  - `string` – for free text
  - `integer` – for whole numbers
  - `float` – for decimal values
  - `boolean` – for TRUE/FALSE
  - `categorical` – for fixed-value categories

- **Purpose**: Supports validation, modeling, and database conversion.
- **Example**: `float`

---

### `definition_uri` (Recommended if available)

- **What to enter**: A URI (web link) that points to an authoritative definition of the variable.
- **Examples**:

  - A concept in a published ontology: `http://purl.dataone.org/odo/SALMON_00000239`
  - A definition page on a public site: `https://open.canada.ca/data/en/dataset/stream-temp`
  - A report or document PDF **(last resort)**: `https://www.dfo-mpo.gc.ca/reports/escapement-guidelines.pdf#page=13`

- **Purpose**: Links your variable to established definitions for semantic alignment and AI usage.

---

### `definition` (Required if no URI is given)

- **What to enter**: A plain-language explanation of what the variable represents.
- **Tips**:
  - Be clear and specific
  - Describe what is measured, counted, or categorized
- **Example**: `The number of adult fish returning to a spawning area.`

---

### `method` (Recommended)

- **What to enter**: A description of how the value is measured, estimated, or calculated.
- **Options**:

  - Write it out (`Visual count during weekly stream surveys`)
  - Link to a standard method PDF or protocol site
  - Reference a method in a published vocabulary or guideline

- **Useful vocabularies**:
  - [CF Conventions](https://cfconventions.org/)
  - [OBIS sampling methods](https://vocab.nerc.ac.uk/collection/S03/current/)
  - [DFO internal monitoring protocols] if available

---

### `unit` (Recommended if numeric)

- **What to enter**: A plain text description of the unit of measurement.
- **Example**: `number of fish`, `percent`, `°C`, `year`

- **Purpose**: Prevents confusion and ensures consistency.

---

### `unit_uri` (Recommended if available)

- **What to enter**: A URI identifying the unit of measurement in a standardized vocabulary.
- **Use this vocabulary**:  
  [NERC Vocabulary Server P06](http://vocab.nerc.ac.uk/collection/P06/current/)

- **Example**: `http://vocab.nerc.ac.uk/collection/P06/current/UPMS/`

---

### `accepted_values` (Optional; recommended for categorical fields)

- **What to enter**:

  - A comma-separated list: `Red, Amber, Green`
  - Or a URI pointing to a controlled vocabulary for the field

- **Purpose**: Enables dropdowns, validation, and consistent categorization.

- **Examples**:
  - Manual list: `Yes, No, Unknown`
  - Controlled URI: `http://vocab.nerc.ac.uk/collection/L22/current/`

---

## 💡 General Guidance

- Fill out as much as you can. If you’re unsure, leave a field blank and add a comment.
- Use the provided examples and links for inspiration.
- This form supports future validation and automation — investing time now saves effort later.
- If you're stuck, contact the Data Stewardship Unit for help or examples.

---

## 🧭 Next Step

Once you've completed the template:

1. Save the file as an Excel spreadsheet (`.xlsx`)
2. Send it to the Data Stewardship Unit contact person
3. We will validate it against our controlled vocabulary and align it with the SPSR schema

Thank you for your contribution to making salmon data more interoperable and reusable!
"""

# Write it to a Markdown file

verbose_readme_path = "/mnt/data/verbose_data_dictionary_readme.md"
with open(verbose_readme_path, "w") as f:
f.write(verbose_readme)

verbose_readme_path
