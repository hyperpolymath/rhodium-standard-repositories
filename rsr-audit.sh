#!/usr/bin/env bash
# SPDX-License-Identifier: MIT AND Palimpsest-0.8
# SPDX-FileCopyrightText: 2025 The Rhodium Standard Contributors
#
# RSR Audit Script - Comprehensive Repository Compliance Checker
# Usage: ./rsr-audit.sh [path-to-repo] [--format json|text|html]
#
# Exit codes:
#   0 - Gold compliance (100%)
#   1 - Silver compliance (90-99%)
#   2 - Bronze compliance (75-89%)
#   3 - Non-compliant (<75%)
#   4 - Error running audit

set -uo pipefail

# =============================================================================
# Configuration
# =============================================================================

REPO_PATH="${1:-.}"
OUTPUT_FORMAT="${2:-text}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Compliance thresholds
GOLD_THRESHOLD=100
SILVER_THRESHOLD=90
BRONZE_THRESHOLD=75

# Scoring
TOTAL_CHECKS=0
PASSED_CHECKS=0

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# =============================================================================
# Utility Functions
# =============================================================================

log_info() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo -e "${BLUE}ℹ${NC} $1"
    fi
}

log_success() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo -e "${GREEN}✓${NC} $1"
    fi
}

log_warning() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo -e "${YELLOW}⚠${NC} $1"
    fi
}

log_error() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo -e "${RED}✗${NC} $1"
    fi
}

log_section() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo ""
        echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${PURPLE}$1${NC}"
        echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    fi
}

check() {
    local description="$1"
    local command="$2"

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    if eval "$command" > /dev/null 2>&1; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        log_success "$description"
        return 0
    else
        log_error "$description"
        return 1
    fi
}

check_file_exists() {
    local file="$1"
    local description="${2:-File exists: $file}"
    check "$description" "test -f '$REPO_PATH/$file'"
}

check_dir_exists() {
    local dir="$1"
    local description="${2:-Directory exists: $dir}"
    check "$description" "test -d '$REPO_PATH/$dir'"
}

check_file_contains() {
    local file="$1"
    local pattern="$2"
    local description="${3:-$file contains: $pattern}"
    check "$description" "grep -q '$pattern' '$REPO_PATH/$file' 2>/dev/null"
}

check_command_exists() {
    local cmd="$1"
    local description="${2:-Command available: $cmd}"
    check "$description" "command -v $cmd"
}

# =============================================================================
# Category 1: Foundational Infrastructure (15 checks)
# =============================================================================

audit_category_1_infrastructure() {
    log_section "Category 1: Foundational Infrastructure"

    # Nix flakes
    check_file_exists "flake.nix" "Nix flake configuration present"
    check_file_exists "flake.lock" "Nix flake lockfile present"
    check_file_contains "flake.nix" "description" "flake.nix has description field"

    # Justfile
    check_file_exists "justfile" "Justfile present"
    check_file_contains "justfile" "build" "Justfile has build recipe"
    check_file_contains "justfile" "test" "Justfile has test recipe"
    check_file_contains "justfile" "validate" "Justfile has validate recipe"

    # GitLab CI/CD (or GitHub Actions as fallback)
    if check_file_exists ".gitlab-ci.yml" "GitLab CI/CD configuration"; then
        check_file_contains ".gitlab-ci.yml" "stages:" "GitLab CI has stages defined"
    elif check_file_exists ".github/workflows/ci.yml" "GitHub Actions workflow"; then
        log_warning "Using GitHub Actions instead of GitLab CI (GitLab preferred)"
    fi

    # Podman (optional for CLI tools, required for web services)
    if [[ -f "$REPO_PATH/podman-compose.yml" ]] || [[ -f "$REPO_PATH/docker-compose.yml" ]]; then
        check_file_exists "podman-compose.yml" "Podman Compose configuration (not Docker)"
        if [[ -f "$REPO_PATH/podman-compose.yml" ]]; then
            check_file_contains "podman-compose.yml" "cgr.dev/chainguard" "Uses Chainguard Wolfi base images"
        fi
    fi

    # Git configuration
    check_file_exists ".gitignore" ".gitignore present"
    check_file_exists ".gitattributes" ".gitattributes present"
}

# =============================================================================
# Category 2: Documentation Standards (20 checks)
# =============================================================================

audit_category_2_documentation() {
    log_section "Category 2: Documentation Standards"

    # Required files with exact naming
    check_file_exists "README.md" "README.md present (or README.adoc)"
    if [[ ! -f "$REPO_PATH/README.md" ]]; then
        check_file_exists "README.adoc" "README.adoc present"
    fi

    check_file_exists "LICENSE.txt" "LICENSE.txt present (must be .txt, not .md)"
    check_file_exists "SECURITY.md" "SECURITY.md present"
    check_file_exists "CODE_OF_CONDUCT.md" "CODE_OF_CONDUCT.md present (or .adoc)"
    check_file_exists "CONTRIBUTING.md" "CONTRIBUTING.md present (or .adoc)"
    check_file_exists "MAINTAINERS.md" "MAINTAINERS.md present"
    check_file_exists "CHANGELOG.md" "CHANGELOG.md present"

    # LICENSE.txt validation
    if [[ -f "$REPO_PATH/LICENSE.txt" ]]; then
        check_file_contains "LICENSE.txt" "SPDX-License-Identifier" "LICENSE.txt has SPDX identifier"
        check_file_contains "LICENSE.txt" "MIT" "LICENSE.txt includes MIT license"
        check_file_contains "LICENSE.txt" "Palimpsest" "LICENSE.txt includes Palimpsest license"
    fi

    # README validation
    if [[ -f "$REPO_PATH/README.md" ]]; then
        check_file_contains "README.md" "Installation" "README.md has Installation section"
        check_file_contains "README.md" "Usage" "README.md has Usage section"
        check_file_contains "README.md" "License" "README.md has License section"
    fi

    # SECURITY.md validation
    if [[ -f "$REPO_PATH/SECURITY.md" ]]; then
        check_file_contains "SECURITY.md" "Reporting" "SECURITY.md has vulnerability reporting"
        check_file_contains "SECURITY.md" "24 hours" "SECURITY.md has response timeline"
    fi

    # CONTRIBUTING.md validation (TPCF)
    if [[ -f "$REPO_PATH/CONTRIBUTING.md" ]]; then
        check_file_contains "CONTRIBUTING.md" "TPCF\\|Perimeter" "CONTRIBUTING.md mentions TPCF framework"
    fi

    # .well-known/ directory
    check_dir_exists ".well-known" ".well-known/ directory present"
    check_file_exists ".well-known/security.txt" ".well-known/security.txt (RFC 9116)"
    check_file_exists ".well-known/ai.txt" ".well-known/ai.txt (AI training policies)"
    check_file_exists ".well-known/humans.txt" ".well-known/humans.txt (attribution)"
}

# =============================================================================
# Category 3: Security Architecture (25 checks)
# =============================================================================

audit_category_3_security() {
    log_section "Category 3: Security Architecture"

    # SPDX headers on source files
    local src_files
    if [[ -d "$REPO_PATH/src" ]]; then
        src_files=$(find "$REPO_PATH/src" -type f \( -name "*.rs" -o -name "*.ex" -o -name "*.exs" -o -name "*.ada" -o -name "*.adb" -o -name "*.res" -o -name "*.hs" \) 2>/dev/null | wc -l)

        if [[ $src_files -gt 0 ]]; then
            local spdx_files
            spdx_files=$(find "$REPO_PATH/src" -type f \( -name "*.rs" -o -name "*.ex" -o -name "*.exs" -o -name "*.ada" -o -name "*.adb" -o -name "*.res" -o -name "*.hs" \) -exec grep -l "SPDX-License-Identifier" {} \; 2>/dev/null | wc -l)

            if [[ $spdx_files -eq $src_files ]]; then
                log_success "All source files have SPDX headers ($spdx_files/$src_files)"
                PASSED_CHECKS=$((PASSED_CHECKS + 1))
            else
                log_error "Not all source files have SPDX headers ($spdx_files/$src_files)"
            fi
            TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        fi
    fi

    # Type safety (language detection)
    if [[ -f "$REPO_PATH/Cargo.toml" ]]; then
        check "Type-safe language: Rust" "true"
    elif [[ -f "$REPO_PATH/mix.exs" ]]; then
        check "Type-safe language: Elixir" "true"
    elif [[ -f "$REPO_PATH/package.json" ]]; then
        check_file_contains "package.json" "rescript" "Type-safe: ReScript (not TypeScript)"
        if grep -q "typescript" "$REPO_PATH/package.json" 2>/dev/null; then
            log_warning "TypeScript detected (unsound gradual typing, prefer ReScript)"
        fi
    elif find "$REPO_PATH" -name "*.adb" -o -name "*.ada" | grep -q .; then
        check "Type-safe language: Ada" "true"
    elif find "$REPO_PATH" -name "*.hs" | grep -q .; then
        check "Type-safe language: Haskell" "true"
    fi

    # Memory safety
    if [[ -f "$REPO_PATH/Cargo.toml" ]]; then
        check "Memory-safe language: Rust" "true"

        # Check for unsafe code blocks
        local unsafe_count
        unsafe_count=$(grep -r "unsafe" "$REPO_PATH/src" 2>/dev/null | grep -v "SPDX" | wc -l)
        if [[ $unsafe_count -eq 0 ]]; then
            log_success "No unsafe code blocks found"
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            log_warning "Unsafe code blocks found ($unsafe_count occurrences)"
        fi
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    fi

    # Dependency management
    if [[ -f "$REPO_PATH/Cargo.toml" ]]; then
        if [[ -f "$REPO_PATH/Cargo.lock" ]]; then
            log_success "Cargo.lock present (pinned dependencies)"
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            log_warning "Cargo.lock missing (dependencies not pinned)"
        fi
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    fi

    # No npm/node_modules (anti-JavaScript)
    if [[ ! -d "$REPO_PATH/node_modules" ]]; then
        log_success "No node_modules/ directory (post-JavaScript)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        log_warning "node_modules/ present (JavaScript discouraged in RSR)"
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    # Security headers configuration (for web projects)
    if [[ -f "$REPO_PATH/nginx.conf" ]] || [[ -f "$REPO_PATH/apache.conf" ]] || grep -rq "Content-Security-Policy" "$REPO_PATH" 2>/dev/null; then
        check "Security headers configured" "grep -rq 'Content-Security-Policy\\|X-Frame-Options\\|X-Content-Type-Options' '$REPO_PATH'"
    fi

    # .well-known/security.txt validation (RFC 9116)
    if [[ -f "$REPO_PATH/.well-known/security.txt" ]]; then
        check_file_contains ".well-known/security.txt" "Contact:" "security.txt has Contact field"
        check_file_contains ".well-known/security.txt" "Expires:" "security.txt has Expires field"
        check_file_contains ".well-known/security.txt" "Preferred-Languages:" "security.txt has Preferred-Languages"
    fi
}

# =============================================================================
# Category 4: Architecture Principles (15 checks)
# =============================================================================

audit_category_4_architecture() {
    log_section "Category 4: Architecture Principles"

    # Offline-first indicators
    check "Offline-first: No external API calls in core code" "! grep -rq 'http://\\|https://' '$REPO_PATH/src' 2>/dev/null"

    # CRDT usage (for distributed systems)
    if grep -rq "CRDT\\|crdt\\|Conflict-free" "$REPO_PATH" 2>/dev/null; then
        log_success "CRDTs mentioned (distributed state management)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    # Reversibility (Git-based)
    check "Reversibility: Git repository" "test -d '$REPO_PATH/.git'"

    # Build reproducibility (Nix)
    if [[ -f "$REPO_PATH/flake.nix" ]]; then
        check "Reproducible builds: Nix flakes" "true"
    fi

    # Documentation of architecture
    if [[ -f "$REPO_PATH/ARCHITECTURE.md" ]] || [[ -f "$REPO_PATH/docs/architecture.md" ]]; then
        log_success "Architecture documentation present"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# =============================================================================
# Category 7: FOSS & Licensing (10 checks)
# =============================================================================

audit_category_7_licensing() {
    log_section "Category 7: FOSS & Licensing"

    # License clarity
    check_file_exists "LICENSE.txt" "LICENSE.txt present (plain text, not LICENSE.md)"

    if [[ -f "$REPO_PATH/LICENSE.txt" ]]; then
        check_file_contains "LICENSE.txt" "MIT" "MIT license included"
        check_file_contains "LICENSE.txt" "Palimpsest" "Palimpsest license included (ethical AI)"
    fi

    # SPDX identifier in LICENSE.txt
    if [[ -f "$REPO_PATH/LICENSE.txt" ]]; then
        check_file_contains "LICENSE.txt" "SPDX-License-Identifier: MIT AND Palimpsest" "Correct SPDX identifier in LICENSE.txt"
    fi

    # FUNDING.yml for funding transparency
    if [[ -f "$REPO_PATH/FUNDING.yml" ]] || [[ -f "$REPO_PATH/.github/FUNDING.yml" ]]; then
        log_success "FUNDING.yml present (funding transparency)"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    # Attribution in MAINTAINERS.md
    check_file_exists "MAINTAINERS.md" "MAINTAINERS.md present (attribution)"
}

# =============================================================================
# Category 10: Community & Governance (15 checks)
# =============================================================================

audit_category_10_community() {
    log_section "Category 10: Community & Governance"

    # TPCF framework
    if [[ -f "$REPO_PATH/CONTRIBUTING.md" ]]; then
        check_file_contains "CONTRIBUTING.md" "Perimeter\\|TPCF" "TPCF framework mentioned"
        check_file_contains "CONTRIBUTING.md" "Community Sandbox\\|Expert Extensions\\|Core Systems" "TPCF perimeters defined"
    fi

    # Code of Conduct
    check_file_exists "CODE_OF_CONDUCT.md" "CODE_OF_CONDUCT.md present"
    if [[ -f "$REPO_PATH/CODE_OF_CONDUCT.md" ]]; then
        check_file_contains "CODE_OF_CONDUCT.md" "harassment" "CoC addresses harassment"
        check_file_contains "CODE_OF_CONDUCT.md" "enforcement\\|Enforcement" "CoC has enforcement procedures"
    fi

    # Contributing guidelines
    check_file_exists "CONTRIBUTING.md" "CONTRIBUTING.md present"
    if [[ -f "$REPO_PATH/CONTRIBUTING.md" ]]; then
        check_file_contains "CONTRIBUTING.md" "fork\\|Fork" "CONTRIBUTING.md explains fork workflow"
        check_file_contains "CONTRIBUTING.md" "test\\|Test" "CONTRIBUTING.md mentions testing"
    fi

    # Governance
    if [[ -f "$REPO_PATH/GOVERNANCE.md" ]] || [[ -f "$REPO_PATH/GOVERNANCE.adoc" ]]; then
        log_success "GOVERNANCE document present"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    # Maintainers
    check_file_exists "MAINTAINERS.md" "MAINTAINERS.md present"
}

# =============================================================================
# Additional Checks (Bonus Points)
# =============================================================================

audit_additional_checks() {
    log_section "Additional Checks (Bonus)"

    # Testing
    if [[ -f "$REPO_PATH/justfile" ]]; then
        check_file_contains "justfile" "test" "Justfile has test recipe"
    fi

    # Linting
    if [[ -f "$REPO_PATH/justfile" ]]; then
        check_file_contains "justfile" "lint\\|clippy" "Justfile has lint recipe"
    fi

    # Formatting
    if [[ -f "$REPO_PATH/justfile" ]]; then
        check_file_contains "justfile" "format\\|fmt" "Justfile has format recipe"
    fi

    # Audit recipe
    if [[ -f "$REPO_PATH/justfile" ]]; then
        check_file_contains "justfile" "audit-licence\\|audit-license" "Justfile has SPDX audit recipe"
    fi

    # CI/CD automation
    if [[ -f "$REPO_PATH/.gitlab-ci.yml" ]]; then
        check_file_contains ".gitlab-ci.yml" "test" "GitLab CI runs tests"
        check_file_contains ".gitlab-ci.yml" "lint\\|clippy" "GitLab CI runs linting"
    fi

    # Documentation site
    if [[ -d "$REPO_PATH/docs" ]]; then
        log_success "Documentation directory present"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# =============================================================================
# Scoring & Reporting
# =============================================================================

calculate_score() {
    if [[ $TOTAL_CHECKS -eq 0 ]]; then
        echo "0"
        return
    fi

    # Calculate percentage
    local score
    score=$(awk "BEGIN {printf \"%.2f\", ($PASSED_CHECKS / $TOTAL_CHECKS) * 100}")
    echo "$score"
}

determine_compliance_level() {
    local score="$1"

    if (( $(echo "$score >= $GOLD_THRESHOLD" | bc -l) )); then
        echo "Gold"
    elif (( $(echo "$score >= $SILVER_THRESHOLD" | bc -l) )); then
        echo "Silver"
    elif (( $(echo "$score >= $BRONZE_THRESHOLD" | bc -l) )); then
        echo "Bronze"
    else
        echo "Non-Compliant"
    fi
}

generate_badge_url() {
    local level="$1"
    local score="$2"

    local color
    case "$level" in
        "Gold")
            color="ffd700"
            ;;
        "Silver")
            color="c0c0c0"
            ;;
        "Bronze")
            color="cd7f32"
            ;;
        *)
            color="red"
            ;;
    esac

    echo "https://img.shields.io/badge/RSR-${level}%20(${score}%25)-${color}"
}

output_text_report() {
    local score="$1"
    local level="$2"
    local badge_url="$3"

    echo ""
    log_section "RSR Audit Results"
    echo ""
    echo -e "  Repository: ${CYAN}$REPO_PATH${NC}"
    echo -e "  Total Checks: ${CYAN}$TOTAL_CHECKS${NC}"
    echo -e "  Passed: ${GREEN}$PASSED_CHECKS${NC}"
    echo -e "  Failed: ${RED}$((TOTAL_CHECKS - PASSED_CHECKS))${NC}"
    echo -e "  Score: ${CYAN}${score}%${NC}"
    echo ""

    case "$level" in
        "Gold")
            echo -e "  ${YELLOW}🏆 COMPLIANCE LEVEL: GOLD 🏆${NC}"
            echo -e "  ${GREEN}Full RSR compliance achieved!${NC}"
            ;;
        "Silver")
            echo -e "  ${CYAN}🥈 COMPLIANCE LEVEL: SILVER 🥈${NC}"
            echo -e "  ${GREEN}Strong RSR compliance!${NC}"
            ;;
        "Bronze")
            echo -e "  ${YELLOW}🥉 COMPLIANCE LEVEL: BRONZE 🥉${NC}"
            echo -e "  ${GREEN}Basic RSR compliance achieved.${NC}"
            ;;
        *)
            echo -e "  ${RED}❌ NON-COMPLIANT${NC}"
            echo -e "  ${RED}Does not meet minimum RSR requirements (<75%)${NC}"
            ;;
    esac

    echo ""
    echo -e "  Badge: ${BLUE}$badge_url${NC}"
    echo ""
    echo -e "  Add to your README.md:"
    echo -e "  ${CYAN}[![RSR Compliance]($badge_url)](https://gitlab.com/hyperpolymath/rhodium-standard-repositories)${NC}"
    echo ""
}

output_json_report() {
    local score="$1"
    local level="$2"
    local badge_url="$3"

    cat <<EOF
{
  "repository": "$REPO_PATH",
  "audit_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "total_checks": $TOTAL_CHECKS,
  "passed_checks": $PASSED_CHECKS,
  "failed_checks": $((TOTAL_CHECKS - PASSED_CHECKS)),
  "score": $score,
  "compliance_level": "$level",
  "badge_url": "$badge_url",
  "badge_markdown": "[![RSR Compliance]($badge_url)](https://gitlab.com/hyperpolymath/rhodium-standard-repositories)",
  "thresholds": {
    "gold": $GOLD_THRESHOLD,
    "silver": $SILVER_THRESHOLD,
    "bronze": $BRONZE_THRESHOLD
  }
}
EOF
}

output_html_report() {
    local score="$1"
    local level="$2"
    local badge_url="$3"

    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RSR Audit Report - $REPO_PATH</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; max-width: 800px; margin: 40px auto; padding: 20px; }
        h1 { color: #333; border-bottom: 3px solid #9C27B0; padding-bottom: 10px; }
        .score { font-size: 3em; font-weight: bold; text-align: center; margin: 30px 0; }
        .gold { color: #FFD700; }
        .silver { color: #C0C0C0; }
        .bronze { color: #CD7F32; }
        .non-compliant { color: #F44336; }
        .stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin: 30px 0; }
        .stat { background: #F5F5F5; padding: 20px; border-radius: 8px; text-align: center; }
        .stat-value { font-size: 2em; font-weight: bold; color: #9C27B0; }
        .stat-label { color: #666; margin-top: 5px; }
        .badge { text-align: center; margin: 30px 0; }
        .badge img { max-width: 300px; }
        footer { margin-top: 50px; padding-top: 20px; border-top: 1px solid #DDD; color: #666; text-align: center; }
    </style>
</head>
<body>
    <h1>🎖️ RSR Audit Report</h1>

    <p><strong>Repository:</strong> <code>$REPO_PATH</code></p>
    <p><strong>Audit Date:</strong> $(date)</p>

    <div class="score ${level,,}">
        ${score}% - ${level^^}
    </div>

    <div class="stats">
        <div class="stat">
            <div class="stat-value">$TOTAL_CHECKS</div>
            <div class="stat-label">Total Checks</div>
        </div>
        <div class="stat">
            <div class="stat-value" style="color: #4CAF50;">$PASSED_CHECKS</div>
            <div class="stat-label">Passed</div>
        </div>
        <div class="stat">
            <div class="stat-value" style="color: #F44336;">$((TOTAL_CHECKS - PASSED_CHECKS))</div>
            <div class="stat-label">Failed</div>
        </div>
    </div>

    <div class="badge">
        <img src="$badge_url" alt="RSR Compliance Badge">
        <p>Add to your README.md:</p>
        <code>[![RSR Compliance]($badge_url)](https://gitlab.com/hyperpolymath/rhodium-standard-repositories)</code>
    </div>

    <footer>
        <p>Powered by <strong>Rhodium Standard Repository</strong></p>
        <p><a href="https://gitlab.com/hyperpolymath/rhodium-standard-repositories">https://gitlab.com/hyperpolymath/rhodium-standard-repositories</a></p>
    </footer>
</body>
</html>
EOF
}

# =============================================================================
# Main Execution
# =============================================================================

main() {
    # Header
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo ""
        echo -e "${PURPLE}╔════════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${PURPLE}║                                                                    ║${NC}"
        echo -e "${PURPLE}║              🎖️  RSR COMPLIANCE AUDIT SYSTEM 🎖️                   ║${NC}"
        echo -e "${PURPLE}║        Rhodium Standard Repository - Automated Validation         ║${NC}"
        echo -e "${PURPLE}║                                                                    ║${NC}"
        echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════════╝${NC}"
        echo ""
    fi

    # Validate repository path
    if [[ ! -d "$REPO_PATH" ]]; then
        log_error "Repository path does not exist: $REPO_PATH"
        exit 4
    fi

    # Run audit categories
    audit_category_1_infrastructure
    audit_category_2_documentation
    audit_category_3_security
    audit_category_4_architecture
    audit_category_7_licensing
    audit_category_10_community
    audit_additional_checks

    # Calculate results
    local score
    score=$(calculate_score)

    local level
    level=$(determine_compliance_level "$score")

    local badge_url
    badge_url=$(generate_badge_url "$level" "${score%.*}")

    # Output results
    case "$OUTPUT_FORMAT" in
        "json")
            output_json_report "$score" "$level" "$badge_url"
            ;;
        "html")
            output_html_report "$score" "$level" "$badge_url"
            ;;
        *)
            output_text_report "$score" "$level" "$badge_url"
            ;;
    esac

    # Exit with appropriate code
    case "$level" in
        "Gold")
            exit 0
            ;;
        "Silver")
            exit 1
            ;;
        "Bronze")
            exit 2
            ;;
        *)
            exit 3
            ;;
    esac
}

# Run main function
main
