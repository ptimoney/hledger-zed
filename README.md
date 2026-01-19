# hledger-zed

Zed extension for [hledger](https://hledger.org/) the plain text accounting tool,
powered by the [hledger-lsp](https://github.com/ptimoney/hledger-lsp) language server.

## Features

This extension provides full IDE support for hledger journal files (`.journal`, `.hledger`):

- **Syntax highlighting** via tree-sitter-hledger grammar
- **Intelligent completion** for accounts, payees, commodities, and tags
- **Validation** with configurable rules (balance checking, date ordering,
  undeclared items, etc.)
- **Auto formatting** with automatic commodity formatting and column alignment
- **Navigation** (go to definition, find references, document/workspace symbols)
- **Code actions** (add declarations, rename refactoring)
- **Inlay hints** for inferred amounts, running balances, and cost conversions
- **Semantic highlighting** for richer syntax coloring
- **Multi-file support** via include directives

For a complete feature list and examples, see the [hledger-lsp server documentation](https://github.com/ptimoney/hledger-lsp#features).

## Prerequisites

You must have the `hledger-lsp` language server installed. Install it globally via npm:

```bash
npm install -g hledger-lsp
```

Ensure `hledger-lsp` is in your PATH. Verify by running:

```bash
hledger-lsp --version
```

## Installation

Install from the [Zed Extensions](https://zed.dev/extensions) marketplace by searching for "hledger".

The extension will start automatically when you open a `.journal` or `.hledger` file.

## Quick Start

1. Install `hledger-lsp` globally (see Prerequisites)
2. Install the extension from Zed's extension marketplace
3. Open a hledger journal file (`.journal` or `.hledger`)
4. Start editing! The language server provides completions, diagnostics, and more

## Configuration

Configure the language server via Zed's `settings.json`. Add settings under
`lsp.hledger-lsp.settings.hledgerLanguageServer`:

```json
{
  "lsp": {
    "hledger-lsp": {
      "settings": {
        "hledgerLanguageServer": {
          "inlayHints": {
            "showInferredAmounts": true,
            "showRunningBalances": true
          },
          "validation": {
            "undeclaredAccounts": true
          }
        }
      }
    }
  }
}
```

### Available Settings

All settings are under the `hledgerLanguageServer` namespace:

- **Validation** (`validation.*`) - Toggle individual validation rules
- **Formatting** (`formatting.*`) - Configure indentation and alignment
- **Inlay Hints** (`inlayHints.*`) - Control which hints to display
- **Completion** (`completion.*`) - Filter completion suggestions
- **Severity** (`severity.*`) - Set diagnostic severity levels

For detailed documentation of all settings, visit the [server configuration guide](https://github.com/ptimoney/hledger-lsp#configuration).

### Full Settings Reference

```json
{
  "lsp": {
    "hledger-lsp": {
      "settings": {
        "hledgerLanguageServer": {
          "validation": {
            "balance": true,
            "missingAmounts": true,
            "undeclaredAccounts": true,
            "undeclaredPayees": false,
            "undeclaredCommodities": true,
            "undeclaredTags": false,
            "dateOrdering": true,
            "balanceAssertions": true,
            "emptyTransactions": true,
            "invalidDates": true,
            "futureDates": true,
            "emptyDescriptions": true,
            "formatMismatch": true,
            "includeFiles": true,
            "circularIncludes": true,
            "markAllUndeclaredInstances": true
          },
          "severity": {
            "undeclaredAccounts": "warning",
            "undeclaredPayees": "warning",
            "undeclaredCommodities": "warning",
            "undeclaredTags": "information"
          },
          "include": {
            "followIncludes": true,
            "maxDepth": 10
          },
          "workspace": {
            "enabled": true,
            "eagerParsing": true,
            "autoDetectRoot": true
          },
          "completion": {
            "onlyDeclaredAccounts": true,
            "onlyDeclaredPayees": true,
            "onlyDeclaredCommodities": true,
            "onlyDeclaredTags": true
          },
          "formatting": {
            "indentation": 4,
            "maxCommodityWidth": 4,
            "maxAmountIntegerWidth": 12,
            "maxAmountDecimalWidth": 3,
            "minSpacing": 2,
            "decimalAlignColumn": 52,
            "assertionDecimalAlignColumn": 70,
            "signPosition": "after-symbol",
            "showPositivesSign": false
          },
          "inlayHints": {
            "showInferredAmounts": true,
            "showRunningBalances": false,
            "showCostConversions": true
          },
          "codeLens": {
            "showTransactionCounts": false
          },
          "maxNumberOfProblems": 1000,
          "hledgerPath": "hledger"
        }
      }
    }
  }
}
```

## Development

### Building from Source

1. Clone this repository:

   ```bash
   git clone https://github.com/ptimoney/hledger-zed.git
   cd hledger-zed
   ```

2. Ensure you have the `wasm32-wasip1` target installed:

   ```bash
   rustup target add wasm32-wasip1
   ```

3. Build the extension:

   ```bash
   cargo build --release --target wasm32-wasip1
   ```

### Testing Locally

1. Build the extension (see above)
2. In Zed, open the extensions panel
3. Use "Install Dev Extension" and select this directory
4. Open a `.journal` or `.hledger` file to test

### Project Structure

```
hledger-zed/
├── src/lib.rs                    # Extension entry point (LSP setup)
├── Cargo.toml                    # Rust dependencies
├── extension.toml                # Extension metadata and config
└── languages/hledger/
    ├── config.toml               # Language settings
    └── highlights.scm            # Syntax highlighting queries
```

## Troubleshooting

### LSP not starting

1. Verify `hledger-lsp` is installed and in PATH:
   ```bash
   which hledger-lsp
   hledger-lsp --version
   ```

2. Check Zed's logs for errors (View > Toggle Log or `cmd+shift+l`)

3. Try restarting Zed after installing `hledger-lsp`

### No syntax highlighting

Ensure you're opening a file with `.journal` or `.hledger` extension.

## License

MIT

## Contributing

Found a bug or have a feature request? Please [open an issue](https://github.com/ptimoney/hledger-zed/issues).

For server-side bugs (parsing, validation, LSP features), please report them
in the [hledger-lsp repository](https://github.com/ptimoney/hledger-lsp/issues).

## Links

- **Extension Repository**: [hledger-zed](https://github.com/ptimoney/hledger-zed)
- **Language Server**: [hledger-lsp repository](https://github.com/ptimoney/hledger-lsp)
- **Report Issues**: [Extension issues](https://github.com/ptimoney/hledger-zed/issues) | [Server issues](https://github.com/ptimoney/hledger-lsp/issues)
- **Documentation**: [Server features](https://github.com/ptimoney/hledger-lsp#features) | [Configuration guide](https://github.com/ptimoney/hledger-lsp#configuration)
- **hledger**: [Official documentation](https://hledger.org/)
