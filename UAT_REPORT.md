# User Acceptance Test Report: FADS Open Science Hub
## Persona: DFO Science Biologist - Pacific Salmon Research

**Date:** 2026-01-08
**Tester Role:** DFO Science Biologist conducting research and monitoring of Pacific salmon
**Primary Goal:** Find guidance on data standardization for publication and sharing in a Fishery Science Advisory Report (FSAR)
**Site:** FADS Open Science Hub (Data Stewardship Unit Documentation)

---

## Executive Summary

As a DFO salmon biologist needing help with data standardization for an upcoming FSAR publication, I explored the FADS Open Science Hub to evaluate its usability, content clarity, and ability to guide me through the data standardization process. This report summarizes my findings across navigation, content quality, search functionality, and overall user experience.

**Overall Assessment:** ⭐⭐⭐⭐½ (4.5/5)

The site is well-structured, comprehensive, and provides excellent resources for data standardization. The controlled vocabulary search is particularly impressive. However, there are opportunities to improve discoverability for first-time users and clarify the relationship between different data standards resources.

---

## Test Scenario

**Background:** I'm a salmon biologist who has collected spawner abundance data, age composition samples, and environmental conditions across multiple streams over three field seasons. I need to:
1. Standardize my data for an upcoming FSAR
2. Understand what vocabulary terms I should use
3. Learn how to structure my data files for publication
4. Find out where and how to publish the data

---

## Detailed Findings

### 1. Homepage & First Impressions ⭐⭐⭐⭐½

#### Strengths
✅ **Clear branding and purpose** - The fish emoji (🐟💾) and "FADS Open Science Hub" title immediately communicate the focus
✅ **Excellent search prominence** - The homepage features a prominent "Search all articles" button with keyboard shortcut hint (Ctrl/Cmd + K)
✅ **Latest articles widget** - Shows the 5 most recent additions, helping me see what's new
✅ **Category browsing** - Four clear categories with helpful emojis and brief descriptions:
- How-to Guides 🛠
- Reference Info 📘
- Tutorials 🎓
- Deep dives 🧠

#### Areas for Improvement
⚠️ **No visual hero/banner** - For a first-time visitor, a banner or graphic showing "What can this hub help you with?" with common use cases would be helpful
⚠️ **Navigation for my specific goal unclear** - While the categories are clear, it's not immediately obvious which path to take for "standardizing data for FSAR". A quick-start guide or user journey map would help
⚠️ **Link to internal SharePoint wiki** - The prominent link to the internal FADS Wiki isn't accessible (requires authentication), which could confuse external collaborators or CSAS participants

**Recommendation:** Add a "Getting Started" or "Common Tasks" section on the homepage with direct links like:
- "Preparing data for a Fisheries Science Advisory Report"
- "Understanding salmon data terminology"
- "Publishing salmon data externally"

---

### 2. Navigation & Information Architecture ⭐⭐⭐⭐⭐

#### Strengths
✅ **Excellent top navbar** - Clean, minimal, with clear sections:
- FADS Internal Wiki (external link)
- About
- Data Services
- Salmon Data Standards (direct link to the most important page!)

✅ **Comprehensive sidebar** - Well-organized with collapsible sections:
- How-to Guides (auto-generated)
- Reference Info → Salmon Data Standards subsection ⭐
- Tutorials
- Deep Dives

✅ **"Salmon Data Standards" given prominence** - Both in navbar and as a subsection in sidebar

✅ **GitHub integration** - GitHub icon in navbar with dropdown for "Source Code" and "Report a Bug"

✅ **Persistent search** - Search available in both navbar and sidebar

#### Areas for Improvement
⚠️ **Deep link in navbar** - The navbar link goes directly to "Controlled Vocabulary & Thesauri" rather than a Salmon Data Standards index/overview page. First-time users might miss that there are multiple related pages (SDEP, Formal Documentation)
⚠️ **Sidebar auto-collapse** - No indication of which section I'm currently viewing. Breadcrumbs would help

**Recommendation:** Create a "Salmon Data Standards" landing page that explains:
- What the standards are (controlled vocabulary, SDEP, ontology)
- When to use each one
- How they relate to each other
Then link to this from the navbar instead of going directly to controlled vocabulary

---

### 3. Controlled Vocabulary & Thesauri Page ⭐⭐⭐⭐⭐

**This is the star of the site!** 🌟

#### Strengths
✅ **Clear introduction** - Explains what the controlled vocabulary is and why it exists
✅ **Actionable callout** - Prominent note box explaining how to request new terms or changes via GitHub issues or email
✅ **Summary statistics** - At the top: total terms, number of themes, with visual bar charts showing term distribution by theme

✅ **Powerful search functionality:**
- Real-time search with 300ms debounce
- Searches across term names, definitions, AND related terms
- Multi-word search (all words must match - great for narrowing results)
- Clear result count display
- Results show: term name, theme badge, definition, source citation with link, canonical URI with copy button

✅ **Browse all terms table (Reactable):**
- Interactive, sortable, filterable table
- Columns: Theme, Term Name, Definition, Definition Source (as links), Related Terms (clickable), Term ID (URI)
- Pagination with customizable page size (10, 25, 50, 100)
- Built-in search within table
- Theme filtering via dropdown with select/deselect all controls

✅ **Excellent metadata for each term:**
- Clear definitions
- Source citations (with external links when available)
- Related terms with relationship types (broader, narrower, related)
- Persistent URIs (canonical_uri)
- Copy-to-clipboard functionality for URIs

✅ **About section** - Explains SKOS structure and living document philosophy

#### Areas for Improvement
⚠️ **No contextual help for search syntax** - While the search tip mentions "multiple words", examples of effective searches would help (e.g., "spawner abundance", "age class")
⚠️ **"Related Terms" links are not clickable to filter** - The related terms show clickable styling but clicking them doesn't navigate or filter to show that term
⚠️ **No export functionality** - As a biologist, I might want to export a subset of terms (e.g., all "Stock Assessment" terms) as CSV or JSON for my data dictionary. Currently must copy-paste manually
⚠️ **Theme descriptions missing** - The theme dropdown shows theme names but no description of what each theme covers

**Recommendation:**
1. Make related terms interactive - clicking should filter/highlight that term
2. Add an "Export visible terms" button (CSV/JSON)
3. Add theme descriptions as tooltips or in a collapsible info panel
4. Add search examples: "Try: spawner escapement" or "reference point harvest"

---

### 4. Salmon Data Exchange Package (SDEP) Specification ⭐⭐⭐⭐

#### Strengths
✅ **Comprehensive technical spec** - Clearly documents the SDEP structure, CSV schemas, and fields
✅ **Excellent design goals section** - Explains the "why" before the "how"
✅ **Concrete package layout** - Shows directory structure with example filenames
✅ **Detailed schemas** - Tables for dataset.csv, tables.csv, column_dictionary.csv, and codes.csv with required/optional fields
✅ **Ontology integration explained** - Links between SDEP and the DFO Salmon Ontology (metric_iri, dimension_iri, concept_iri)
✅ **Clear relationship to tools** - Explains how R packages, GPT assistants, and ontology work together

#### Areas for Improvement
⚠️ **No concrete example** - The spec is thorough but lacks a complete "hello world" example. A ZIP download with a minimal working SDEP would be incredibly valuable
⚠️ **Column role definitions buried** - The `column_role` options (id, measure, dimension, flag, metadata) are mentioned but not defined until later. A table defining each role would help
⚠️ **Validation unclear** - How do I validate my SDEP? Is there an R function? A GitHub Action? This is mentioned but not linked
⚠️ **No workflow diagram** - A visual showing "My Excel file → SDEP → Validation → Publication" would help non-technical users

**Recommendation:**
1. Create a downloadable example SDEP package (with fake data)
2. Add a "Quick Start: Create Your First SDEP" tutorial
3. Link to validation tools (R package function, scripts)
4. Add visual workflow diagram showing the data standardization pipeline

---

### 5. Publishing Data Externally / Hosting Data and Code ⭐⭐⭐⭐⭐

**Extremely practical and directly relevant to FSAR workflows!**

#### Strengths
✅ **Excellent table-based guidance** - Table 1 clearly shows what platforms are allowed for Unclassified/Protected A/Protected B data
✅ **Color-coded permissions** - Green checkmarks, yellow warnings, red X's make it easy to scan
✅ **FSAR-specific guidance** - Explicitly addresses FSAR workflows and approval requirements
✅ **Data classification quick reference** - Examples help me understand if my data is Unclassified vs Protected
✅ **Platform-by-platform details** - Sections for GitHub, Codespaces, Copilot, Zenodo, Open Data Portal
✅ **Links to official policies** - TBS directives, DFO policies, CSAS manuals all linked
✅ **Contact info** - Clear contacts for different types of questions

#### Areas for Improvement
⚠️ **Assumed knowledge of CSAS process** - References "CSAS participants", "regional CSAS coordinator" without explanation for new staff
⚠️ **No decision tree** - A flowchart asking "What type of data?" → "Where are you in the FSAR process?" → "Use this platform" would be helpful
⚠️ **SharePoint approval process link** - The Assystnet ticket link may not work for everyone (authentication issues)

**Recommendation:**
1. Add a flowchart: "Where should I store my FSAR data?"
2. Link to a CSAS process explainer (or add a brief one)
3. Add a checklist: "Before publishing FSAR data to GitHub"

---

### 6. How-to Guides ⭐⭐⭐⭐

Based on file names discovered, the guides cover:
- Databricks & R Studio
- Open Government Portal (R)
- SharePoint (R)

#### Strengths
✅ **Task-focused** - Titles clearly indicate the task (not just "R Guide")
✅ **Tool-specific** - Recognizes that users need platform-specific instructions

#### Areas for Improvement
⚠️ **Didn't directly explore content** - Can't assess quality without reading full pages
⚠️ **Missing key guides?** - I would expect to see:
  - "How to create a data dictionary for FSAR"
  - "How to validate your SDEP package"
  - "How to request a new controlled vocabulary term"

**Recommendation:** Add task-based how-to guides for the most common data stewardship tasks

---

### 7. Tutorials ⭐⭐⭐⭐½

Reviewed: "Support Controlled Vocabularies"

#### Strengths
✅ **Excellent end-to-end workflow** - 6 clear steps from submission to publication
✅ **Technical depth** - Explains SKOS, RDF, and ontology alignment without being overwhelming
✅ **"Why bother?" section** - Addresses user skepticism with concrete benefits:
  - Enhanced data discovery
  - Semi-automated integration
  - Smarter AI applications
  - Future-proof interoperability
  - Better metadata stewardship

✅ **Real-world examples** - Each benefit section includes concrete use cases
✅ **Multiple audiences** - Useful for both scientists (understanding the value) and stewards (implementing the workflow)

#### Areas for Improvement
⚠️ **Highly technical for target audience** - Mentions "NCEAS Salmon Ontology", "BioPortal Annotator", "skos:exactMatch", which may be intimidating for biologists
⚠️ **No visual examples** - Screenshots of what a controlled vocabulary lookup tool looks like, or what the validation output shows, would help

**Recommendation:**
1. Add a "Quickstart for Scientists" version alongside the technical tutorial
2. Include screenshots of tools in action
3. Separate "Understanding the Value" (for scientists) from "Implementation Details" (for stewards)

---

### 8. Deep Dives ⭐⭐⭐⭐

Discovered: "Stock Assessment Data 101 for Fisheries Science Reports"

The title alone indicates this would be extremely relevant to my persona! Unfortunately, the file path wasn't accessible in my review, but this section clearly aims to provide context and rationale.

#### Recommendation
✅ Keep producing these! The "Deep Dive" category is perfect for explaining the "why" behind data standards

---

### 9. Data Services (Portfolio) ⭐⭐⭐⭐⭐

**Excellent showcase of what the DSU provides!**

#### Strengths
✅ **Beautiful card-based layout** - Grid of project cards with hover effects
✅ **Clear categorization** - "Open Access Services" and "Internal DFO Platforms" sections
✅ **Status badges** - Color-coded badges show project status (Operational, In Development)
✅ **Modal popups** - Clicking a card opens a detailed modal with:
  - Challenge, Solution, Outcome
  - Key features list
  - Links to access the service
  - Screenshot placeholder

✅ **Relevant services for my use case:**
- Salmon Data Standards (operational)
- Salmon Outlook Enhancements (in development)
- SMU-CU-DU Crosswalk (operational)
- Escapement Estimates Toolkit (operational)

#### Areas for Improvement
⚠️ **Some screenshots missing** - Several projects show "📷 Screenshot coming soon"
⚠️ **Links pending** - Some services show "link pending" rather than functional access
⚠️ **No filtering/sorting** - With many projects, filters by status or category would help

**Recommendation:**
1. Prioritize adding screenshots for operational services
2. Add a filter dropdown: "Show me: All / Operational / In Development"

---

### 10. Search Functionality ⭐⭐⭐⭐⭐

#### Strengths
✅ **Omnipresent** - Available in navbar, sidebar, and homepage
✅ **Keyboard shortcut** - Ctrl/Cmd + K for power users
✅ **Quarto native search** - Indexes all content automatically

#### Testing
As a salmon biologist, I would search for:
- "FSAR data" → Should find publishing guidance, SDEP spec
- "spawner escapement" → Should find controlled vocab terms
- "Excel data dictionary" → Should find SDEP or how-to guides
- "GitHub approval" → Should find publishing data externally page

Without access to the live site, I can't test actual search results, but the infrastructure appears solid.

---

### 11. Visual Design & Accessibility ⭐⭐⭐⭐

#### Strengths
✅ **Clean, professional theme** - Cosmo theme from Quarto provides good readability
✅ **Custom CSS well-implemented** - Portfolio cards, modals, and vocabulary search are polished
✅ **Responsive design** - CSS includes media queries for mobile, tablet, desktop
✅ **Color scheme** - Consistent use of blue (#446c8a) for links and accents
✅ **Typography** - Good line-height and font sizing for readability

#### Areas for Improvement
⚠️ **Color contrast** - Some muted text colors (e.g., `.text-muted`) may have low contrast ratios
⚠️ **No dark mode** - Some users prefer dark mode for extended reading
⚠️ **Accessibility testing unknown** - No indication of WCAG compliance testing

**Recommendation:**
1. Run automated accessibility audit (axe, WAVE)
2. Ensure all text meets WCAG AA contrast ratios
3. Consider adding dark mode toggle

---

### 12. Content Quality & Clarity ⭐⭐⭐⭐⭐

#### Strengths
✅ **Excellent technical writing** - Clear, concise, well-structured
✅ **Appropriate detail level** - Balances overview with technical depth
✅ **Real-world examples** - Uses actual DFO/salmon contexts
✅ **Progressive disclosure** - Overview → Reference → Tutorial → Deep Dive
✅ **Links to authoritative sources** - W3C specs, government policies, DFO guidelines
✅ **Maintained by experts** - Content shows deep domain knowledge

#### Areas for Improvement
⚠️ **Assumes some baseline knowledge** - Terms like "CSAS", "FSAR", "CU", "SMU" used without always defining
⚠️ **No glossary** - A glossary of acronyms and DFO-specific terms would help new staff

**Recommendation:**
1. Add a glossary page or hoverable tooltips for acronyms
2. Link to external explainers for DFO-specific processes (CSAS, FSAR workflow)

---

### 13. Workflow: My Journey as a Salmon Biologist

Here's how I would use the site to accomplish my goal:

**Goal:** Standardize my salmon spawner survey data for an FSAR

#### Expected Journey
1. **Homepage** → See "Salmon Data Standards" in navbar → Click
2. **Controlled Vocabulary** → Search for my variables:
   - "spawner abundance" → Find canonical term, copy URI
   - "age class" → Find standard codes
   - "survey method" → Find standard method terms
3. **Back to sidebar** → Click "Salmon Data Exchange Package"
4. **SDEP Page** → Read spec, understand I need dataset.csv, tables.csv, column_dictionary.csv, codes.csv
5. **Missing:** Need an example or template → Search for "SDEP example" → Not found
6. **Workaround:** Scroll to bottom, look for GitHub link, hope to find example there
7. **Back to navbar** → Click "Data Services" to see if there's a tool
8. **Portfolio** → Find "Salmon Data Standards" card but doesn't mention tools
9. **Sidebar** → Check "Tools" section → Click "R packages"
10. **Hope:** Find an R package that generates SDEP → (unknown if this exists)
11. **Once SDEP created** → Back to "Publishing Data Externally"
12. **Publishing page** → Check table: my data is Unclassified → Can use GitHub after approval
13. **Follow workflow:** Create GitHub repo, add SDEP, request CSAS approval, publish

#### Pain Points in Journey
⚠️ **Missing SDEP template/example** - Had to infer structure from spec
⚠️ **Unclear if validation tools exist** - Mentioned but not linked
⚠️ **No step-by-step FSAR data workflow** - Had to piece together from multiple pages

#### Ideal Journey
A single "FSAR Data Standardization Workflow" page that walks through:
1. Identify your variables → Use controlled vocabulary
2. Structure your data → Use SDEP template (download link)
3. Create metadata files → Use SDEP generator tool (R package)
4. Validate → Run validation script
5. Classify your data → Use classification guide
6. Publish → Follow platform guidelines
7. Submit FSAR → Include data citation

---

## Priority Recommendations

### Critical (P0)
1. **Create SDEP example package** - Downloadable ZIP with sample data and metadata CSVs
2. **Add "Getting Started" landing page** - Quick links to common tasks
3. **Link validation tools** - Where they exist, link prominently from SDEP page

### High Priority (P1)
4. **Add FSAR data workflow guide** - End-to-end tutorial specific to FSAR use case
5. **Make related terms clickable** - In controlled vocabulary, clicking a related term should navigate to it
6. **Add export functionality** - Export filtered vocabulary terms as CSV
7. **Add glossary page** - Define DFO acronyms and processes

### Medium Priority (P2)
8. **Add theme descriptions** - Tooltip or info panel explaining what each theme covers
9. **Create flowcharts** - Visual decision trees for "Where to publish?" and "What standard to use?"
10. **Add search examples** - Show example queries on vocabulary search
11. **Fill in missing screenshots** - For operational projects in portfolio

### Low Priority (P3)
12. **Add dark mode** - For user preference
13. **Accessibility audit** - Ensure WCAG AA compliance
14. **Add breadcrumbs** - Show current location in site hierarchy

---

## Strengths Summary

✅ **Excellent content quality** - Comprehensive, well-written, expert knowledge
✅ **Powerful search tools** - Both site-wide and vocabulary-specific search are excellent
✅ **Clear information architecture** - Logical categorization with good navigation
✅ **Beautiful presentation** - Professional, polished design
✅ **Actionable guidance** - Concrete specifications, tables, and instructions
✅ **Living documentation** - Clear paths to contribute and request changes

---

## Areas for Improvement Summary

⚠️ **Discoverability** - First-time users need clearer entry points for common tasks
⚠️ **Worked examples** - More downloadable templates and complete examples
⚠️ **Tool integration** - Clearer links between documentation and actual tools (R packages, validators)
⚠️ **Workflow guidance** - More end-to-end workflows for specific use cases (FSAR, etc.)
⚠️ **Assumed knowledge** - Glossary needed for DFO-specific terms and processes

---

## Conclusion

As a DFO salmon biologist looking to standardize my data for an FSAR, the FADS Open Science Hub provides **excellent resources** and I would successfully accomplish my goal using this site. The controlled vocabulary search is particularly impressive and would save me significant time.

However, I would encounter friction in the form of:
- Having to piece together information from multiple pages
- Lack of concrete examples and templates
- Unclear validation workflow

With the priority recommendations implemented, this site would move from "very good" to "exceptional" and become a model for scientific data stewardship documentation.

**Final Rating: ⭐⭐⭐⭐½ (4.5/5)**

---

## Appendix: Testing Methodology

**Approach:** Source code review and cognitive walkthrough
**Coverage:**
- ✅ Homepage (index.qmd)
- ✅ About page
- ✅ Navigation structure (_quarto.yml)
- ✅ Controlled Vocabulary & Thesauri page (full)
- ✅ SDEP Specification (full)
- ✅ Publishing Data Externally (full)
- ✅ Support Controlled Vocabularies tutorial (full)
- ✅ Portfolio page (partial)
- ✅ Custom CSS and styling
- ⚠️ How-to guides (file names only)
- ⚠️ Deep dives (title only)
- ❌ Live site interaction (unable to host locally)

**Limitations:**
- Could not test actual search results
- Could not test interactive table filtering in browser
- Could not test responsive mobile layout
- Could not test loading performance
- Could not test with screen reader

**Compensating Factors:**
- Thorough review of source code including JavaScript functionality
- Analysis of HTML structure and CSS implementation
- Evaluation based on established UX heuristics
- Domain expertise applied to content assessment

---

**Report compiled by:** Claude (AI Assistant)
**On behalf of:** UAT Persona - DFO Science Biologist
**Date:** 2026-01-08
