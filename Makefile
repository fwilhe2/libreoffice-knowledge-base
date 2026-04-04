# --- Configuration ---
IMAGE ?= docker.io/pandoc/extra:3-debian

# Detect container engine (Podman preferred, then Docker)
CONTAINER_ENGINE := $(shell command -v podman 2> /dev/null || command -v docker 2> /dev/null)

# Directories
SRC_DIR := .
OUT_DIR := build

# Find all markdown files in the source directory
SOURCES := $(wildcard $(SRC_DIR)/*.md)

# Define output targets
HTML_TARGETS := $(patsubst $(SRC_DIR)/%.md, $(OUT_DIR)/%.html, $(SOURCES))
PDF_TARGETS  := $(patsubst $(SRC_DIR)/%.md, $(OUT_DIR)/%.pdf, $(SOURCES))

# Container execution command
# --rm: remove container after run
# -v: mount current directory to /data
RUN_CMD := $(CONTAINER_ENGINE) run --rm \
           -v "$(shell pwd):/data:Z" \
           $(IMAGE)

GENERIC_ARGS := --standalone

PDF_ARGS := --template eisvogel

# --- Targets ---

.PHONY: all html pdf clean check-engine

all: html pdf

# Ensure the output directory exists
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

# Build HTML (standalone)
html: check-engine $(OUT_DIR) $(HTML_TARGETS)

$(OUT_DIR)/%.html: $(SRC_DIR)/%.md
	@echo "Extruding HTML: $< -> $@"
	@$(RUN_CMD) -s "$<" -o "$@" $(GENERIC_ARGS)

# Build PDF
pdf: check-engine $(OUT_DIR) $(PDF_TARGETS)

$(OUT_DIR)/%.pdf: $(SRC_DIR)/%.md
	@echo "Forging PDF: $< -> $@"
	@$(RUN_CMD) "$<" -o "$@" $(PDF_ARGS)

# Utility to check if an engine exists
check-engine:
ifeq ($(CONTAINER_ENGINE),)
	$(error "Neither docker nor podman found in PATH. Please install one to proceed.")
endif

clean:
	@echo "Cleaning up..."
	rm -rf $(OUT_DIR)