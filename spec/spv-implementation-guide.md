Zenon Greenpaper Series

Zenon SPV Implementation Guide

Status: Community-authored companion (non-normative, non-official)

Authorship: Zenon Developer Commons (community)

Date: January 4, 2026 (Pre-prototype draft)

This guide is a practical, builder-oriented companion to A
Verification-First Architecture for Dual-Ledger Systems. It describes how
to implement a resource-bounded verifier (SPV-style) that follows the
paper’s refusal semantics. Pre-prototype note: numeric targets and
economic estimates in this guide are illustrative and parameterized.
Replace them with measurements from an implementation and observed
network data before treating them as operational guarantees.

Zenon Greenpaper Series

Abstract

C

This document provides a non-normative implementation guide for Zenon
SPV  verification.  It  maps  the  greenpaper’s  core  objects—Momentum
headers, the commitment root r
, and commitment membership proofs of
size O(log m)—into concrete interfaces, request/response shapes, caching
strategies,  and  verifier  outcomes.  The  guide  emphasizes  explicit  refusal
behavior: if required evidence is missing or exceeds declared bounds, the
verifier  returns  REFUSED  rather  than  guessing.  This  pre-prototype  draft
also  includes  worked  examples  with  concrete  resource  calculations
(bandwidth,  computation,  storage)  to  help  implementers  validate  bounds
and anticipate refusal rates before committing to development.

1. Scope

Zenon SPV, in the sense used by the greenpaper, is a lightweight verifier
that  validates  stated  facts  by  checking  (i)  a  verified  Momentum  header
chain,  (ii)  membership  of  relevant  commitments  under  the  per-header
commitment  root  r
,  and  (iii)  account-chain  segment  integrity,  all  under
explicit resource bounds.

C

1.1 Goals

Independent  verification:  no  trusted  intermediary  is  required  to
validate the evidence that is presented.

(cid:127) Bounded  operation:  the  verifier  enforces  explicit  limits  on  storage,

bandwidth, and computation.

(cid:127) Refusal  semantics:

insufficient  evidence  yields  REFUSED,  not

probabilistic acceptance.

(cid:127) Offline  resilience:  a  verifier  can  resume  from  its  last  verified  header

and cached proofs.

(cid:127) Security-first  operation:  mitigate

light-client

isolation  risk  via

multi-source evidence and randomized peer selection.

(cid:127) Transparent trade-offs: present explicit security, economic, and refusal

assumptions without overstating claims.

1.2 Non-Goals

(cid:127) Re-executing a global VM or reconstructing global state from genesis.

1

(cid:127)
Zenon Greenpaper Series

(cid:127) Maintaining mempool state or participating in block production.

(cid:127) Accepting  statements  without  the  paper’s  required  evidence,  even  if

“likely true.”

2. Trust Roots and Evidence

Zenon SPV is anchored to a genesis trust root. From this root, the verifier
accepts  additional  evidence  only  if  it  is  cryptographically  bound  to  the
verified header chain and within declared limits.

2.1 Genesis Trust Root

A  verifier  MUST  ship  with  (or  be  configured  with)  the  genesis  trust  root
for  the  Momentum  header  chain,  including  the  genesis  header  hash  and
any  consensus  parameters  required  to  validate  successor  headers  as
specified by the greenpaper.

2.2 Header Authenticity vs. Consensus Confidence

Header anchoring and hash linkage provide authenticity for the headers a
verifier has obtained (i.e., that the verifier is checking membership proofs
against  an  authentic  r
).  Stronger  confidence  against  reorgs  requires
additional header-chain evidence within a bounded policy window w. If the
verifier  cannot  obtain  sufficient  window  evidence  under  its  bounds,  it
SHOULD return REFUSED, consistent with the paper’s refusal semantics.

C

2.3 Policy Window Instantiation (Non-Normative)

Implementers  need  a  concrete  rule  to  instantiate  the  abstract  “finality
function” implied by the greenpaper. This guide treats the policy window
w as a risk parameter chosen by the verifier operator, not a hard protocol
constant.

Definition  (policy  finality  check):  Let  k  be  the  number  of  consecutive
verified  Momentum  headers  after  height  h  (i.e.,  the  evidence  window
depth). Define a policy function f
(k) = ACCEPT if k ≥ w, otherwise
REFUSED.

consensus

Policy  window  recommendations  (illustrative;  calibrate  with  observed
reorg data):

(cid:127) Low-value  queries  (UI  previews):  w  ≥  6  headers  (~1  minute  if  10s

cadence).

2

Zenon Greenpaper Series

(cid:127) Medium-value (payments, routine ops): w ≥ 60 headers (~10 minutes).

(cid:127) High-value (bridges/exchanges): w ≥ 360 headers (~1 hour) or higher.

These  tiers  are  placeholders  until  (a)  a  public  reorg  monitor  exists  for  Zenon
mainnet,  and  (b)  prototypes  report  refusal  rates  under  realistic  peer  sets.
Implementations  SHOULD
log  observed  reorg  depths  and  publish  the
distribution (max depth, p95 depth) to justify w.

2.4 Privacy Note (Non-Normative)

Query  patterns  can  leak  which  accounts  or  commitments  a  verifier  is
interested  in.  Implementations  SHOULD  consider  privacy-preserving
retrieval (batching, randomized retrieval, or filter-style requests) so proof
fetching does not trivially reveal the verifier’s interests to a single peer.

2.5 Weak Subjectivity Considerations
(Non-Normative)

Long-range  attacks  are  a  general  risk  for  stake-based  systems  when  a
verifier  has  been  offline  for  extended  periods.  If  a  verifier  is  offline  for
long horizons (e.g., many months to ~1 year), additional checkpoints MAY
be  required  to  prevent  acceptance  of  a  fabricated  long-range  fork  that
starts near genesis.

Operational recommendation: ship periodic checkpoint pairs (Momentum
height,  header  hash)  via  software  updates  (e.g.,  quarterly).  The  verifier
can  treat  the  most  recent  embedded  checkpoint  as  an  additional  trust
anchor for long-offline recovery. This is compatible with refusal semantics:
if  no  acceptable  checkpoint  is  available  for  a  long-offline  verifier,  it
SHOULD REFUSE rather than guess.

3. Data Objects

3.1 Momentum Header (Verifier-Required Subset)

A SPV verifier does not require full node state, but it does require a stable
subset  of  each  Momentum  header  sufficient  to:  (i)  link  the  header  chain,
(ii)  validate  the  header  under  the  consensus  rules  referenced  by  the
paper,  and  (iii)  extract  the  commitment  root  r
  for  commitment
membership checks.

C

3

Zenon Greenpaper Series

Minimum  fields  (conceptual):  height,  prev_hash,  header_hash,  r
consensus/meta fields required by the header validity predicate.

C

,  and

3.2 Commitment Membership Proof under r_C

For  each  commitment  c  referenced  by  a  statement  or  account  segment,
 that verifies c is included
the prover MUST supply a membership proof π
in the set committed under the corresponding Momentum root r
(h). The
proof size is O(log m) where m is commitments per Momentum block.

C

C

Merkle branch sizing rule of thumb: If the membership proof is a Merkle branch
with 32-byte hashes and tree depth d = ceil(log₂(m)), then σ
 ≈ 32 · d bytes (plus
a  small  encoding  overhead).  Example:  m  ≈  10⁴  ⇒  d  ≈  14  ⇒  448  bytes  of  hash
material.

π

3.2.1 Merkle Tree Structure Assumption
(Non-Normative)

This guide assumes a binary Merkle tree with SHA-256 hashes (32 bytes
per  node)  for  membership  proofs  under  r
.  If  Zenon  uses  a  different
authenticated  structure  (e.g.,  a  Merkle  Patricia  Trie  or  another
accumulator),  adjust
the  depth  and  branch-length  calculations
accordingly.  For  comparison:  Ethereum’s  Merkle  Patricia  Trie  has
variable branch length; use measured branch sizes from real proofs.

C

3.3 Account-Chain Segment Bundle

An  account-chain  segment  bundle  for  account  A  consists  of  a  contiguous
range of account blocks B
[i..j], together with all proof objects needed to
bind  each  block  (or  each  referenced  commitment)  to  an  authenticated
Momentum root r

 at the appropriate height.

A

C

3.4 Resource Parameters

The  guide  uses  the  following  parameters  for  concrete  accounting.
Implementations SHOULD measure them on target platforms and publish
the measurements along with the exact implementation version.

(cid:127) σ

(cid:127) σ

: average bytes per Momentum header (verifier-retained subset).

H

: average bytes per account-chain block.

B

(cid:127) σ

π

: average bytes per proof object (e.g., Merkle branch bytes).

4

Zenon Greenpaper Series

(cid:127) w:  policy  window  in  Momentum  headers  for  consensus  confidence

(Section 2.3).

(cid:127) C

verify

: per-proof verification cost (bounded by C

).

V

4. Verifier Interfaces

The  following  interfaces  are  non-normative  but  are  designed  to  map
directly  onto  the  greenpaper’s  verification  predicates.  Each  interface
returns one of three outcomes: ACCEPT, REJECT, or REFUSED.

4.1 Common Outcomes

(cid:127) ACCEPT: the statement is verified under declared bounds.

(cid:127) REJECT:  evidence  is  present  but  invalid  (broken  linkage,  failed

cryptographic checks).

(cid:127) REFUSED:  evidence  is  missing,  incomplete,  or  exceeds  bounds;  the

verifier does not guess.

4.2 Header Verification

Verify a sequence of Momentum headers extending a locally trusted base.
Implementations  SHOULD  obtain  evidence  from  multiple  sources  where
feasible and SHOULD enforce a policy window w appropriate to the value
at risk.

VerifyHeaders(H[k..n], header_state) -> {ACCEPT, REJECT, REFUSED} +
header_state'

4.3 Commitment Membership Verification

VerifyCommitment(r_C(h), c, π_C) -> {ACCEPT, REJECT, REFUSED}

4.4 Account-Chain Segment Verification

VerifyAccountSegment(A, B_A[i..j], proofs, header_state) ->
{ACCEPT, REJECT, REFUSED}

A segment is ACCEPT only if (i) the account chain links correctly, (ii) every
required proof verifies, and (iii) every referenced commitment is proven to
be  a  member  under  an  authenticated  r
(h)  whose  header  is  within  the
verifier’s retained evidence window.

C

5

Zenon Greenpaper Series

5. Verification Flows

The  table  below  summarizes  the  primary  SPV  verification  flows  and
expected outcomes.

Flow

Steps

Expected outcome

Bootstrap

Load  genesis;  fetch  window  H[g..g+w];
VerifyHeaders; store retained window.

Account event

Fetch  segment+proofs;  ensure  headers
cover heights; verify memberships; verify
linkage.

Offline resume Load  cached  state;  fetch  successors;

re-verify window; continue.

ACCEPT if within bounds;
if  window
REFUSED
evidence
be
cannot
obtained.

with

ACCEPT
valid
proofs; REJECT on invalid
linkage/proofs; REFUSED
on missing evidence.

if

REFUSED
historical
cannot  be
under bounds.

required
evidence
re-acquired

6. Resource Accounting

This  section  provides  a  concrete,  parameterized  model  for  bandwidth,
computation,  and  header  storage.  The  intent  is  to  let  implementers  pick
explicit bounds and then check whether a requested verification fits those
bounds.

6.1 Core Bounds

Bandwidth(account segment) ∈ O(L

(σ

A

B

 + σ

)).

π

Computation(account  proofs)  ∈  O(L
verification cost bounded by C

.

V

  ·  C

A

verify

),  where  C

verify

  is  per-proof

Policy window storage (header retention) = w · σ

.

H

6.2 Concrete Parameter Table (Pre-Prototype)

Until  a  reference  implementation  publishes  measurements,  treat  the  values
below as parameter choices to run scenarios. Replace the “Basis / notes” column
with  real  data  (mainnet  sampling  +  WASM/mobile  benchmarks)  as  soon  as
prototypes exist.

6

Zenon Greenpaper Series

Metric

Conservative
estimate

Aggressive estimate Basis / notes

σ
header bytes)

H

(Momentum

  (account  block

σ
bytes)

B

  (Merkle  branch

σ
bytes)

π

800 B

1.5 KB

500 B

2 KB

416 B (d=13)

640 B (d=20)

retained

Sum  of
fields:
prev_hash(32B),
height(~8B),
rC(32B), signatures
/metadata
(dominant).
Measure  from  real
headers.

Measure  from  real
blocks;
account
on
depends
signatures/fields.

≈  32  ·  d  bytes  (+
overhead).
d=ceil(log₂ m).

w  (policy  window,
headers)

12

60

  (ms  per  hash

0.1–1 ms/hash

≈ 5 ms/hash

C
op)

hash

C
membership)

verify

(per

d · C

hash

d · C

hash

Calibrate
consensus
confidence;
Section 2.3 tiers.

to

see

Benchmark
WASM/mobile;
depends
implementation
and device class.

in

on

For
Merkle
membership:  verify
add
hashes;
d
signature checks as
needed.

Example window storage: if w=60 and σ
~60 KB, which is typically trivial for mobile and browser clients.

H

=1 KB, then retained-window storage is

6.3 Worked Example: Verifying a 100-Block Wallet
History

Assume the prover supplies L
=100 account blocks plus one membership
.  For  a  10-second  Momentum  cadence  and
proof  per  block  under  r
~100–10,000  active  accounts  per  Momentum,  a  realistic  commitment

C

A

7

Zenon Greenpaper Series

count is m≈10³–10⁴ (e.g., m≈8000), giving d=ceil(log₂ m)≈13. This avoids
unrealistic depths (e.g., d=30 would imply ~1 billion commitments).

Example parameters (illustrative; measure and replace):
L_A = 100 blocks
σ_B = 500 bytes (conservative)
m ≈ 8000 commitments per Momentum → d = ceil(log2 m) = 13
σ_π ≈ 32 × 13 = 416 bytes (Merkle hash material; encoding overhead
omitted)
C_hash = 1 ms/hash (mobile/WASM mid-range target)

Bandwidth:
100 × (500B + 416B) = 91,600B ≈ 92KB

Computation (Merkle membership only):
100 × (13 hashes) × (1 ms/hash) = 1300 ms = 1.3 s

Verdict (example policy):
If mobile compute budget is 2 s/query and bandwidth budget is
1–3MB/query,
this query is ACCEPT (fits bounds).

This  worked  example  is  intentionally  concrete:  report  your  own  tuple  (device,
runtime,  L
,  m,  d,  proof  type,  p50/p95  latency)  in  conformance  reports.  If  your
proof  structure  differs  from  a  binary  SHA-256  Merkle  tree,  compute  d  and  σ
from measured proof objects instead.

A

π

7. Refusal Cookbook

The  table  below  summarizes  common  conditions  and  the  correct  verifier
outcome.

Condition

Outcome

Reason

Missing  header
height h

for  referenced

REFUSED

Missing membership proof π

C

REFUSED

Proof present but fails verification

REJECT

8

Cannot  bind  proof
authenticated r

(h).

C

to  an

Evidence  is  insufficient  within
declared bounds.

Evidence
is
cryptographically.

invalid

Zenon Greenpaper Series

Policy window not satisfied (k<w)

REFUSED

Consensus
confidence
requirement  not  met  under
chosen policy.

Inconsistent  header  views  across
peers

REFUSED

Multi-source
disagrees;
consistent view is established.

evidence
until

refuse

Segment
bandwidth/compute bounds

exceeds

REFUSED

Verifier  must  respect  declared
constraints.

8. Conformance Testing

An implementation SHOULD provide deterministic tests for the following
cases:

(cid:127) Valid header chain extension within policy window.

(cid:127) Broken header linkage (prev_hash mismatch) → REJECT.

(cid:127) Valid commitment membership proof under r_C.

Invalid membership proof → REJECT.

(cid:127) Missing proof or missing required headers → REFUSED.

(cid:127) Account segment with correct linkage and bindings → ACCEPT.

Inconsistent  peer  responses  for  the  same  header  range  →  REFUSED
(until reconciled).

9. Security Considerations (Non-Normative)

Isolation/eclipsing:  diversify  peers;  randomize  selection;  require
multi-source confirmation for critical header ranges.

(cid:127) Reorg  policy:  bind  a  risk  tier  to  w,  and  log  observed  reorg  depths  to

justify w.

(cid:127) Availability  failure:  treat  missing  proofs  as  REFUSED;  design  UX

around progressive verification and caching.

(cid:127) Privacy  leakage:  avoid  single-peer  “tell  me  everything  about  account

A”; prefer batching or randomized retrieval.

9.1 Adversarial Scenario Analysis
(Non-Normative)

9

(cid:127)
(cid:127)
(cid:127)
Zenon Greenpaper Series

The table below summarizes common adversarial scenarios, the verifier’s
correct  response  under  refusal  semantics,  and  implementation-level
mitigations.

Attack

Adversary goal

Verifier response

Mitigation
cost

Eclipse
isolation

/

Isolate
biased headers/proofs

verifier;

serve

REFUSED  (multi-peer
disagreement)
or
REFUSED
(insufficient sources)

Require  k≥3
peers;
randomize;
rotate

Proof
withholding

Force  REFUSED  by  not
serving proofs

REFUSED
unavailable)

(data

Equivocation  /
fork split

Serve  two  valid  forks  to
confuse

REFUSED  until  k≥w
on a consistent chain

Invalid-proof
flooding (DoS)

Waste verifier compute

REJECT  (fast-fail)  +
rate-limit

+

Cache
fallback
peers;  proof
relays

Increase w for
high-value
queries

Per-peer
quotas;
on
failures

ban
repeated

Long-range
attack

Rewrite history far back

REFUSED  or  REJECT
depending
on
checkpoint policy

Periodic
checkpoints
(Section 2.5)

def FetchWithRedundancy(query, peers, k=3):
# Fetch the same object from k randomly sampled peers
sample = RandomSample(peers, k)
responses = [FetchFromPeer(p, query) for p in sample]
if not AllAgree(responses):
return REFUSED # suspected isolation or fork
return responses[0]

10. Implementation Checklist for Prototype
Builders

[ ] Measure σ_B, σ_π, and σ_H from testnet/mainnet samples.

[  ]  Benchmark  C_verify  on  target  platforms  (browser  WASM,  mobile
native).

10

(cid:127)
(cid:127)
Zenon Greenpaper Series

[  ]  Implement  multi-peer  header  fetching  with  consistency  checks
(Section 9.1).

]  Log  refusal  rates  by  category
[
COST_EXCEEDED vs WINDOW_NOT_MET).

(DATA_UNAVAILABLE  vs

[  ]  Test  simulated  network  partition  (should  return  REFUSED,  not
REJECT).

[  ]  Validate  policy  window  w  against  observed  reorg  data  (Appendix
D.4).

[  ]  Publish  a  conformance  report:  (device,  runtime,  p50/p95  latency,
refusal rate, parameter values).

Appendix A. Reference Pseudocode
(Non-Normative)

The pseudocode below sketches the control flow implied by the interfaces
above,  including  basic  hardening  (multi-peer  header  acquisition)  and
explicit refusal propagation.

function VerifyAccountEvent(A, query, opts):
segment, proofs = FetchAccountSegment(A, query.range)
if segment missing or proofs missing:
return REFUSED

heights = ExtractReferencedHeights(segment, proofs)

# Ensure policy window coverage
if not HeaderStateCovers(heights, w=opts.w):
headers = FetchHeadersToCover(heights, peers=opts.peers,
min_sources=2)
outcome = VerifyHeaders(headers, header_state)
if outcome != ACCEPT:
return outcome

# Verify per-commitment membership under authenticated r_C(h)
for each commitment c in ExtractCommitments(segment, proofs):
h = HeightForCommitment(c)
rC = header_state.rC[h]
πC = proofs.membership[c]
if πC missing:
return REFUSED
if VerifyCommitment(rC, c, πC) != ACCEPT:

11

(cid:127)
(cid:127)
(cid:127)
(cid:127)
(cid:127)
Zenon Greenpaper Series

return REJECT

if not VerifyAccountChainLinkage(segment):
return REJECT

return ACCEPT

Appendix B. Optional Succinct Proof Integration
(Non-Normative)

Some  deployments  may  prefer  to  replace  per-commitment  Merkle
membership proofs with a succinct proof system that attests membership
. This can reduce transmitted proof
for one or more commitments under r
material  per  membership,  depending  on  batching  strategy  and  proof
system. These choices are outside the greenpaper’s normative core: treat
them  as  optional  enhancements  and  publish  measured  costs  (proof  size,
verification latency, prover overhead) on target platforms.

C

Appendix C. Proof Availability Analysis
(Non-Normative, Pre-Prototype)

The greenpaper’s refusal semantics make availability a first-class concern:
missing  evidence  yields  REFUSED.  This  appendix  provides  a
parameterized and estimate-driven way to reason about refusal rates and
the  economics  of  serving  historical  proofs.  Treat  the  numbers  as
order-of-magnitude guidance; replace them with measured mainnet data.

C.1 Archival Cost Estimation (Desk Research;
Illustrative)

Assume  a  10-second  Momentum  cadence.  Then  blocks/day  =  8640.  Over
~3 years, Momentum headers ≈ 3 · 365 · 8640 ≈ 9.5M headers. If σ
 ≈ 1
KB retained/header, header retention for full history is ~9.5 GB.

H

A  conservative  archival  budget  might  include:  (i)  headers  (~10  GB),  (ii)
account-chain  history  (~10  GB),  and  (iii)  historical  proof  bundles  (~50
GB),  for  a  total  on  the  order  of  ~70  GB.  This  is  deliberately  coarse;
measure real sizes once proof formats are finalized.

12

Zenon Greenpaper Series

Using AWS S3 list pricing as a rough baseline, S3 Standard storage is commonly
quoted  at  ~$0.023/GB-month  for  the  first  50  TB,  and  data  transfer  out  to  the
public internet is commonly priced around ~$0.09/GB for the first 10 TB/month
(tiered thereafter). Costs vary by region and service; treat these as illustrative.

Illustrative monthly cost (order-of-magnitude):
Storage: 70 GB × $0.023/GB-month ≈ $1.61/month
Egress: 65 GB/month × $0.09/GB ≈ $5.85/month
Total: ≈ $7.50/month per archival endpoint

If  a  proof-serving  operator  receives  meaningful  ongoing  rewards,  the
marginal  cost  of  serving  tens  of  GB  and  moderate  egress  is  plausibly
small. However, real economics depend on workload (QPS), proof bundle
sizes, and the number of independent archival operators.

C.2 Refusal Rate Projections (Model-Based;
Illustrative)

Expected REFUSED rates depend on how many peers serve the required
historical evidence. As a simple model, let p be the fraction of peers that
can  serve  the  required  age  of  data;  then  the  probability  that  a  verifier
sampling  k  peers  can  find  at  least  one  serving  peer  is  1  -  (1-p)^k.  This
suggests  that  multi-peer  retrieval  can  reduce  REFUSED  rates  when  p  is
non-trivial.

Illustrative projections (replace with measured network data):

(cid:127) Fresh queries (<1 hour): refusal <1–2% if data is widely cached.

(cid:127) Recent (<30 days): refusal ~2–10% depending on pruning policies.

(cid:127) Older (>1 year): refusal ~40–60% if only a minority of operators serve

deep history.

Mitigation:  implement  proof  caching  at  the  client.  Even  a  ~1  GB  cache  of
validated  proof  bundles  can  materially  reduce  repeat-query  refusals.  Also
consider  optional  proof-relay  endpoints  (CDN-style)  that  serve  immutable
bundles; verification remains end-to-end.

Appendix D. dPoS Reorg Analysis (Desk Research;
Non-Normative)

D.1 Threat Model for Scheduled dPoS

13

Zenon Greenpaper Series

Zenon  Phase  0  is  commonly  described  as  scheduled  block  production
under delegated proof-of-stake (dPoS). Primary reorg vectors include: (a)
stake-weighted  collusion  or  key  compromise  sufficient  to  rewrite  recent
history,  and  (b)  network  partition  (or  severe  propagation  delay)  causing
temporary forks.

Stake attack (illustrative cost model): If an adversary needs to control >50% of
consensus  weight,  then  the  capital  cost  scales  with  the  amount  of  staked  ZNN
required.  Let  N  be  the  number  of  active  producers  and  S  be  average  effective
stake per producer; then a crude lower bound for attack capital is ~0.5 · N · S.
Multiply  by  market  price  to  estimate  fiat  cost.  These  inputs  MUST  be  replaced
with real stake distribution data.

D.2 Policy Window Justification (Comparative
Heuristics)

the
In  dPoS-style  systems,
probability  that  a  temporary  fork  or  coordinated  producer  set  can
successfully  reverse  a  statement  after  it  is  considered  final.  As  a
non-normative heuristic (not a guarantee):

longer  confirmation  windows  reduce

(cid:127) w=6 provides “fast UI” confidence for low-value queries.

(cid:127) w=60  provides  medium-value

confidence

and

“minutes-scale”  settlement  windows  used  operationally
systems.

aligns  with
in  other

(cid:127) w=360  provides  high-value  conservatism  for  bridges  and  exchange

operations.

D.3 Conservative Safety Model (Toy Model;
Illustrative)

Define  a  toy  policy  risk  function:  f
(k)  =  P(stake_attack)  +
P(partition_k).  As  an  illustrative  model,  assume  P(partition_k)  ≈  exp(-λk)
for  some  resilience  factor  λ>0.  This  is  not  a  proof;  it  is  a  placeholder  to
motivate why larger w improves safety under plausible network behavior.

consensus

Example (illustrative only):
Assume P(stake_attack) < 1e-6 (cost-prohibitive)
Assume λ = 0.1

For w = 60:
f_consensus(60) ≈ 1e-6 + exp(-6) ≈ 0.0025

14

Zenon Greenpaper Series

D.4 Measurement Mandate

These  estimates  MUST  be  replaced  with  historical  mainnet  data:  (i)
maximum  observed  reorg  depth,  (ii)  p95  confirmation  latency,  (iii)  stake
distribution  metrics  (e.g.,  concentration/Gini),  and  (iv)  observed  fork
resolution  behavior  under  network  stress.  Production  deployments
SHOULD publish this telemetry to justify w in a transparent way.

Appendix E. Comparative Analysis (Desk
Research; Non-Normative)

The  table  below  situates  Zenon  SPV  relative  to  several  light-client  /
verification  models.  Numbers  are  approximate  and  depend  heavily  on
implementation and configuration; treat them as directional.

System

Verification model

Proof size

Verification
time

DA
assumption

Trust
model

Zenon  SPV  (this
guide)

Bounded  verification
+ explicit refusal

O(log m) Merkle
branch
(~0.4–1.5KB
typical)

Merkle  verify:  d
hashes  (e.g.,  13
hashes)

Archival
operators
(Pillars/Nodes)
serve proofs

Bitcoin
(BIP37)

SPV

Header
chain
Merkle inclusion

+

O(log  n)  branch
(~0.3–1KB)

Few–tens
hashes

of

Ethereum
Portal
(state/light
data)

Gossip/DHT-style
retrieval;  state  proofs
vary

Variable
(depends
proof type)

on

Variable
higher
pure Merkle)

(often
than

Full nodes serve
data
(often
altruistic)

DHT
participants;
incentives
evolving

Mina

Recursive
succinct chain

proof

/

Succinct  proof
elements  (order
of  KB);  chain
state ~22KB

SNARK
verification (imp
lementation-dep
endent)

Provers  funded
by
protocol
rewards

zkSync Lite

Validity  proof  posted
to Ethereum L1

SNARK
posted
batch
depends
system)

proof
per
(size
on

checks
inclusion;
verify

Client
L1
proof
done on L1

Ethereum
calldata
contract
availability

/
state

Genesis
trust  root
+  header
chain  +
policy
window

Genesis
block  +
PoW
chain

Often
relies  on
checkpoi
/
nting
weak  sub
jectivity

Genesis
proof + S
NARK-ve
rifiable
state

L1  smart
contract
security

15

Zenon Greenpaper Series

Trade-offs:  Zenon  SPV’s  advantage  is  explicit  refusal  semantics  and
minimal  cryptographic  complexity  (Merkle-style  proofs)  relative  to
recursive-proof  systems.  A  key  disadvantage  is  that  data  availability
depends on economically motivated proof serving, not a protocol-enforced
DA  layer  like  Ethereum  calldata;  this  pushes  design  attention  to
incentives, caching, and refusal UX.

Consistency check: This revision removes unrealistic Merkle depths (e.g., d=30)
from  worked  examples,  uses  consistent  units  (B/KB/GB),  and  standardizes
subscripts for σ

 throughout.

, σ

, σ

H

B

π

16


