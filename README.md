# Solana & Agave Native Linux ARM64 (`aarch64-unknown-linux-gnu`)

[![Target: aarch64-unknown-linux-gnu](https://img.shields.io/badge/Target-aarch64--unknown--linux--gnu-blue.svg)](https://github.com/coad1024-cmd/solana-arm64-linux)
[![License: Apache-2.0 / MIT](https://img.shields.io/badge/License-Apache--2.0%20%2F%20MIT-green.svg)](LICENSE)
[![Release: v1.18.26-arm64-preview](https://img.shields.io/badge/Release-v1.18.26--arm64--preview-orange.svg)](https://github.com/coad1024-cmd/solana-arm64-linux/releases/tag/v1.18.26-arm64-preview)

Native, automated, and cryptographically verified Linux ARM64 (`aarch64-unknown-linux-gnu`) release builds for the Solana and Anza (Agave) developer toolchain suite.

---

## ⚡ Instant 1-Line Installation

To install the complete, natively compiled Solana ARM64 toolchain suite on any ARM64 Linux system (**AWS Graviton3/4, Oracle Ampere A1, Raspberry Pi 5, or Apple Silicon running Asahi/Fedora Linux**):

```bash
sh -c "$(curl -sSfL https://raw.githubusercontent.com/coad1024-cmd/solana-arm64-linux/main/install.sh)"
```

Once installed, add the binaries to your shell path:
```bash
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
```

Verify native execution:
```bash
solana --version
# solana-cli 1.18.26 (src:00000000; feat:3241752014, client:SolanaLabs)

file $(which solana)
# ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked
```

---

## 🚀 Why This Exists

Neither Solana Labs nor Anza (Agave) currently publishes official pre-compiled binaries for `aarch64-unknown-linux-gnu` in their release automation (`release.solana.com` or `release.anza.xyz`). While macOS Apple Silicon (`aarch64-apple-darwin`) and Linux x86_64 are supported, Linux on ARM64 has been completely omitted, triggering open community issues:
* **[Agave Issue #1734](https://github.com/anza-xyz/agave/issues/1734):** *Release for ARM linux architecture (AWS Graviton instances)*
* **[Agave Issue #6417](https://github.com/anza-xyz/agave/issues/6417):** *ARM linux aarch64 CLI build needed*

Developers on ARM-based cloud servers or bare-metal workstations were previously forced into a **45–90 minute manual compilation tax** from source that routinely fails on modern Linux distributions (GCC 14/15) due to C++ standard library header decoupling in bundled `librocksdb-sys` dependencies.

This repository provides **immediate, pre-compiled, verifiable release archives** and the open-source engineering blueprint to upstream this target permanently into Anza's core CI.

---

## 📦 What's Included

Every release tarball (`solana-release-aarch64-unknown-linux-gnu.tar.bz2`) contains all 24 native utilities:

| Binary | Description | ELF Architecture |
|---|---|---|
| `solana` | Primary Cluster & Wallet CLI Client | `ARM aarch64` |
| `solana-keygen` | Keypair generation and HD derivation | `ARM aarch64` |
| `cargo-build-sbf` | Native Solana Bytecode Format (SBF) Program Compiler | `ARM aarch64` |
| `cargo-test-sbf` | SBF Program Test Utility | `ARM aarch64` |
| `solana-test-validator` | In-memory local development validator | `ARM aarch64` |
| `solana-validator` | Production Consensus & Validator Node Daemon | `ARM aarch64` |
| `solana-ledger-tool` | Offline blockstore and forensic ledger inspector | `ARM aarch64` |
| `spl-token` | SPL Token-2022 & Classic Token CLI | `ARM aarch64` |

---

## 🔬 Proof of Work & Systems Architecture

* Full technical autopsy of GCC 15 transitive header decoupling, RocksDB AST patching, and dual C/C++ `bindgen` preprocessor guards: **[Read ARCHITECTURE.md](ARCHITECTURE.md)**
* Empirical developer test walkthrough running Anchor smart contracts in LiteSVM in 0.15s: **[Read the LiteSVM Gist](https://gist.github.com/coad1024-cmd/d3822eb6cab1d159946e7764d8cf1f4d)**
* Production-grade Solana Foundation Grant Proposal synthesizing all 5 verified protocol deliverables, empirical benchmarks, and 3-milestone $75,000 budget plan: **[Read GRANT_PROPOSAL.md](GRANT_PROPOSAL.md)**

---

## 📜 License

Dual-licensed under either of:
* Apache License, Version 2.0 ([LICENSE-APACHE](http://www.apache.org/licenses/LICENSE-2.0))
* MIT license ([LICENSE-MIT](http://opensource.org/licenses/MIT))
