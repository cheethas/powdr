.PHONY: all setup build test lint format clean check

all: setup build test

setup:
	@echo "Setting up development environment..."
	@if ! rustup target list | grep -q "riscv32imac-unknown-none-elf (installed)"; then \
		echo "Installing RISC-V target..." && \
		rustup target add riscv32imac-unknown-none-elf; \
	else \
		echo "RISC-V target already installed"; \
	fi
	@if [ ! -d "pilcom" ]; then \
		git clone https://github.com/0xPolygonHermez/pilcom.git && \
		cd pilcom && npm install; \
	fi

export PILCOM := $(shell pwd)/pilcom
export OUT_DIR := $(shell pwd)/target/out

build:
	@echo "Building project..."
	cargo build

test: setup
	@echo "Running tests..."
	@export PILCOM=$(PILCOM) && \
	export OUT_DIR=$(OUT_DIR) && \
	cargo test -- --test-threads=1 

test-%: setup
	@echo "Running test $*..."
	@export PILCOM=$(PILCOM) && \
	export OUT_DIR=$(OUT_DIR) && \
	cargo test -- --test-threads=1 $*

lint:
	@echo "Running linter..."
	cargo clippy -- -D warnings
	cargo fmt -- --check

format:
	@echo "Formatting code..."
	cargo fmt

clean:
	@echo "Cleaning build artifacts..."
	cargo clean
	rm -rf target/
	rm -rf pilcom/node_modules

check: format lint test
	@echo "All checks passed!"

help:
	@echo "\nAvailable targets:"
	@echo "  all      - Setup environment, build and test (default)"
	@echo "  setup    - Setup development environment"
	@echo "  build    - Build the project"
	@echo "  test     - Run all tests"
	@echo "  test-X   - Run specific test (e.g., make test-empty_vm)"
	@echo "  lint     - Run linter checks"
	@echo "  format   - Format code"
	@echo "  clean    - Clean build artifacts"
	@echo "  check    - Run format, lint, and test"
	@echo "  help     - Show this help message\n" 