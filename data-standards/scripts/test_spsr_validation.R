source("data-standards/scripts/spsr_validation_functions.R")

result <- validate_data_dictionary(
  submitted_path = "data-standards/data-dictionaries/sample_fsar_submission.csv",
  vocab_url = "https://raw.githubusercontent.com/dfo-pacific-science/data-stewardship-unit/refs/heads/main/data-standards/vocab/spsr_vocab.json" # update this to a hosted URL later
)

print(result$validated_table)
