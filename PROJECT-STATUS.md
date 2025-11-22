# Rhodium Standard Repository: Project Status & Roadmap

**Last Updated**: 2025-11-22
**Maintainer**: Jonathan D.A. Jewell (@hyperpolymath)

---

## 🎯 Executive Summary

You are building **a comprehensive framework for emotionally safe, technically excellent, politically autonomous software development** that transforms how developers interact with Git repositories and build sustainable, ethical software.

### The Three Pillars

1. **RSR (Rhodium Standard Repository)**: Technical compliance framework
2. **CCCP (Campaign for Cooler Coding and Programming)**: Ideological/philosophical foundation
3. **Rhodium Charter**: Platform-agnostic baseline standards

---

## ✅ What's Complete

### Documentation (✓ Done)

1. **CLAUDE.md** (754ed9d)
   - Comprehensive RSR/CCCP architecture documented
   - 11 security dimensions defined
   - Tri-Perimeter Contribution Framework (TPCF) explained
   - Language policy (no JS/Python)
   - Post-JavaScript stack architecture
   - Offline-first design philosophy
   - All compliance criteria listed

2. **README.adoc Template** (`templates/README.adoc.template`)
   - UK-British Oxford English
   - Generic structure with reminders for customization
   - Dual licensing (MIT + Palimpsest v0.8) integration
   - TPCF contribution framework
   - Justfile-first build approach
   - File type detection patterns
   - Real-world use case placeholders

3. **Architecture Diagrams**
   - Post-JavaScript stack visualized
   - GitLab + SaltRover + Podman + Nix architecture
   - CADRE router, Elixir GenServers, Rust FFI, Ada SPARK flow

### Analysis (✓ Done)

4. **Charter vs. RSR Conflict Resolution**
   - Identified 5 critical conflicts (GitHub vs. GitLab being primary)
   - Listed 14 excellent Charter elements to adopt
   - Proposed 31 missing elements for "bees knees" status
   - Three reconciliation strategies outlined

---

## 🚧 What Needs to Be Built

### Phase 1: Core Standards & Templates (Immediate Priority)

#### 1.1 Missing Required Documents

Create these in `templates/`:

- [ ] **REVERSIBILITY.md.template** – How to undo operations safely
- [ ] **DEPENDENCIES.md.template** – Dependency graph visualization
- [ ] **ROADMAP.md.template** – Future direction and handoffs
- [ ] **COMPLIANCE.md.template** – Standards tracking (GDPR, WCAG, etc.)
- [ ] **ETHICS.md.template** – Ethical guidelines (for governance/safeguarding projects)
- [ ] **LEARNING.md.template** – Educational resources for students/teachers
- [ ] **FEEDBACK.md.template** – Community input mechanism
- [ ] **SECURITY.md.template** – Vulnerability reporting, SLA, supported versions
- [ ] **CODE_OF_CONDUCT.adoc.template** – Community standards
- [ ] **GOVERNANCE.adoc.template** – Decision-making, roles, TPCF implementation
- [ ] **CONTRIBUTING.adoc.template** – Workflow, commit standards, TPCF perimeters

#### 1.2 Directory Structure Standards

Create `.well-known/` templates:

- [ ] **`.well-known/security.txt.template`** – Security contact, PGP keys
- [ ] **`.well-known/ai.txt.template`** – AI crawling policies (your AIBDP work!)
- [ ] **`.well-known/consent-required.txt.template`** – HTTP 430 consent protocol
- [ ] **`.well-known/provenance.json.template`** – Content provenance chains
- [ ] **`.well-known/humans.txt.template`** – Attribution, credits

#### 1.3 Build & CI/CD Templates

- [ ] **`justfile.template`** – Standard recipes (build, test, validate, audit-license, etc.)
- [ ] **`.gitlab-ci.yml.template`** – GitLab CI/CD pipeline for RSR compliance
- [ ] **`flake.nix.template`** – Nix flake for reproducible builds
- [ ] **`podman-compose.yml.template`** – Chainguard Wolfi-based containerization

### Phase 2: Automation Tooling (High Priority)

#### 2.1 Ada TUI: `rhodium-init`

Build an Ada 2022 TUI application that:

**Features**:
- [ ] Interactive project scaffolding wizard
- [ ] Prompts for:
  - Project name
  - Primary language (Ada, Elixir, Rust, etc.)
  - Repository URL (GitLab group/repo)
  - Build tool (Justfile, GPRbuild, Mix, Cargo)
  - Configuration paths (`~/.config/{project-name}/`)
  - CLI flags and options
  - Core problem/solution descriptions
  - Features list
  - Use cases
  - Target audience
  - Emoji for GitLab description
  - TPCF perimeter assignments
  - Ethical alignment (if applicable)
- [ ] Generates all required files from templates
- [ ] Sets up Git hooks for RVC (Robot Vacuum Cleaner) pattern
- [ ] Initializes Nix flake
- [ ] Creates Justfile with project-specific recipes
- [ ] Validates SPDX headers
- [ ] Configures `.well-known/` directory

**Technology**:
- Ada 2022 with GNAT
- Terminal UI library (e.g., AdaCore's GNATcoll, or custom ANSI escape sequences)
- SHAKE256(M, d) = KECCAK[512] for file integrity hashing
- TOML/YAML parsing for configuration

**Deliverable**: `rhodium-init` binary

#### 2.2 Compliance Validator: `rhodium-validate`

Build a command-line validator that checks RSR compliance:

**Features**:
- [ ] Scans repository structure
- [ ] Validates required files exist (README, LICENSE.txt, SECURITY.md, etc.)
- [ ] Checks SPDX headers on all source files
- [ ] Validates link integrity (Lychee integration)
- [ ] Checks accessibility (alt text, semantic HTML)
- [ ] Verifies security headers configuration
- [ ] Tests offline-first capability
- [ ] Generates SARIF report for CI/CD
- [ ] Outputs human-readable compliance report

**Technology**:
- Rust (for speed and ecosystem access)
- `ripgrep` for file scanning
- `tree-sitter` for code parsing
- `lychee` for link validation
- SARIF output format

**Deliverable**: `rhodium-validate` binary

**Integration**: Called via `just validate`

#### 2.3 Documentation Reconciler: `docgementer`

Build the DocGementer tool (already conceptualized in CLAUDE.md):

**Features**:
- [ ] Scanner: ripgrep + git ls-files + tree-sitter
- [ ] Normalizer: mdast (Markdown) + Asciidoctor (AsciiDoc) → unified AST
- [ ] Schema: Nickel contracts for required docs, naming, structure
- [ ] Rules: miniKanren/Datalog for cross-file assertions
- [ ] Quality: Lychee, codespell/vale, anchor resolution
- [ ] Reporter: SARIF/JSON for CI, human reports (AsciiDoc/Markdown)
- [ ] Advisor: Non-intrusive recommendations (e.g., suggest ReScript migrations)

**Technology**:
- Rust for core engine
- Nickel for schema definitions
- miniKanren or Datalog (Soufflé) for relational queries

**Deliverable**: `docgementer` binary

#### 2.4 Robot Vacuum Cleaner (RVC): Rust Rewrite

Migrate RVC from Python to Rust:

**Features**:
- [ ] Pre-commit hook: Format, lint, SPDX header check
- [ ] Pre-push hook: Test run, link validation, security scan
- [ ] Automated tidying: Remove trailing whitespace, fix line endings, etc.
- [ ] Git integration via libgit2-rs
- [ ] Configuration via Nickel

**Technology**:
- Rust
- `libgit2` bindings
- `serde` for configuration

**Deliverable**: `rhodium-rvc` binary

#### 2.5 Offline Repository Manager: `saltrover`

Build SaltRover (or migrate from existing tool):

**Features**:
- [ ] Offline-first repository synchronization
- [ ] GitLab API integration
- [ ] Local caching of dependencies
- [ ] CI/CD pipeline triggering
- [ ] Works without network connectivity
- [ ] Syncs when online

**Technology**:
- Elixir (for OTP supervision trees, fault tolerance)
- CRDT-based state management
- Deno for secure API calls

**Deliverable**: `saltrover` service

### Phase 3: Example Repositories (Medium Priority)

Create canonical examples showing RSR compliance:

#### 3.1 `rhodium-minimal`

Bare-minimum RSR-compliant repository:
- [ ] All required files
- [ ] Simplest possible structure
- [ ] Single-language (Ada recommended for demonstration)
- [ ] Full SPDX compliance
- [ ] Justfile with basic recipes
- [ ] GitLab CI/CD pipeline
- [ ] Nix flake
- [ ] `.well-known/` directory

#### 3.2 `rhodium-full`

Complete RSR with all bells and whistles:
- [ ] Multi-language (Ada + Rust + Elixir)
- [ ] FFI integration examples
- [ ] CADRE router demonstration
- [ ] Elixir GenServers with supervision trees
- [ ] SPARK formal verification examples
- [ ] CRDT state management
- [ ] Comprehensive documentation
- [ ] All optional files (ROADMAP, ETHICS, LEARNING, etc.)
- [ ] Accessibility testing
- [ ] Internationalization examples

#### 3.3 `rhodium-migration`

Before/after examples showing:
- [ ] JavaScript → ReScript migration
- [ ] Python → Rust/Elixir migration
- [ ] Docker → Podman migration
- [ ] GitHub Actions → GitLab CI/CD migration
- [ ] npm → Nix/Justfile migration
- [ ] Conventional commits adoption
- [ ] SPDX header addition
- [ ] `.well-known/` directory creation

### Phase 4: Standards Documentation (Medium Priority)

#### 4.1 Reconcile Charter + RSR

Decision needed: **Merge or separate?**

**Option A: Merge into "Rhodium Standard Repository (RSR) Charter"**
- Single comprehensive standard
- Combines Charter's GitHub-agnostic best practices with RSR's opinionated requirements
- Clear sections for "Core" (all platforms) vs. "RSR-Specific" (GitLab + CCCP)

**Option B: Separate with Mapping**
- `CHARTER.md`: Platform-agnostic baseline
- `RSR.md`: GitLab-based, CCCP-aligned superset
- `CHARTER-TO-RSR-MAPPING.md`: Shows how they relate

**Option C: Charter Variants**
- `CHARTER-CORE.md`: Platform-agnostic essentials
- `CHARTER-GITHUB.md`: GitHub-specific implementation
- `CHARTER-GITLAB-RSR.md`: Full RSR/CCCP compliance

**Recommendation**: Start with **Option A** (single merged standard), then extract platform-specific variants if community demand requires it.

#### 4.2 Create Audit Checklist

Transform RSR criteria into pass/fail checklist:

- [ ] **COMPLIANCE_CHECKLIST.md**
  - Section 1: Foundational Infrastructure (Nix, Nickel, Justfile, Podman)
  - Section 2: Documentation Standards (Required files, link integrity, DocGementer compliance)
  - Section 3: Security Architecture (11 dimensions, each with pass/fail criteria)
  - Section 4: Architecture Principles (Offline-first, reversibility, CRDTs, etc.)
  - Section 5: Web Standards (.well-known/, DNSSEC, security headers)
  - Section 6: Semantic Web & IndieWeb
  - Section 7: Licensing (SPDX, dual licensing)
  - Section 8: Accessibility (WCAG 2.1 AA)
  - Section 9: Lifecycle Management
  - Section 10: Governance (TPCF implementation)
  - Section 11: MAA Framework

**Format**: Markdown with checkboxes, automated via `rhodium-validate`

#### 4.3 Write CCCP Manifesto

Standalone document articulating the philosophy:

- [ ] **CCCP-MANIFESTO.md**
  - Historical context (npm/node fragility, Docker licensing, GitHub centralization)
  - Core principles (post-JavaScript liberation, offline-first autonomy, CRDTs, formal verification, community over ego)
  - "Cooler" as multi-dimensional (emotional, computational, social, political temperature)
  - Language polyglotism as resistance
  - Emotional safety through reversibility
  - Technical specifications (ReScript, Rust, Ada, Elixir, Haskell stack)
  - Governance model (TPCF)
  - Palimpsest License integration
  - Solidarity economics (NUJ pricing, cooperative ownership)
  - Call to action

**Format**: AsciiDoc (for richer formatting), publishable as standalone document

#### 4.4 Document the Citadel

Create architecture deep-dive:

- [ ] **CITADEL.adoc**
  - Component architecture (GitLab, SaltRover, RVC, CADRE, Haskell Registry)
  - Data flow diagrams
  - Security perimeters (Deno permissions, Podman rootless, SDP)
  - Offline-first implementation details
  - CRDT conflict resolution algorithms
  - Elixir supervision tree patterns
  - Rust ↔ Ada FFI integration examples
  - WASM compilation targets
  - Nix flake reproducibility guarantees
  - Nickel configuration patterns

### Phase 5: Community & Governance (Ongoing)

#### 5.1 Establish Governance

- [ ] **GOVERNANCE.adoc** (finalized, not just template)
  - Decision-making process (lazy consensus, RFCs)
  - Roles:
    - Maintainer (Perimeter 1 access)
    - Trusted Contributor (Perimeter 2 access)
    - Community Member (Perimeter 3 access)
    - Steward (ethical oversight)
  - Voting procedures (if applicable)
  - Conflict resolution
  - Maintainer succession planning
  - Financial transparency

#### 5.2 Create Rhodium Working Group

- [ ] Open invitation for contributors
- [ ] Regular office hours for Q&A
- [ ] Mentorship pairing (new contributors + maintainers)
- [ ] RFC process for major changes to standards

#### 5.3 Publish & Promote

- [ ] GitLab Pages site for documentation
- [ ] Badge system (RSR Compliant badge)
- [ ] Registry of RSR-compliant repositories
- [ ] Blog posts/articles explaining RSR/CCCP
- [ ] Conference talks (FOSDEM, RustConf, ElixirConf, etc.)
- [ ] Academic paper (if applicable)

---

## 🛠️ Immediate Action Plan (Next 2 Weeks)

### Week 1: Standards & Templates

1. **Reconcile Charter + RSR** (Decision: Merge or separate?)
2. **Create missing templates**:
   - REVERSIBILITY.md.template
   - DEPENDENCIES.md.template
   - SECURITY.md.template
   - CONTRIBUTING.adoc.template
   - `.well-known/` templates
3. **Write COMPLIANCE_CHECKLIST.md** (pass/fail criteria)
4. **Finalize justfile.template** with standard recipes

### Week 2: Tooling Foundation

5. **Start `rhodium-init` (Ada TUI)**:
   - Design UI wireframes
   - Define prompt flow
   - Implement template rendering engine
6. **Prototype `rhodium-validate` (Rust)**:
   - Basic file structure validation
   - SPDX header checking
   - Integration with `just validate`
7. **Create `rhodium-minimal` example repo**:
   - Demonstrate complete compliance
   - Serve as reference implementation

---

## 📊 Success Metrics

### Short-term (3 months)
- [ ] 5 RSR-compliant repositories (yours)
- [ ] `rhodium-init` functional for Ada projects
- [ ] `rhodium-validate` catches 90% of compliance issues
- [ ] CLAUDE.md adopted by 3 external projects

### Medium-term (6 months)
- [ ] 20 RSR-compliant repositories (10 external)
- [ ] `rhodium-init` supports Ada, Elixir, Rust
- [ ] DocGementer alpha release
- [ ] CCCP Manifesto published and cited

### Long-term (12 months)
- [ ] 100 RSR-compliant repositories
- [ ] RSR badge displayed on 50+ projects
- [ ] Conference talk accepted
- [ ] Academic collaboration on formal verification aspects
- [ ] SaltRover production-ready
- [ ] Palimpsest License adopted by 10+ projects

---

## ❓ Key Decisions Needed from You

1. **Charter vs. RSR**: Merge into single standard, or keep separate with mapping?
2. **Tooling Priority**: Which tool to build first?
   - `rhodium-init` (scaffolding)?
   - `rhodium-validate` (compliance checking)?
   - `docgementer` (documentation reconciliation)?
   - `saltrover` (offline repo management)?
3. **Language for Tools**:
   - `rhodium-init`: Ada TUI (as discussed)?
   - `rhodium-validate`: Rust (for ecosystem access)?
   - `docgementer`: Rust + Nickel (as designed)?
   - `saltrover`: Elixir (for OTP)?
4. **Platform Scope**: Should Charter be platform-agnostic, or is this explicitly a GitLab-focused standard?
5. **Example Repos**: Which to build first—`rhodium-minimal`, `rhodium-full`, or `rhodium-migration`?

---

## 🎯 Vision: Making the Git World Better

### For Individual Developers
- **Emotional safety**: Reversibility, no shame, safe experimentation
- **Offline autonomy**: Work continues without connectivity
- **Clarity**: Documentation that's actually helpful
- **Quality**: Formal verification catches bugs before users do

### For Teams
- **Graduated trust**: TPCF allows contribution without chaos
- **Auditability**: SPDX headers + provenance chains
- **Interoperability**: iSOS (Integrated Stack of Stacks)
- **Sustainability**: Succession planning, EOL policies

### For the Ecosystem
- **Ethical AI**: Palimpsest License ensures attribution
- **Supply chain security**: SBOM, dependency vendoring, SLSA compliance
- **Accessibility**: WCAG 2.1 AA compliance by default
- **Resilience**: Offline-first, peer-to-peer, CRDT-based

### For Future Generations
- **Educational**: LEARNING.md templates, good first issues
- **Archival**: Sunset policies, data export, succession planning
- **Ethical**: ETHICS.md, governance transparency, solidarity economics

---

## 📞 Next Steps

**Right now, you should**:

1. **Decide on Charter/RSR reconciliation strategy** (tell me your preference)
2. **Choose first tool to build** (rhodium-init? rhodium-validate?)
3. **Review and approve README.adoc.template** (I just created it)
4. **Start creating missing templates** (I can help generate these)
5. **Set up example repositories** (rhodium-minimal as proof-of-concept)

**I can help you**:

- Generate all missing templates
- Write the Ada TUI for `rhodium-init`
- Build `rhodium-validate` in Rust
- Create example repositories
- Draft CCCP Manifesto
- Write COMPLIANCE_CHECKLIST.md
- Design badges and visual identity
- Set up GitLab Pages documentation site

**What would you like to tackle first?**
