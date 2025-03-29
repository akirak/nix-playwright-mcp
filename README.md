# A Nix Flake for Playwright MCP
This aims to be the easiest solution for running [the Playwright MCP
server](https://github.com/microsoft/playwright-mcp) on NixOS.

This repository packages the [Playwright](https://playwright.dev/) server in a
Nix flake, so you can run it for
[playwright-mcp](https://github.com/microsoft/playwright-mcp). It also packages
the Playwright MCP server in Nix, to prevent the error of [Playwright version
mismatch](https://github.com/microsoft/playwright-mcp/issues/7).
## Rationale
By early 2025, the Model Context Protocol (MCP) is an emerging topic among AI
users. Microsoft has released
[playwright-mcp](https://github.com/microsoft/playwright-mcp), which seems to be
growing in popularity.

Unfortunately, Playwright + Playwright MCP is a little hard to set up on NixOS
for the following reasons:

- [Playwright itself is already confusing on
  NixOS](https://discourse.nixos.org/t/running-playwright-tests/25655), because
  Playwright looks for a browser executable from a specific location on the
  Filesystem Hierarchy Standard (FHS), which NixOS doesn't adhere to.
- Furthermore, Playwright MCP needs a Playwright server with a specific version
  running in the environment.

By providing both Playwright and the MCP server from a single flake, the above
issues will be resolved!
## Features
- Intuitive and easy to use on NixOS.
- Use the official NixOS package for Playwright browser executables, i.e.
  `playwright-driver-browsers`.
- Include only a single browser executable to minimize the download time.
  Currently, only chromium is supported.
- Also package the MCP server to prevent version issues.
## Usage
To perform anything meaningful with Playwright MCP, you have to run both a
Playwright server and a Playwright MCP server.
### Running a Playwright server
The easiest way is to run the flake directly:

``` shell
nix run github:akirak/nix-playwright-mcp
```

It accepts some command-line options, which you can view by specifying `--help`
as the argument.

The command will print the URL to its WebSocket on console:

> Playwright WebSocket server running on ws://127.0.0.1:39127/

You can set the WebSocket port by specifying `--port` option:

``` shell
nix run github:akirak/nix-playwright-mcp -- --port 39001
```

In this example, the WebSocket endpoint will be `ws://localhost:39001/`.
### Running a MCP server
``` shell
nix run github:akirak/nix-playwright-mcp#mcp-server
```

It accepts the same command-line option as the `@playwright/mcp` package of
[playwright-mcp](https://github.com/microsoft/playwright-mcp).

You will probably want to set `PLAYWRIGHT_WS_ENDPOINT` environment variable to
the WebSocket path of the Playwright server, which you can obtain from the
previous console output.
## Technical Details
Because `playwright run-server` is limited in terms of options, this project
provides a custom server executable which wraps the Playwright API.

Dependencies are regularly updated by Renovate. `playwright-core` package for
the Playwright server is updated using a maintenance script (`update.bash`), to
match the requirement of the MCP server. When the npm lock file is changed, the
maintainer manually merges the PR, because Renovate Bot doesn't automatically
merge PRs that have been committed further by other parties.
## Credits
To initially make Playwright run on NixOS, I followed [a thread on the NixOS
Discourse](https://discourse.nixos.org/t/running-playwright-tests/25655/). The
posts by Patrizio Bekerle, a.k.a. `pbek`, and Giacomo Debidda, a.k.a. `jackdbd`,
were especially helpful. Thanks!
