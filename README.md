# A Nix Flake for Playwright MCP
**Deprecated**: Use `playwright-mcp` package from nixpkgs instead. This
repository is no longer maintained.

This repository now only provides a Nix-wrapped version of the Playwright MCP
server, with the browser executable set to Chromium from Nixpkgs. I am still
maintaining this repository for personal use, but it doesn't offer much benefit.

For a comprehensive framework for running MCP servers on NixOS, I would
recommend the following options:

- https://github.com/natsukium/mcp-servers-nix
- https://github.com/aloshy-ai/nix-mcp-servers
- https://github.com/cameronfyfe/nix-mcp-servers
## Usage
Run the server:

``` shell
nix run github:akirak/nix-playwright-mcp
```

or in headless mode:

``` shell
nix run github:akirak/nix-playwright-mcp -- --headless
```
## Credits
To initially make Playwright run on NixOS, I followed [a thread on the NixOS
Discourse](https://discourse.nixos.org/t/running-playwright-tests/25655/). The
posts by Patrizio Bekerle, a.k.a. `pbek`, and Giacomo Debidda, a.k.a. `jackdbd`,
were especially helpful. Thanks!
