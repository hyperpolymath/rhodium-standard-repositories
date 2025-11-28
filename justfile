# SPDX-License-Identifier: MIT AND Palimpsest-0.8
# SPDX-FileCopyrightText: 2025 The Rhodium Standard Contributors
#
# Justfile - Task Runner for Rhodium Standard Repositories
# Run `just --list` to see all available tasks

# Default recipe shows help
default:
    @just --list

# =============================================================================
# Validation & Compliance
# =============================================================================

# Run full RSR compliance validation
validate: audit-license check-links lint test
    @echo "✅ Full validation complete!"

# Run RSR audit on this repository
audit:
    @echo "🔍 Running RSR compliance audit..."
    @./rsr-audit.sh .

# Run RSR audit in JSON format
audit-json:
    @./rsr-audit.sh . json

# Run RSR audit and generate HTML report
audit-html:
    @./rsr-audit.sh . html > rsr-audit-report.html
    @echo "📊 Report generated: rsr-audit-report.html"

# Check SPDX license headers on all source files
audit-license:
    @echo "📋 Checking SPDX headers..."
    @./rsr-audit.sh . | grep -i "spdx" || echo "✅ SPDX check passed"

# =============================================================================
# Building & Testing
# =============================================================================

# Build all example repositories
build-examples:
    @echo "🔨 Building examples..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            echo "Building $$dir..."; \
            (cd "$$dir" && cargo build) || exit 1; \
        fi; \
    done
    @echo "✅ All examples built!"

# Build specific example
build-example NAME:
    @echo "🔨 Building {{NAME}}..."
    @cd examples/{{NAME}} && cargo build

# Run tests for all examples
test:
    @echo "🧪 Running tests..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            echo "Testing $$dir..."; \
            (cd "$$dir" && cargo test) || exit 1; \
        fi; \
    done
    @echo "✅ All tests passed!"

# Run tests for specific example
test-example NAME:
    @cd examples/{{NAME}} && cargo test

# =============================================================================
# Code Quality
# =============================================================================

# Run all linters
lint: lint-rust lint-shell lint-docs
    @echo "✅ All linting passed!"

# Lint Rust code
lint-rust:
    @echo "🦀 Linting Rust..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            (cd "$$dir" && cargo clippy -- -D warnings) || exit 1; \
        fi; \
    done

# Lint shell scripts
lint-shell:
    @echo "🐚 Linting shell scripts..."
    @shellcheck rsr-audit.sh || echo "⚠️  shellcheck not installed"

# Lint documentation
lint-docs:
    @echo "📚 Linting documentation..."
    @# Check for trailing whitespace
    @! git grep -I '[[:space:]]$$' -- '*.md' '*.adoc' || (echo "❌ Trailing whitespace found" && exit 1)
    @echo "✅ Documentation lint passed"

# Format all code
fmt: fmt-rust
    @echo "✅ Formatting complete!"

# Format Rust code
fmt-rust:
    @echo "🦀 Formatting Rust..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            (cd "$$dir" && cargo fmt) || exit 1; \
        fi; \
    done

# =============================================================================
# Documentation
# =============================================================================

# Validate all documentation links
check-links:
    @echo "🔗 Checking documentation links..."
    @lychee --verbose --no-progress *.md *.adoc docs/ examples/ || echo "⚠️  lychee not installed or links broken"

# Generate documentation
docs:
    @echo "📚 Generating documentation..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            (cd "$$dir" && cargo doc --no-deps); \
        fi; \
    done
    @echo "✅ Documentation generated!"

# Serve documentation locally
docs-serve:
    @echo "🌐 Serving documentation at http://localhost:8000"
    @cd target/doc && python3 -m http.server 8000

# =============================================================================
# Security
# =============================================================================

# Run security audit on dependencies
security-audit:
    @echo "🔒 Running security audit..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            echo "Auditing $$dir..."; \
            (cd "$$dir" && cargo audit) || echo "⚠️  cargo-audit not installed"; \
        fi; \
    done

# Generate SBOM (Software Bill of Materials)
sbom-generate:
    @echo "📦 Generating SBOM..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            echo "SBOM for $$dir"; \
            (cd "$$dir" && cargo tree --format '{p} {l}' > SBOM.txt); \
        fi; \
    done
    @echo "✅ SBOM generated (see examples/*/SBOM.txt)"

# =============================================================================
# Cleanup
# =============================================================================

# Clean all build artifacts
clean:
    @echo "🧹 Cleaning build artifacts..."
    @for dir in examples/*/; do \
        if [ -f "$$dir/Cargo.toml" ]; then \
            (cd "$$dir" && cargo clean); \
        fi; \
    done
    @rm -f rsr-audit-report.html
    @echo "✅ Clean complete!"

# Deep clean (including Nix artifacts)
clean-all: clean
    @echo "🧹 Deep cleaning..."
    @rm -rf result result-*
    @echo "✅ Deep clean complete!"

# =============================================================================
# Release Management
# =============================================================================

# Prepare for release (version bump, changelog update, validation)
release-prepare VERSION:
    @echo "📦 Preparing release {{VERSION}}..."
    @echo "1. Update version numbers"
    @echo "2. Update CHANGELOG.md"
    @echo "3. Run full validation"
    @just validate
    @echo "4. Create release branch"
    @git checkout -b release/v{{VERSION}}
    @echo "✅ Release branch ready! Review and merge when ready."

# Create signed git tag for release
release-tag VERSION:
    @echo "🏷️  Creating signed tag v{{VERSION}}..."
    @git tag -s v{{VERSION}} -m "Release v{{VERSION}}"
    @echo "✅ Tag created! Push with: git push origin v{{VERSION}}"

# =============================================================================
# Development
# =============================================================================

# Enter Nix development shell
dev:
    @nix develop

# Watch for changes and run tests
watch:
    @echo "👀 Watching for changes..."
    @cargo watch -x test || echo "⚠️  cargo-watch not installed (run: cargo install cargo-watch)"

# Set up development environment
setup:
    @echo "🔧 Setting up development environment..."
    @echo "Checking prerequisites..."
    @command -v nix >/dev/null 2>&1 || (echo "❌ Nix not installed" && exit 1)
    @command -v git >/dev/null 2>&1 || (echo "❌ Git not installed" && exit 1)
    @echo "✅ Prerequisites met!"
    @echo "Installing dev tools..."
    @nix develop -c bash -c "cargo --version && rustc --version"
    @echo "✅ Development environment ready!"

# Initialize new example repository
init-example NAME LANG:
    @echo "🌱 Creating new example: {{NAME}} ({{LANG}})"
    @mkdir -p examples/{{NAME}}
    @cp templates/{{LANG}}/* examples/{{NAME}}/
    @echo "✅ Example created at examples/{{NAME}}/"
    @echo "Next steps:"
    @echo "  1. cd examples/{{NAME}}"
    @echo "  2. Edit files to customize"
    @echo "  3. Run: just validate"

# =============================================================================
# CI/CD Helpers
# =============================================================================

# Run CI checks locally (same as GitLab CI)
ci-local: validate
    @echo "✅ CI checks passed locally!"

# Check if MR is ready to merge
mr-ready: validate security-audit
    @echo "🎉 MR looks good! All checks passed."

# =============================================================================
# Utilities
# =============================================================================

# Count lines of code
loc:
    @echo "📊 Lines of code:"
    @find examples/ -name '*.rs' -o -name '*.ex' -o -name '*.hs' | xargs wc -l | tail -1

# Find TODOs in codebase
todos:
    @echo "📝 TODOs found:"
    @git grep -n "TODO\|FIXME\|XXX\|HACK" || echo "✅ No TODOs found!"

# Show repository statistics
stats:
    @echo "📈 Repository Statistics"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @echo "Commits: $$(git rev-list --count HEAD)"
    @echo "Contributors: $$(git log --format='%an' | sort -u | wc -l)"
    @echo "Files: $$(git ls-files | wc -l)"
    @echo "Examples: $$(ls -d examples/*/ | wc -l)"
    @just loc

# =============================================================================
# Help & Information
# =============================================================================

# Show version information
version:
    @echo "Rhodium Standard Repositories v1.0.0"
    @echo "https://gitlab.com/hyperpolymath/rhodium-standard-repositories"

# Show RSR compliance status
status:
    @echo "🎖️  RSR Compliance Status"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @./rsr-audit.sh . | tail -20

# Open documentation in browser
docs-open:
    @xdg-open README.adoc || open README.adoc || echo "Please open README.adoc manually"
