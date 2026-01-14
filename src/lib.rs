use zed_extension_api::{self as zed, Result, LanguageServerId, Command};

struct HledgerExtension;

impl zed::Extension for HledgerExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Command> {
        // Use worktree.which() to find the hledger-lsp command in PATH
        let command_path = worktree
            .which("hledger-lsp")
            .ok_or_else(|| "hledger-lsp not found in PATH. Please install it with: npm install -g hledger-lsp".to_string())?;

        Ok(Command {
            command: command_path,
            args: vec!["--stdio".to_string()],
            env: Default::default(),
        })
    }
}

zed::register_extension!(HledgerExtension);
