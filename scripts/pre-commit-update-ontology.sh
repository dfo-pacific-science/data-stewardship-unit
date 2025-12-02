#!/bin/bash
# Pre-commit hook to update ontology submodule and regenerate term tables
# This ensures term tables are always up-to-date before committing

set -e  # Exit on error

REPO_ROOT=$(git rev-parse --show-toplevel)
SUBMODULE_PATH="$REPO_ROOT/data/ontology"

# Check if submodule exists
if [ ! -d "$SUBMODULE_PATH" ]; then
    echo "Warning: Ontology submodule not found at $SUBMODULE_PATH"
    echo "Skipping ontology update. Run 'git submodule update --init --recursive' to initialize."
    exit 0  # Don't fail if submodule doesn't exist
fi

# Check if submodule has changes or needs update
cd "$REPO_ROOT"

# Get current submodule commit (if tracked in git)
CURRENT_COMMIT=$(git ls-tree HEAD data/ontology 2>/dev/null | awk '{print $3}' || echo "")

# Update submodule to latest
echo "Updating ontology submodule..."
git submodule update --init --recursive data/ontology

# Get new submodule commit
NEW_COMMIT=$(cd "$SUBMODULE_PATH" && git rev-parse HEAD)

# Check if submodule was updated or if this is first run
if [ "$CURRENT_COMMIT" != "$NEW_COMMIT" ] || [ -z "$CURRENT_COMMIT" ]; then
    if [ -n "$CURRENT_COMMIT" ]; then
        echo "Submodule updated from $CURRENT_COMMIT to $NEW_COMMIT"
    else
        echo "Submodule initialized at commit $NEW_COMMIT"
    fi
    
    # Check if Python is available
    if ! command -v python3 &> /dev/null; then
        echo "Warning: python3 not found. Skipping term table generation."
        echo "Please run manually: cd data/ontology && python3 scripts/extract-term-tables.py"
        exit 0
    fi
    
    # Check if required Python packages are available
    cd "$SUBMODULE_PATH"
    if [ ! -f "scripts/requirements.txt" ]; then
        echo "Warning: scripts/requirements.txt not found in submodule"
        exit 0
    fi
    
    # Install/check Python dependencies
    echo "Checking Python dependencies..."
    python3 -m pip install --quiet --user -r scripts/requirements.txt 2>/dev/null || {
        echo "Warning: Failed to install Python dependencies. Skipping term table generation."
        echo "Please run manually: cd data/ontology && python3 scripts/extract-term-tables.py"
        exit 0
    }
    
    # Run extraction script
    echo "Generating term tables..."
    python3 scripts/extract-term-tables.py || {
        echo "Error: Term table generation failed"
        exit 1
    }
    
    # Stage the generated CSV files
    echo "Staging generated term tables..."
    cd "$REPO_ROOT"
    git add data/ontology/release/artifacts/term-tables/*.csv data/ontology/release/artifacts/term-tables/*.meta.json 2>/dev/null || true
    
    echo "Ontology submodule updated and term tables regenerated"
else
    echo "Submodule is up-to-date"
fi

exit 0




