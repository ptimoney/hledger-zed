# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Zed editor extension that provides hledger (plain text accounting) language support. It integrates the tree-sitter-hledger grammar for syntax highlighting and connects to the hledger-lsp language server for IDE features.

**Part of the hledger-lsp-group monorepo** - see the parent `../CLAUDE.md` for cross-project development workflows.

## Build Commands

```bash
# Build the extension (compiles Rust to WebAssembly)
cargo build --release --target wasm32-wasip1

# The compiled extension will be at target/wasm32-wasip1/release/hledger.wasm
```

**Prerequisites:**
- Rust toolchain with `wasm32-wasip1` target: `rustup target add wasm32-wasip1`
- `hledger-lsp` installed globally: `npm install -g hledger-lsp`

## Testing the Extension Locally

1. Build the extension as shown above
2. In Zed, open the extensions panel
3. Use "Install Dev Extension" and select this directory
4. Open a `.journal` or `.hledger` file

## Project Structure

```
hledger-zed/
├── src/lib.rs                    # Extension entry point (LSP command setup)
├── Cargo.toml                    # Rust dependencies (zed_extension_api)
├── extension.toml                # Extension metadata and grammar/LSP config
├── languages/hledger/
│   ├── config.toml               # Language settings (comments, tabs, suffixes)
│   └── highlights.scm            # Syntax highlighting queries
└── grammars/hledger/             # tree-sitter grammar (separate project)
    ├── grammar.js                # Grammar definition
    ├── src/scanner.c             # External scanner for indentation
    └── queries/                  # Tree-sitter queries
```

## Architecture

### Extension Entry Point (src/lib.rs)

The Rust code implements `zed::Extension` with a single method `language_server_command()` that:
- Finds `hledger-lsp` in PATH using `worktree.which()`
- Returns command to start the LSP with `--stdio` flag
- Reports error if `hledger-lsp` is not installed

### Configuration Files

**extension.toml** - Defines:
- Extension metadata (id, name, version)
- Grammar source (references tree-sitter-hledger repository)
- Language server registration (hledger-lsp for hledger files)

**languages/hledger/config.toml** - Defines:
- File extensions: `.journal`, `.hledger`
- Comment syntax: `;` and `#`
- Indentation: 4 spaces, no hard tabs

### Grammar Integration

The extension references tree-sitter-hledger via a local file path in extension.toml. When publishing, this should point to the GitHub repository URL.

## Key Integration Points

### With hledger-lsp

The extension expects `hledger-lsp` to be installed globally and available in PATH. The language server provides:
- Completion, validation, formatting
- Hover information
- Go-to-definition for accounts and includes
- Code actions and semantic highlighting

### With tree-sitter-hledger

The grammar provides syntax highlighting and structural parsing. The `grammars/hledger/` subdirectory contains a copy of the tree-sitter grammar - see `grammars/hledger/CLAUDE.md` for detailed grammar development guidance.

## Development Notes

- The extension compiles to WebAssembly (wasm32-wasip1 target)
- Uses `zed_extension_api` crate for Zed integration
- Grammar changes require rebuilding the tree-sitter parser in `grammars/hledger/`
- LSP features depend on `hledger-lsp` being installed separately
