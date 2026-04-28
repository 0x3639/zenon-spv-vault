# Mainnet Genesis Momentum

## Embedded value

| Field | Value |
| --- | --- |
| chain_id | `1` |
| height | `1` |
| header hash | `9e204601d1b7b1427fe12bc82622e610d8a6ad43c40abf020eb66e538bb8eeb0` |
| previous hash | `0000…0000` (32 zero bytes) |
| timestamp (Unix) | `1637755200` (2021-11-24 12:00:00 UTC) |
| version | `1` |
| changes_hash | `fe37ddbea9fc05b16cd91e8b50d6aa74c1754f00f3339c3512717fe92fdb3d78` |
| public_key | absent (genesis is unsigned) |
| signature | absent |
| account-header count | `14094` |
| data (decoded) | `000000000000000000004dd040595540d43ce8ff5946eeaa403fb13d0e582d8f#We are all Satoshi#Don't trust. Verify` |

The data field embeds a Bitcoin block hash (chain anchor in the spirit of Bitcoin's own genesis "The Times" message) plus the project motto.

## How it was acquired

- Endpoint: `https://my.hc1node.com:35997` (operator: hc1node).
- RPC method: `ledger.getMomentumByHash` with the height-1 hash returned by `ledger.getMomentumsByHeight(1, 1)`.
- Date: 2026-04-28.
- See `decisions/0002-genesis-trust-anchor.md` for why this single-peer fetch is acceptable as a starting point and what cross-checks should follow.

## Recompute proof

The embedded hash is the SHA3-256 of the signed envelope of `nom.Momentum.ComputeHash` (source: `reference/go-zenon/chain/nom/momentum.go:58-69`). We recomputed it from the RPC payload (no trust in the peer's claimed `hash` field):

```
content_hash = SHA3-256( join_bytes(
    sorted by AccountHeader.Bytes:
      address(20B) || uint64BE(height) || hash(32B)
    for each of the 14094 entries in `content`
) )
= 1bfc9e7035ceba7e45f6ab0fa40c448fc060b17ec31201fa51fa67a11b1ca577

data_hash = SHA3-256(base64-decoded `data` field)
          = afec215ac4fde9e11df7f3e965ac0fbc4c4705225e9f6f91d4ba3dc84adcf8e6

momentum_hash = SHA3-256( join_bytes(
    uint64BE(version=1),
    uint64BE(chain_id=1),
    previous_hash(32 zero bytes),
    uint64BE(height=1),
    uint64BE(timestamp=1637755200),
    data_hash,
    content_hash,
    changes_hash,
) )
= 9e204601d1b7b1427fe12bc82622e610d8a6ad43c40abf020eb66e538bb8eeb0   ✓ MATCH
```

The recompute script (`/tmp/verify_genesis.py` at the time of fetch) lives in the SPV repo's commit history; future re-verifications should produce a byte-identical script and result.

## Sources

- `reference/go-zenon/chain/nom/momentum.go:58-69` (`Momentum.ComputeHash`)
- `reference/go-zenon/chain/nom/momentum_content.go:29-55` (`MomentumContent.Hash` + sort order)
- `reference/go-zenon/common/types/account_header.go:41-46` (`AccountHeader.Bytes`)
- `reference/go-zenon/common/crypto/hash.go:9-15` (SHA3-256 primitive)
- `reference/go-zenon/common/bytes.go:24-28` (`Uint64ToBytes` is big-endian)
- RPC peer: `https://my.hc1node.com:35997`, accessed 2026-04-28.

## Open questions / `TODO`

- **Independent cross-check.** Repeat the fetch against ≥2 independent operators (different ASN, different geography) and confirm byte-equivalence. Update this note with the cross-check results.
- **Upstream reference.** If go-zenon's mainnet config bundle becomes accessible (e.g., a `genesis.json` shipped with the binary release), record the path here as a second-source citation.
- **Periodic checkpoint pairs.** Per spv-implementation-guide.md §2.5, ship checkpoint pairs alongside genesis to defend against long-range attacks for long-offline verifiers. Track in a future ADR.
