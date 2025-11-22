# Rhodium Framework Examples

This directory contains comprehensive example projects demonstrating each level of Rhodium Framework compliance, from basic (Bronze) to aspirational (Rhodium).

## Overview

The Rhodium Framework defines four compliance levels, each building upon the previous:

| Level | Badge | Description | Example |
|-------|-------|-------------|---------|
| **Bronze** | ![Bronze](https://img.shields.io/badge/rhodium-bronze-CD7F32) | Basic project hygiene | [minimal-rust-project](minimal-rust-project/) |
| **Silver** | ![Silver](https://img.shields.io/badge/rhodium-silver-C0C0C0) | Production-ready standards | [standard-library](standard-library/) |
| **Gold** | ![Gold](https://img.shields.io/badge/rhodium-gold-FFD700) | Enterprise-grade practices | [enterprise-service](enterprise-service/) |
| **Rhodium** | ![Rhodium](https://img.shields.io/badge/rhodium-rhodium-9C27B0) | Highest tier (aspirational) | [ai-ml-project](ai-ml-project/) |

## Examples

### 1. Minimal Rust Project (Bronze Level)

**Path**: `examples/minimal-rust-project/`

A simple Rust library demonstrating Bronze-level compliance - the minimum requirements for a well-maintained project.

**Features**:
- Basic library with simple functions
- README, LICENSE, CODE_OF_CONDUCT
- Unit tests
- Minimal .rhodium configuration

**Use Case**: Starting a new open-source project

**Commands**:
```bash
cd minimal-rust-project
cargo test
rhodium check --level bronze
```

**Learn More**: [minimal-rust-project/README.md](minimal-rust-project/README.md)

---

### 2. Standard Library (Silver Level)

**Path**: `examples/standard-library/`

A more complete Rust library demonstrating Silver-level compliance with comprehensive documentation and community standards.

**Features**:
- Data structures (Stack, Queue)
- CHANGELOG, CONTRIBUTING, CITATION
- GitHub issue/PR templates
- >70% test coverage
- API documentation
- Examples

**Use Case**: Creating a public library or package

**Commands**:
```bash
cd standard-library
cargo test --all-features
cargo doc --open
rhodium check --level silver
```

**Learn More**: [standard-library/README.md](standard-library/README.md)

---

### 3. Enterprise Service (Gold Level)

**Path**: `examples/enterprise-service/`

A production-ready REST API microservice demonstrating Gold-level compliance with enterprise-grade practices.

**Features**:
- REST API with Axum
- ARCHITECTURE.md, SECURITY.md
- Architecture Decision Records (ADRs)
- SBOM and provenance tracking
- Performance benchmarks
- CI/CD workflows
- >80% test coverage

**Use Case**: Building production services

**Commands**:
```bash
cd enterprise-service
cargo test
cargo bench
rhodium check --level gold
```

**Learn More**: [enterprise-service/README.md](enterprise-service/README.md)

---

### 4. AI/ML Project (Rhodium Level)

**Path**: `examples/ai-ml-project/`

A comprehensive AI/ML project demonstrating Rhodium-level compliance - the highest tier with multi-language support and ML-specific governance.

**Features**:
- Multi-language (Rust + Python)
- ML model training and inference
- Model cards and data cards
- Fairness assessment
- Complete automation
- Advanced observability
- ML-specific best practices

**Use Case**: Enterprise AI/ML projects

**Commands**:
```bash
cd ai-ml-project
make install
make test
python python/train.py
rhodium check --level rhodium
```

**Learn More**: [ai-ml-project/README.md](ai-ml-project/README.md)

## Compliance Level Comparison

| Requirement | Bronze | Silver | Gold | Rhodium |
|------------|:------:|:------:|:----:|:-------:|
| README | ✓ | ✓ | ✓ | ✓ |
| LICENSE | ✓ | ✓ | ✓ | ✓ |
| CODE_OF_CONDUCT | ✓ | ✓ | ✓ | ✓ |
| Basic Tests | ✓ | ✓ | ✓ | ✓ |
| CHANGELOG | | ✓ | ✓ | ✓ |
| CONTRIBUTING | | ✓ | ✓ | ✓ |
| CITATION | | ✓ | ✓ | ✓ |
| Issue Templates | | ✓ | ✓ | ✓ |
| >70% Coverage | | ✓ | ✓ | ✓ |
| ARCHITECTURE | | | ✓ | ✓ |
| SECURITY | | | ✓ | ✓ |
| ADRs | | | ✓ | ✓ |
| SBOM | | | ✓ | ✓ |
| Benchmarks | | | ✓ | ✓ |
| >80% Coverage | | | ✓ | ✓ |
| Multi-Language | | | | ✓ |
| ML Governance | | | | ✓ |
| Complete Automation | | | | ✓ |

## Getting Started

### Prerequisites

- Rust 1.70 or later
- Cargo
- Git
- (For ai-ml-project) Python 3.9+

### Quick Tour

1. **Start with Bronze** - Understand the basics:
   ```bash
   cd minimal-rust-project
   cargo test
   cat .rhodium/config.toml
   ```

2. **Progress to Silver** - See production standards:
   ```bash
   cd ../standard-library
   cargo test --all-features
   cargo doc --open
   ```

3. **Explore Gold** - Learn enterprise practices:
   ```bash
   cd ../enterprise-service
   cargo test
   cargo bench
   ```

4. **Study Rhodium** - See the complete picture:
   ```bash
   cd ../ai-ml-project
   make install
   make test
   ```

## Tutorial

For a step-by-step guide to implementing each compliance level, see [TUTORIAL.md](TUTORIAL.md).

## Using These Examples

### As Templates

Each example can serve as a template for your projects:

1. **Copy the structure**:
   ```bash
   cp -r examples/standard-library my-new-project
   cd my-new-project
   ```

2. **Customize for your project**:
   - Update Cargo.toml with your project details
   - Modify README.md
   - Update .rhodium/config.toml
   - Replace source code

3. **Verify compliance**:
   ```bash
   rhodium check --level silver
   ```

### As Learning Resources

Study the progression:
- How tests evolve from Bronze to Rhodium
- How documentation becomes more comprehensive
- How automation increases at higher levels
- How governance is implemented

### For CI/CD Integration

Use the GitHub Actions workflows from Gold and Rhodium examples:
- `enterprise-service/.github/workflows/ci.yml`
- `enterprise-service/.github/workflows/security.yml`

## Rhodium CLI Usage

Each example demonstrates Rhodium CLI commands:

```bash
# Initialize a new project
rhodium init --level bronze

# Provision files for a level
rhodium provision --level silver

# Check compliance
rhodium check --level gold

# Generate compliance report
rhodium report --format html

# Validate all levels
rhodium validate --all-levels
```

## Directory Structure Patterns

### Bronze (Minimal)
```
project/
├── .rhodium/config.toml
├── src/
├── README.md
├── LICENSE
└── CODE_OF_CONDUCT.md
```

### Silver (Standard)
```
project/
├── .rhodium/config.toml
├── src/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
└── CITATION.cff
```

### Gold (Enterprise)
```
project/
├── .rhodium/config.toml
├── src/
├── .github/workflows/
├── docs/adr/
├── ARCHITECTURE.md
├── SECURITY.md
└── [all Silver files]
```

### Rhodium (Advanced)
```
project/
├── .rhodium/config.toml
├── src/           # Rust
├── python/        # Python
├── docs/
│   ├── adr/
│   └── notebooks/
├── MODEL_CARD.md
├── DATA_CARD.md
└── [all Gold files]
```

## Contributing

To add a new example:

1. Follow the pattern of existing examples
2. Ensure it builds and tests pass
3. Document the unique features
4. Update this README
5. Submit a pull request

## License

All examples are licensed under MIT OR Apache-2.0.

## Resources

- [Rhodium Framework Documentation](https://rhodium-framework.org)
- [Tutorial](TUTORIAL.md)
- [Rhodium CLI](https://github.com/Hyperpolymath/rhodium-cli)

## Questions?

- Check the [TUTORIAL.md](TUTORIAL.md)
- Read individual example READMEs
- Open an issue for questions

---

**Last Updated**: 2025-11-22
