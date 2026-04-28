# external/

Summaries of external primitives that inform the Zenon SPV design but live outside the Zenon corpus. Each file is a short distillation pointing at the canonical specs and noting which Zenon concept it informs.

These summaries are stubs as of v0.1.0; populate them as the SPV design progresses. Each should answer: *what is this primitive, why does Zenon care, and where does Zenon's design borrow or diverge?*

## Planned files

- **`bip-157-compact-filters.md`** — Bitcoin BIP-157 (compact block-filter service). Informs the SPV's filter-fetch protocol.
- **`bip-158-block-filters.md`** — Bitcoin BIP-158 (compact filter encoding via Golomb-Rice). Filter format itself.
- **`neutrino-spv.md`** — Lightning Labs' Neutrino SPV reference. Closest production analog to what we're building.
- **`libp2p-overview.md`** — libp2p modular networking stack. Possible replacement for go-zenon's devp2p-style transport.
- **`libp2p-webrtc-transport.md`** — libp2p over WebRTC, browser SPV-relevant.
- **`webrtc-datachannel.md`** — WebRTC DataChannel transport details for browser clients.
- **`merkle-proofs-primer.md`** — Merkle inclusion proofs primer; the format and verification logic the SPV depends on.

## GitHub MCP transport

If the GitHub MCP server's official remote endpoint is unavailable, fall back to the local docker setup documented at `github.com/github/github-mcp-server`. Configure in `.mcp.json` accordingly.
