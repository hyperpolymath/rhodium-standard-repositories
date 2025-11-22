.PHONY: test build clean install

# Install dependencies
install:
	pip install -r requirements.txt
	cargo build

# Run all tests
test:
	cargo test
	pytest python/tests/

# Build Rust components
build:
	cargo build --release

# Clean build artifacts
clean:
	cargo clean
	rm -rf target/
	find . -type d -name __pycache__ -exec rm -rf {} +

# Format code
fmt:
	cargo fmt
	black python/
	ruff format python/

# Lint code
lint:
	cargo clippy -- -D warnings
	ruff check python/

# Run compliance check
compliance:
	rhodium check --level rhodium
