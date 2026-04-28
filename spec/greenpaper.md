| Zenon                | Greenpaper |              | Series |     |
| -------------------- | ---------- | ------------ | ------ | --- |
| A Verification-First |            | Architecture |        | for |
| Dual-Ledger          |            | Systems      |        |     |
Status: Community-authored greenpaper (non-normative, non-official)

ZenonGreenpaperSeries
Abstract
This paper presents a unified architecture for resource-bounded verification in dual-
ledger distributed systems. Unlike traditional blockchains, which treat verification as
a byproduct of execution, this design elevates verification to a foundational principle.
Execution itself is constrained to remain verifiable under explicitly declared resource
limits.
The architecture separates parallel execution from sequential commitment ordering
through three tightly integrated pillars:
1. Bounded Verification – Verification under explicit resource constraints, an-
chored to genesis trust roots with adaptive retention.
2. Proof-Native Applications (zApps) – Applications where correctness is estab-
lished via cryptographic proofs rather than execution replay.
3. Composable External Verification (CEV) – Trustless validation of external
facts (e.g., Bitcoin) without relying on intermediaries.
Operating under strict constraints–𝑂(𝑁) storage for 𝑁 Momentum block headers,
𝑂(log𝑚) commitment inclusion proof size (Merkle branch) for a commitment under 𝑟
𝐶
(where 𝑚 is commitments per Momentum block, per Definition 2.4.1), and browser-
native computation–the system enables independent verification even by lightweight
clients. Participants can verify correctness without continuous connectivity or global
state reconstruction.
! " # $ % & ’ ( ) # * + ( , - $ - , . ’ # - # & * . ) / ) & 0 1 0 " . # * 2 , # & , # - # ( $ 3 + ( , # 4 0 . - # & * # $ 4 & 5 * ’ . - # & * . ) 6 ( 7 ( 0 5 8
- # & * # $ $ ( 0 & * ’ . , 9 : ; . 0 " + ( , # 4 ( , & 2 ( , . - ( $ < # - " # * ’ ( 0 ) . , ( ’ , ( $ & 5 , 0 ( . * ’ - , 5 $ - / & 5 * ’ . , # ( $
. * ’ 0 . * " & * ( $ - ) 9 , ( 4 5 $ ( = 5 ( , # ( $ ( 7 0 ( ( ’ # * > - " ( % : ! " # $ 2 , # * 0 # 2 ) ( ? ! " # $ % & ’ & % ( ) ! ! " ( * +
, " % % ’ ( 4 * ( $ . * ( < 2 . , . ’ # > % 4 & , ’ # $ - , # / 5 - ( ’ $ 9 $ - ( % $ / 5 # ) - 4 & , , ( $ & 5 , 0 ( 8 0 & * $ - , . # * ( ’
, ( . ) # - 9 :
1. Introduction
1

ZenonGreenpaperSeries
| 1.1 | The | Verification-Execution |     |     |     | Tension |     |     |
| --- | --- | ---------------------- | --- | --- | --- | ------- | --- | --- |
In most blockchains, verification equals replay. To verify a transaction, a node must
re-execute the computation that produced it. As transaction volume and applica-
tion complexity increase, this equivalence creates an unavoidable scaling problem:
| verifiers |     | must | match | the | resource | profile | of  | executors. |
| --------- | --- | ---- | ----- | --- | -------- | ------- | --- | ---------- |
This model excludes lightweight participants–browsers, mobile devices, intermittently
connected nodes–from independent validation. Systems optimized for throughput
demandtrustedintermediaries;systemsoptimizedforverificationlimitexpressiveness.
As state grows into hundreds of gigabytes and execution environments evolve, this
| tension |      | increasingly    |     | favors | centralized | infrastructure.       |     |     |
| ------- | ---- | --------------- | --- | ------ | ----------- | --------------------- | --- | --- |
| 1.2     | From | Execution-First |     |        |             | to Verification-First |     |     |
This paper proposes an alternative: a verification-first architecture.
Instead of adapting verification to keep pace with execution, we design execution to
| remain |     | verifiable. | The | key question |     | becomes: |     |     |
| ------ | --- | ----------- | --- | ------------ | --- | -------- | --- | --- |
“What forms of execution can remain verifiable under explicit resource bounds?”
The answer lies in a dual-ledger design separating two concerns:
• Account-chain layer (execution): Each account maintains its own append-
only ledger of state transitions, enabling parallel execution without coordination
bottlenecks.
• Momentum chain layer (commitment ordering): A global sequential ledger
that records cryptographic digests (commitments) of account-chain state transi-
|     | tions, | providing |     | temporal | ordering | and | global | anchoring. |
| --- | ------ | --------- | --- | -------- | -------- | --- | ------ | ---------- |
This separation allows accounts to process transactions independently while main-
taining a verifiable global order. Verifiers only track the accounts they care about–
anchoring them to the global Momentum chain for trust-minimized synchronization.
| Three |     | architectural |     | pillars emerge |     | from this | separation: |     |
| ----- | --- | ------------- | --- | -------------- | --- | --------- | ----------- | --- |
1. Bounded Verification (§2) – Verification with explicit limits on storage, band-
|     | width, | and | computation. |     |     |     |     |     |
| --- | ------ | --- | ------------ | --- | --- | --- | --- | --- |
2. Proof-Native Applications (§3) – Applications where correctness is proven, not
replayed.
2

ZenonGreenpaperSeries
3. Composable External Verification (§4) – Verification of external facts using
|      | cryptographic |            |     | proofs     | instead | of trusted | intermediaries. |
| ---- | ------------- | ---------- | --- | ---------- | ------- | ---------- | --------------- |
| 1.3  | Architectural |            |     | Principles |         |            |                 |
| Four | core          | principles |     | govern     | the     | system:    |                 |
1. Verification as Foundation: Execution exists to produce verifiable state tran-
sitions. Computations that cannot be efficiently verified are architecturally ex-
cluded.
2. Explicit Resource Bounds: Every verification operation declares its storage
(𝑆), bandwidth (𝐵), and computation (𝐶) bounds upfront. Verifiers refuse queries
|     | exceeding |     | these | limits–there |     | are no “best | effort” fallbacks. |
| --- | --------- | --- | ----- | ------------ | --- | ------------ | ------------------ |
3. Genesis Anchoring: Trust roots are embedded at genesis. Any verifier, even
after long offline periods, can resynchronize by following cryptographic commit-
|     | ment | chains |     | without | social | coordination. |     |
| --- | ---- | ------ | --- | ------- | ------ | ------------- | --- |
4. Honest Refusal: When a verifier cannot cryptographically prove correctness
within its bounds, it refuses instead of trusting. Refusal is explicit, deterministic,
and surfaced to users as a correctness guarantee, not a failure.
| 1.4 | What |     | This | Architecture |     | Enables |     |
| --- | ---- | --- | ---- | ------------ | --- | ------- | --- |
By combining dual-ledger separation, bounded verification, proof-native applications,
and external verification, this architecture achieves properties rarely found together:
• Browser-Native Verification: Lightweight clients verify state transitions di-
|     | rectly |     | via cryptographic |     |     | proofs. |     |
| --- | ------ | --- | ----------------- | --- | --- | ------- | --- |
• Long-Offline Recovery: Clients resynchronize by following commitment chains
from their last verified header (or an optional locally stored checkpoint)–no social
|     | checkpoints |     |     | required. |     |     |     |
| --- | ----------- | --- | --- | --------- | --- | --- | --- |
• Cross-Chain Validation: Bitcointransactionscanbeverifiedtrustlesslythrough
|     | SPV-style |     | proofs. |     |     |     |     |
| --- | --------- | --- | ------- | --- | --- | --- | --- |
• Proof-Carried Execution: Applications execute off-chain and submit proofs
|     | verifiable |     | in  | constant | time | on constrained | devices. |
| --- | ---------- | --- | --- | -------- | ---- | -------------- | -------- |
These capabilities allow secure participation even under intermittent connectivity and
| limited |     | storage. |     |     |     |     |     |
| ------- | --- | -------- | --- | --- | --- | --- | --- |
3

ZenonGreenpaperSeries
| 1.5 | What | This | Architecture |     |     | Does | Not | Provide |     |
| --- | ---- | ---- | ------------ | --- | --- | ---- | --- | ------- | --- |
To preserve bounded, cryptographic verification, several properties are explicitly
sacrificed:
• No Global Atomic Transactions: Cross-account operations are asynchronous;
|     | atomicity |     | across | arbitrary | accounts |     | is not | guaranteed. |     |
| --- | --------- | --- | ------ | --------- | -------- | --- | ------ | ----------- | --- |
• No Unbounded Compositional Verification: Verifiersdeclarefinitescope(e.g.,
|     | “last | 1000 | commitments”) |     | and | refuse | queries | beyond | it. |
| --- | ----- | ---- | ------------- | --- | --- | ------ | ------- | ------ | --- |
• No Universal Liveness Under Partition: Offline verifiers cannot validate new
|     | commitments |     | until | reconnection. |     |     |     |     |     |
| --- | ----------- | --- | ----- | ------------- | --- | --- | --- | --- | --- |
• No Censorship Resistance for Proof Distribution: While commitment order-
ing is censorship-resistant, proof distribution depends on off-chain networks that
|     | may | selectively |     | withhold | data. |     |     |     |     |
| --- | --- | ----------- | --- | -------- | ----- | --- | --- | --- | --- |
These are not flaws but formalized trade-offs. They define the precise boundaries of
| verifiability |     | under | constrained |     | resources. |     |     |     |     |
| ------------- | --- | ----- | ----------- | --- | ---------- | --- | --- | --- | --- |
1.6 Roadmap
| The | remainder |     | of this | paper | proceeds |     | as follows: |     |     |
| --- | --------- | --- | ------- | ----- | -------- | --- | ----------- | --- | --- |
• Section 2: Formalizes bounded verification–defining commitment chains, trust
|     | roots, | predicates, |     | refusal | semantics, |     | and | retention | policies. |
| --- | ------ | ----------- | --- | ------- | ---------- | --- | --- | --------- | --------- |
• Section 3: Introduces proof-native applications (zApps), where correctness is
|     | cryptographically |     |     | attested. |     |     |     |     |     |
| --- | ----------------- | --- | --- | --------- | --- | --- | --- | --- | --- |
• Section 4: Extends verification to external systems (notably Bitcoin) through
|     | composable |     | external |     | verification |     | (CEV). |     |     |
| --- | ---------- | --- | -------- | --- | ------------ | --- | ------ | --- | --- |
• Section 5: Demonstrates how the three pillars integrate coherently.
|     | • Sections |     | 6-7: | Discuss | related | work | and | future | directions. |
| --- | ---------- | --- | ---- | ------- | ------- | ---- | --- | ------ | ----------- |
• Section 8: Concludes with the implications of verification-first architecture for
|     | distributed |     | systems. |     |     |     |     |     |     |
| --- | ----------- | --- | -------- | --- | --- | --- | --- | --- | --- |
4

ZenonGreenpaperSeries
| 2. Pillar | I:  | Bounded |     | Verification |
| --------- | --- | ------- | --- | ------------ |
Bounded Verification is the foundation of this entire architecture. It defines how
participants can independently validate state transitions within explicit, declared
| resource | constraints. |     |     |     |
| -------- | ------------ | --- | --- | --- |
This section introduces the system model (dual-ledger structure and commitment
chains) and then layers formal guarantees: resource bounds, trust assumptions,
verification predicates, refusal semantics, and adaptive retention.
| 2.1 System |     | Model |     |     |
| ---------- | --- | ----- | --- | --- |
The system comprises two complementary ledger types, each with distinct roles:
• Account-chains (𝐴): Per-account append-only logs of local state transitions.
Each account maintains its own ledger, allowing parallel execution without global
coordination.
• Momentum chain (𝑀): A global sequential ledger that orders commitments–
cryptographic digests of account-chain states–within bounded time windows. It
provides temporal anchoring and cross-account visibility without requiring full
replay.
This dual-ledger separation enables verifiers to follow only the accounts they care
about while maintaining cryptographic linkage to the global order.
| 2.1.1 Account-Chain |     |                | Structure |          |
| ------------------- | --- | -------------- | --------- | -------- |
| Definition          | 2.1 | (Account-Chain |           | Block):  |
| An account-chain    |     | block          | 𝐵 is      | a tuple: |
𝐴
|     |     |     |     | 𝐵 = (ℎ ,𝑇𝑋,𝜋,metadata) |
| --- | --- | --- | --- | ---------------------- |
|     |     |     |     | 𝐴 prev                 |
where: * ℎ = 𝐻(previous block) links to the prior block, * 𝑇𝑋 is an ordered list
prev
of transactions modifying the account’s state, * 𝜋 is a cryptographic proof that 𝑇𝑋
representsavalidstatetransition, and*metadataincludesauxiliarydata(timestamps,
| signatures, | app-specific |     | fields). |     |
| ----------- | ------------ | --- | -------- | --- |
5

ZenonGreenpaperSeries
| Definition       |     | 2.2 | (Account-Chain): |            |     |            |           |     |     |
| ---------------- | --- | --- | ---------------- | ---------- | --- | ---------- | --------- | --- | --- |
| An account-chain |     |     | 𝐴 is             | a sequence |     | of blocks: |           |     |     |
|                  |     |     |                  |            |     | 𝐴 = ⟨𝐵     | ,𝐵 ,…,𝐵 ⟩ |     |     |
|                  |     |     |                  |            |     | 0          | 1 𝑘       |     |     |
where: * 𝐵 is the genesis block (ℎ = 0), and * for all 𝑖 > 0: 𝐵 .ℎ = 𝐻(𝐵 ).
|     | 0   |     |     |     |     | prev |     | 𝑖 prev | 𝑖−1 |
| --- | --- | --- | --- | --- | --- | ---- | --- | ------ | --- |
Eachblockmustincludeavalidstate-transitionproof. Account-chainsgrowasynchronously–
some accounts may produce thousands of blocks daily, others remain dormant for
weeks.
| 2.1.2      | Momentum |       |           | Chain | Structure |     |     |     |     |
| ---------- | -------- | ----- | --------- | ----- | --------- | --- | --- | --- | --- |
| Definition |          | 2.3   | (Momentum |       | Block):   |     |     |     |     |
| A Momentum |          | block | 𝑀         | is    | a tuple:  |     |     |     |     |
𝑖
|     |     |     |     |     | 𝑀   | = (ℎ ,𝑟 | ,𝑡,metadata) |     |     |
| --- | --- | --- | --- | --- | --- | ------- | ------------ | --- | --- |
|     |     |     |     |     |     | 𝑖 prev  | 𝐶            |     |     |
where: * ℎ = 𝐻(𝑀 ) links to the previous Momentum block, * 𝑟 is the commitment
|     | prev |     | 𝑖−1 |     |     |     |     | 𝐶   |     |
| --- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
root (Merkle root over the set 𝐶 = {𝑐 ,𝑐 ,…,𝑐 } of account-chain commitments), * 𝑡 is
|     |     |     |     |     |     | 1 2 | 𝑚   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
theconsensustimestamp,and*metadataincludesconsensus-specificdata(signatures,
| nonce,     | etc.).     |     |                |      |          |              |          |     |     |
| ---------- | ---------- | --- | -------------- | ---- | -------- | ------------ | -------- | --- | --- |
| Definition |            | 2.4 | (Account-Chain |      |          | Commitment): |          |     |     |
| Each       | commitment |     | 𝑐 ∈            | 𝐶 is | a tuple: |              |          |     |     |
|            |            |     |                |      | 𝑐        | = (addr,ℎ    | ,height) |     |     |
snapshot
where: * addr = account address, * ℎ = hash of account state at that height, *
snapshot
| height     | = account-chain |       |             | height |     | when committed. |         |     |     |
| ---------- | --------------- | ----- | ----------- | ------ | --- | --------------- | ------- | --- | --- |
| Definition |                 | 2.4.1 | (Commitment |        |     | Membership      | Proof): |     |     |
A commitment membership proof 𝑤 for commitment 𝑐 ∈ 𝐶 is a Merkle branch of size
𝑂(log𝑚) hashes that proves 𝑐 was included in computing 𝑟 , where 𝑚 = |𝐶| is the
𝐶
| number     | of  | commitments |             |     | in that | Momentum           | block. |     |     |
| ---------- | --- | ----------- | ----------- | --- | ------- | ------------------ | ------ | --- | --- |
| Definition |     | 2.4.2       | (Commitment |     |         | Root Determinism): |        |     |     |
The commitment root 𝑟 is computed deterministically: commitments in 𝐶 are canoni-
𝐶
callyordered(e.g.,lexicographicallybyaddress,thenbyheight)anddomain-separated
before Merkle root computation. This ensures all honest nodes compute identical 𝑟
𝐶
| from the | same | commitment |     |     | set. |     |     |     |     |
| -------- | ---- | ---------- | --- | --- | ---- | --- | --- | --- | --- |
6

ZenonGreenpaperSeries
| Definition | 2.5 (Momentum |     | Chain): |              |     |     |
| ---------- | ------------- | --- | ------- | ------------ | --- | --- |
|            |               |     | 𝑀       | = ⟨𝑀 ,𝑀 ,…,𝑀 | ⟩   |     |
|            |               |     |         | 0 1          | 𝑁   |     |
where 𝑀 is the genesis Momentum block, each 𝑀 links cryptographically to 𝑀 , and
|          | 0           |               |     |     | 𝑖   | 𝑖−1 |
| -------- | ----------- | ------------- | --- | --- | --- | --- |
| 𝑁 is the | current     | chain height. |     |     |     |     |
| 2.1.3    | Operational | Semantics     |     |     |     |     |
1. Execution Phase: Accounts process transactions independently, producing
|     | account-chain | blocks | containing | validity | proofs. |     |
| --- | ------------- | ------ | ---------- | -------- | ------- | --- |
2. Commitment Phase: Periodically (e.g., every 10 seconds), a new Momentum
blockispublishedcontainingacommitmentroot𝑟 overallactiveaccounts’latest
𝐶
states.
| 3.  | Verification | Phase: |     |     |     |     |
| --- | ------------ | ------ | --- | --- | --- | --- |
• A verifier locates the Momentum block 𝑀 corresponding to time 𝑇.
𝑖
• It validates the chain from 𝑀 (or its last known checkpoint) to 𝑀 .
|     |     |     |     | 0   |     | 𝑖   |
| --- | --- | --- | --- | --- | --- | --- |
• It requests the commitment 𝑐 for account 𝐴 and its membership proof 𝑤.
|     | • It verifies | 𝑤 proves | 𝑐 ∈ 𝑟 . |     |     |     |
| --- | ------------- | -------- | ------- | --- | --- | --- |
𝐶
𝐴
• It downloads the necessary account-chain blocks for and checks them
|     | against | the commitment. |     |     |     |     |
| --- | ------- | --------------- | --- | --- | --- | --- |
Critically, verifiers need only store Momentum headers–𝑂(𝑁) headers for 𝑁 Momen-
tum blocks (equivalently 𝑂(𝑁 ⋅𝜎 ) bytes where 𝜎 is the Momentum-header size (in
|             |            |          | 𝐻              |     | 𝐻          |     |
| ----------- | ---------- | -------- | -------------- | --- | ---------- | --- |
| bytes))–and | validate   | selected | account-chains |     | on demand. |     |
| 2.2         | Commitment | Chain    | Properties     |     |            |     |
The Momentum chain satisfies standard blockchain properties under explicit bounds.
| Property | 2.1 (Commitment |     | Finality): |     |     |     |
| -------- | --------------- | --- | ---------- | --- | --- | --- |
Once a commitment 𝑐 appears in 𝑀 and gains 𝑘 confirmations, reversal is bounded by
𝑖
| two distinct | guarantees: |     |     |     |     |     |
| ------------ | ----------- | --- | --- | --- | --- | --- |
• Hash-chain tamper evidence: Collision resistance of 𝐻 ensures that any mod-
ification to a Momentum block 𝑀 changes its hash, breaking the link 𝐻(𝑀 ) =
|     |     |     |     | 𝑗   |     | 𝑗   |
| --- | --- | --- | --- | --- | --- | --- |
ℎ (𝑀 ). An adversary can compute new hashes for an alternative history,
|     | prev 𝑗+1 |     |     |     |     |     |
| --- | -------- | --- | --- | --- | --- | --- |
but cannot make that alternative history match the already-committed hashes
7

ZenonGreenpaperSeries
without finding a collision/second-preimage, which is computationally infeasible
| under |     | standard |     | assumptions. |     |     |     |
| ----- | --- | -------- | --- | ------------ | --- | --- | --- |
• Consensus finality (canonization): The consensus mechanism bounds accep-
tance of alternative histories deeper than 𝑘. The probability of a chain reorgani-
zation beyond depth 𝑘 is Pr[reorg ≥ 𝑘] ≤ 𝑓 (𝑘), where 𝑓 depends on
consensus consensus
the consensus model (e.g., exponentially decreasing in 𝑘 for PoW under honest-
| majority |     | assumptions). |     |     |     |     |     |
| -------- | --- | ------------- | --- | --- | --- | --- | --- |
Hash chaining makes tampering detectable; consensus determines which detected
| history  | becomes |           | canonical. |            |         |            |             |
| -------- | ------- | --------- | ---------- | ---------- | ------- | ---------- | ----------- |
| Property | 2.2     | (Temporal |            | Ordering): |         |            |             |
| If 𝑐 ∈   | 𝑀 and   | 𝑐         | ∈ 𝑀 with   | 𝑖 <        | 𝑗, then | 𝑐 precedes | 𝑐 globally. |
| 1        | 𝑖       | 2         | 𝑗          |            |         | 1          | 2           |
| Property | 2.3     | (Bounded  |            | Storage):  |         |            |             |
Verifiers storing only Momentum headers require 𝑂(𝑁) storage in headers, where
𝑁 is the number of Momentum blocks. Checkpointing or sampling techniques can
reduce storage requirements, though these trade complete cryptographic verification
for additional trust assumptions or probabilistic security guarantees.
These properties enable verifiers to validate commitment chains instead of replaying
execution.
| 2.3 Trust |     | Model |     | and Security |     | Assumptions |     |
| --------- | --- | ----- | --- | ------------ | --- | ----------- | --- |
Before defining verification predicates, we clarify what the system assumes.
| 2.3.1      | Cryptographic |     |            | Assumptions |              |     |     |
| ---------- | ------------- | --- | ---------- | ----------- | ------------ | --- | --- |
| Assumption |               | 2.1 | (Collision |             | Resistance): |     |     |
The hash function 𝐻 (e.g., SHA-256) is collision-resistant: finding distinct 𝑥,𝑥′ such
𝐻(𝑥′)
| that 𝐻(𝑥)  | =   |     | is computationally |        |             | infeasible. |     |
| ---------- | --- | --- | ------------------ | ------ | ----------- | ----------- | --- |
| Assumption |     | 2.2 | (Proof             | System | Soundness): |             |     |
Proof systems (e.g., signatures, zk-SNARKs) are sound: producing a valid proof for a
| false statement |         |     | is computationally |     |                | infeasible. |     |
| --------------- | ------- | --- | ------------------ | --- | -------------- | ----------- | --- |
| 2.3.2           | Network |     | Model              |     |                |             |     |
| Assumption      |         | 2.3 | (Eventual          |     | Connectivity): |             |     |
Verifiers can intermittently synchronize with the Momentum chain.
8

ZenonGreenpaperSeries
Assumption 2.4 (No Network-Level Censorship of Momentum Blocks):
| At least one | honest | source | can provide | Momentum | headers. |
| ------------ | ------ | ------ | ----------- | -------- | -------- |
Non-Assumption: Account-chain blocks or proofs may be unavailable. If so, the
verifier returns REFUSED_DATA_UNAVAILABLE instead of trusting.
| 2.3.3 Consensus |     | and       | Liveness    |     |     |
| --------------- | --- | --------- | ----------- | --- | --- |
| Assumption      | 2.5 | (Momentum | Consensus): |     |     |
The consensus mechanism guarantees: * Safety: Honest participants agree on the
chain with high probability. * Liveness: New Momentum blocks appear within a
bounded interval Δ (an upper bound on the Momentum block interval).
The architecture is consensus-agnostic (PoW, PoS, BFT, etc.). If uncertainty exists due
to forks, verifiers follow their preferred chain or refuse queries.
| 2.3.4 Adversarial |     | Model |     |     |     |
| ----------------- | --- | ----- | --- | --- | --- |
Adversary capabilities: * Can withhold data (account-chain blocks or proofs) * Can
attempt invalid block creation (fails verification) * Can partition network or launch
DoS attacks
Adversary limitations: * Cannot break collision resistance or forge proofs * Cannot
rewrite Momentum history beyond 𝑘 confirmations (subject to consensus finality
assumptions) * Cannot force verifiers to accept unverified claims
| An adversary   | may | make  | verification | impossible–but | not false. |
| -------------- | --- | ----- | ------------ | -------------- | ---------- |
| 2.3.5 Explicit |     | Trust | Boundaries   |                |            |
Eliminated trust categories: * RPC providers: Verifiers independently validate all
claims. * Sequencers and oracles: Proofs replace trust. * Execution environments:
| Only cryptographic |     | attestations | matter. |     |     |
| ------------------ | --- | ------------ | ------- | --- | --- |
Minimal trust remains in: * Consensus liveness and header availability.
Explicit non-guarantees: * Proof distribution censorship and liveness under parti-
tion.
All boundaries are declared so participants make informed trust decisions.
9

ZenonGreenpaperSeries
| 2.4 Formal |     | Impossibility: |     |     | Unbounded |     | Composition |     | vs Bounded |
| ---------- | --- | -------------- | --- | --- | --------- | --- | ----------- | --- | ---------- |
Verification
| Theorem | 2.1 | (Composition-Verification |     |     |     | Impossibility): |     |     |     |
| ------- | --- | ------------------------- | --- | --- | --- | --------------- | --- | --- | --- |
For a verifier 𝑉 with resource bound 𝑅, no protocol can simultaneously: 1. Validate
arbitrary compositional depth of dependent claims, 2. Guarantee correctness under
| adversarial |     | data unavailability, |     | and | 3. Stay | within | 𝑅.  |     |     |
| ----------- | --- | -------------------- | --- | --- | ------- | ------ | --- | --- | --- |
Proof Sketch. A chain of dependent claims 𝐶 → 𝐶 → … → 𝐶 requires recursive
|     |     |     |     |     |     | 1   | 2   | 𝑘   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
verification. Foradversariallychosen𝑘,verifier𝑉musteitherstoreallproofs(violating
storagebounds),re-verifyrecursively(violatingcomputationbounds),ortrustexternal
sources (violating security). Therefore, at least one of the three requirements must be
violated.
| Corollary | 2.1: |     |     |     |     |     |     |     |     |
| --------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- |
Bounded verification systems must either (1) refuse queries beyond declared scope or
(2) accept trusted attestations. This architecture chooses (1): honest refusal.
Operational implication: A browser verifier may validate only the last two weeks
of data. Older queries return REFUSED_OUT_OF_SCOPE instead of silently trusting an
RPC.
| 2.5 Resource |     | Bounds |     |     |     |     |     |     |     |
| ------------ | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
Bounded verification explicitly quantifies the three fundamental limits under which a
| verifier   | operates: |           |       |     |         |     |     |     |     |
| ---------- | --------- | --------- | ----- | --- | ------- | --- | --- | --- | --- |
| Definition | 2.6       | (Resource | Bound |     | Tuple): |     |     |     |     |
Each verifier 𝑉 declares a resource bound 𝑅 = (𝑆 ,𝐵 ,𝐶 ) where: * 𝑆 = maximum
|     |     |     |     |     |     | 𝑉   | 𝑉   | 𝑉 𝑉 | 𝑉   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
persistent storage (in bytes) available for headers, proofs, and state fragments; * 𝐵 =
𝑉
maximum network bandwidth (in bytes) available per synchronization window; * 𝐶 =
𝑉
maximum local computation budget (in operations or time) per verification session.
| A verifier | is  | correctly | bounded | if  | it never | exceeds | 𝑅   | .   |     |
| ---------- | --- | --------- | ------- | --- | -------- | ------- | --- | --- | --- |
𝑉
Bounded verification means no assumption of global completeness–verifiers validate
| as much | as  | their bounds | permit | and | refuse | anything | beyond. |     |     |
| ------- | --- | ------------ | ------ | --- | ------ | -------- | ------- | --- | --- |
10

ZenonGreenpaperSeries
| 2.5.1      | Bounded |          | Execution |             |     |     |     |     |     |     |
| ---------- | ------- | -------- | --------- | ----------- | --- | --- | --- | --- | --- | --- |
| Definition | 2.7     | (Bounded |           | Execution): |     |     |     |     |     |     |
An execution trace 𝐸 is verifiable under 𝑅 if and only if there exists a proof 𝜋 such
𝑉 𝐸
that:
|        |           |                 | Verify(𝜋 |     | ) = TRUE | and   | Cost |        | (𝜋 ) | ≤ 𝐶 |
| ------ | --------- | --------------- | -------- | --- | -------- | ----- | ---- | ------ | ---- | --- |
|        |           |                 |          | 𝐸   |          |       |      | verify | 𝐸    | 𝑉   |
| and |𝜋 | | ≤ 𝑆 and | BytesFetched(𝐸) |          |     |          | ≤ 𝐵 . |      |        |      |     |
|        | 𝐸 𝑉       |                 |          |     |          | 𝑉     |      |        |      |     |
In other words, execution is architecturally restricted to remain within declared
| verification | budgets.   |         |           |          |            |         |     |                |     |     |
| ------------ | ---------- | ------- | --------- | -------- | ---------- | ------- | --- | -------------- | --- | --- |
| 2.5.2        | Bounded    |         | State     |          |            |         |     |                |     |     |
| State        | is bounded | through |           | adaptive |            | pruning | and | checkpointing. |     |     |
| Definition   | 2.8        | (State  | Retention |          | Function): |         |     |                |     |     |
Let 𝜌(𝑡) denote the retention policy governing stored data age. For each verifier 𝑉,
| the expected | storage |     | footprint |     | satisfies: |     |     |     |     |     |
| ------------ | ------- | --- | --------- | --- | ---------- | --- | --- | --- | --- | --- |
∞
|     |     |     | 𝔼[StoredBytes |     |     | ] = ∫ | 𝑔 (𝑡)⋅𝜌(𝑡)𝑑𝑡 |     | ≤   | 𝑆   |
| --- | --- | --- | ------------- | --- | --- | ----- | ------------ | --- | --- | --- |
|     |     |     |               |     |     | 𝑉     | 𝑉            |     |     | 𝑉   |
0
where 𝑔 (𝑡) is the storage density function (bytes per unit time) for data of age 𝑡, and
𝑉
| 𝜌(𝑡) ∈ | [0,1] is the | retention |     | probability |     | at age | 𝑡.  |     |     |     |
| ------ | ------------ | --------- | --- | ----------- | --- | ------ | --- | --- | --- | --- |
This formulation ensures finite storage under probabilistic or deterministic pruning
policies while maintaining verifiable history within the retention window.
| 2.6 Verification |     |     | Predicates |     |     |     |     |     |     |     |
| ---------------- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- | --- |
Every verification operation reduces to a logical predicate over cryptographic data. A
predicate evaluates to true, false, or refused depending on available information.
| Definition | 2.9 | (Verification |         | Predicate): |     |                      |     |     |     |     |
| ---------- | --- | ------------- | ------- | ----------- | --- | -------------------- | --- | --- | --- | --- |
|            |     |               | 𝑃(𝑥,𝐷,𝑅 |             | ) → | {TRUE,FALSE,REFUSED} |     |     |     |     |
𝑉
where: * 𝑥 = claim being verified (e.g., “Account A sent 5 ZNN to B”); * 𝐷 = set of data
available to the verifier; * 𝑅 = verifier’s declared resource bounds.
𝑉
11

ZenonGreenpaperSeries
| 2.6.1 | Evaluation |     | Semantics |     |     |     |     |     |
| ----- | ---------- | --- | --------- | --- | --- | --- | --- | --- |
If 𝐷 contains all required proof objects and their verification fits within 𝑅 , then: *
𝑉
return TRUE if the proofs validate the claim, * return FALSE if the provided proofs
cryptographically contradict the claim (e.g., signature/proof verification fails, Merkle
| root mismatch, |     | invalid |     | header | linkage). |     |     |     |
| -------------- | --- | ------- | --- | ------ | --------- | --- | --- | --- |
If required data is unavailable, out of scope, or verification would exceed 𝑅 , return
𝑉
REFUSED.
| Property | 2.4 | (Total | Safety |     | Under | Refusal): |     |     |
| -------- | --- | ------ | ------ | --- | ----- | --------- | --- | --- |
A refusal can never produce a false positive. Formally, if 𝑃(𝑥,𝐷,𝑅 ) = REFUSED, then
𝑉
| 𝑥 is neither | accepted                   |     | nor         | rejected. |     |            |     |     |
| ------------ | -------------------------- | --- | ----------- | --------- | --- | ---------- | --- | --- |
| This is      | the refusal-as-correctness |     |             |           |     | principle. |     |     |
| 2.6.2        | Predicate                  |     | Composition |           |     |            |     |     |
Let 𝑃 ,𝑃 ,…,𝑃 be independent predicates. Composition is defined as:
| 1            | 2            | 𝑘         |               |      |       |                |              |       |
| ------------ | ------------ | --------- | ------------- | ---- | ----- | -------------- | ------------ | ----- |
|              |              |           |               | 𝑃    | (𝑥)   | = 𝑃 (𝑥)∧𝑃      | (𝑥)∧…∧𝑃      | (𝑥)   |
|              |              |           |               |      | all   | 1              | 2            | 𝑘     |
| Rule         | 2.1 (Refusal |           | Propagation): |      |       |                |              |       |
| If any       | 𝑃 (𝑥) =      | REFUSED,  |               | then | 𝑃     | (𝑥) = REFUSED. |              |       |
|              | 𝑖            |           |               |      | all   |                |              |       |
| This ensures |              | verifiers | never         |      | infer | truth          | from partial | data. |
| 2.7 Refusal  |              | Semantics |               |      |       |                |              |       |
Refusal is an explicit and deterministic outcome, not an error. It preserves soundness
| by limiting | verification |     |          | to provable |     | claims. |     |     |
| ----------- | ------------ | --- | -------- | ----------- | --- | ------- | --- | --- |
| Definition  | 2.10         |     | (Refusal | Code        |     | Set):   |     |     |
ℛ = {REFUSED_OUT_OF_SCOPE,REFUSED_DATA_UNAVAILABLE,REFUSED_COST_EXCEEDED}
Each refusal code maps to a distinct failure mode: * OUT_OF_SCOPE: The requested
claim extends beyond verifier’s declared history window. * DATA_UNAVAILABLE:
Proofs missing from the network. * COST_EXCEEDED: Computation or bandwidth
| would | exceed | 𝑅 . |     |     |     |     |     |     |
| ----- | ------ | --- | --- | --- | --- | --- | --- | --- |
𝑉
| Refusals | propagate |     | upward |     | through | compositional |     | predicates. |
| -------- | --------- | --- | ------ | --- | ------- | ------------- | --- | ----------- |
12

ZenonGreenpaperSeries
| Property | 2.5 | (Refusal | Closure): |     |     |     |     |     |
| -------- | --- | -------- | --------- | --- | --- | --- | --- | --- |
If any subpredicate returns REFUSED, the entire predicate returns REFUSED.
| 2.7.1 | Operational |     | Behavior |     |     |     |     |     |
| ----- | ----------- | --- | -------- | --- | --- | --- | --- | --- |
When a verifier refuses: * It emits a machine-readable refusal code and associated
reason. * It records a refusal witness containing: the last verified header hash, the
identifier of the missing or unverifiable object, and the bound-exceeded code. * User
interfaces display “verification refused” rather than “verification failed.”
This communicates bounded correctness to users and external protocols.
| 2.7.2   | Refusal | Safety   |          |     |     |     |     |     |
| ------- | ------- | -------- | -------- | --- | --- | --- | --- | --- |
| Theorem | 2.2     | (Refusal | Safety): |     |     |     |     |     |
Assuming collision resistance and proof soundness, no adversary can cause a verifier
| to accept | a false | claim | without |     | its | explicit | consent. |     |
| --------- | ------- | ----- | ------- | --- | --- | -------- | -------- | --- |
Proof Sketch. All valid claims must be supported by cryptographic proofs. If proofs
are unavailable, the verifier returns REFUSED. If forged proofs are presented, they
fail verification (by proof soundness). Therefore, the only way a verifier accepts a
| claim is     | if it possesses |           | a   | valid | proof         | that | passes verification. |     |
| ------------ | --------------- | --------- | --- | ----- | ------------- | ---- | -------------------- | --- |
| This means   | verifiers       |           | may | fail  | to answer–but |      | never lie.           |     |
| 2.8 Adaptive |                 | Retention |     |       |               |      |                      |     |
Over time, state and proof data can grow without bound. Adaptive retention provides
| a mathematically |      | bounded   |     | strategy  |     | for data | aging. |     |
| ---------------- | ---- | --------- | --- | --------- | --- | -------- | ------ | --- |
| Definition       | 2.11 | (Adaptive |     | Retention |     | Policy): |        |     |
Each verifier defines a retention policy 𝜌(𝑡) ∈ [0,1] specifying the probability (or
deterministic choice) of retaining data of age 𝑡. Given a storage density function 𝑔 (𝑡)
𝑉
| (bytes | per unit | time), | the | policy | must | satisfy: |     |     |
| ------ | -------- | ------ | --- | ------ | ---- | -------- | --- | --- |
∞
|     |     |     | 𝔼[StoredBytes |     |     | ] = | ∫ 𝑔 (𝑡)⋅𝜌(𝑡)𝑑𝑡 | ≤ 𝑆 |
| --- | --- | --- | ------------- | --- | --- | --- | -------------- | --- |
|     |     |     |               |     |     | 𝑉   | 𝑉              | 𝑉   |
0
with 𝜌(0) = 1 (all fresh data retained) and 𝜌(𝑡) non-increasing.
This guarantees finite storage while retaining recent data at full fidelity.
13

ZenonGreenpaperSeries
Example:
|     |     |     |     | 𝜌(𝑡) | = 𝑒−𝜆𝑡 |     |     |     |     |
| --- | --- | --- | --- | ---- | ------ | --- | --- | --- | --- |
produces exponential decay of retention probability, keeping recent activity fully
| verifiable | while   | bounding       | total            | storage. |     |     |     |     |     |
| ---------- | ------- | -------------- | ---------------- | -------- | --- | --- | --- | --- | --- |
| 2.8.1      | Bounded | Reconstruction |                  |          |     |     |     |     |     |
| Property   | 2.6     | (Bounded       | Reconstruction): |          |     |     |     |     |     |
Any verifier can reconstruct a provable view of the system up to time 𝑡−Δ, where Δ is
| its retention | window. |     |     |     |     |     |     |     |     |
| ------------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
Offline clients can resynchronize by re-downloading Momentum headers and request-
| ing missing | proofs | within   | Δ.  |           |               |     |     |     |     |
| ----------- | ------ | -------- | --- | --------- | ------------- | --- | --- | --- | --- |
| 2.9 Worked  |        | Example: |     | Verifying | a Transaction |     |     |     |     |
Let’s illustrate bounded verification through a single transaction example.
Scenario: A lightweight browser client wants to verify that “Account A sent 5 ZNN to
| B at height | ℎ.”    |          |     |         |     |     |     |     |     |
| ----------- | ------ | -------- | --- | ------- | --- | --- | --- | --- | --- |
| Step 1:     | Obtain | Momentum |     | Headers |     |     |     |     |     |
The client downloads the sequence of Momentum headers from 𝑀 to 𝑀 . This cost is
0 𝑖
| 𝑂(𝑁) headers |     | and fits | within | 𝑆 . |     |     |     |     |     |
| ------------ | --- | -------- | ------ | --- | --- | --- | --- | --- | --- |
𝑉
| Step 2: | Locate | Commitment |     |     |     |     |     |     |     |
| ------- | ------ | ---------- | --- | --- | --- | --- | --- | --- | --- |
From 𝑀 , it requests the commitment 𝑐 = (addr = 𝐴,ℎ ,ℎ) and its membership
|     | 𝑖   |     |     |     |     |     | snapshot |     |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | --- |
proof 𝑤.
| Step 3: | Verify | Membership |     |     |     |     |     |     |     |
| ------- | ------ | ---------- | --- | --- | --- | --- | --- | --- | --- |
It verifies that 𝑤 proves 𝑐 is included in 𝑟 (the commitment root in 𝑀 ).
|         |          |         |     |        | 𝐶   |     |     | 𝑖   |     |
| ------- | -------- | ------- | --- | ------ | --- | --- | --- | --- | --- |
| Step 4: | Retrieve | Account |     | Proofs |     |     |     |     |     |
It requests from the network the account-chain segment 𝐵 → 𝐵 and the associated
ℎ−1 ℎ
proof 𝜋.
| Step 5: | Evaluate | Predicate |     |               |     |          |          |     |     |
| ------- | -------- | --------- | --- | ------------- | --- | -------- | -------- | --- | --- |
|         |          | ⎧ ⎪TRUE   |     | if Verify(𝜋,ℎ |     | ) = TRUE | and Cost | (𝜋) | ≤ 𝐶 |
⎪
|         |     | ⎪     |     |           | snapshot          |     |            | verify    | 𝑉   |
| ------- | --- | ----- | --- | --------- | ----------------- | --- | ---------- | --------- | --- |
| 𝑃(𝑥,𝐷,𝑅 |     | ) =   |     |           |                   |     |            |           |     |
|         | 𝑉   | FALSE |     | if proofs | cryptographically |     | contradict | the claim |     |
⎨ ⎪
⎪ ⎪
|     |     | ⎩ REFUSED |     | if 𝜋 missing | or  | cost exceeds | 𝑅   |     |     |
| --- | --- | --------- | --- | ------------ | --- | ------------ | --- | --- | --- |
𝑉
14

ZenonGreenpaperSeries
| Step | 6:  | User | Feedback |     |     |     |     |     |     |     |
| ---- | --- | ---- | -------- | --- | --- | --- | --- | --- | --- | --- |
The client displays: * “Transaction verifiable under current resource limits.”
| or  | * “Verification |     | refused |     | – proof | unavailable.” |     |     |     |     |
| --- | --------------- | --- | ------- | --- | ------- | ------------- | --- | --- | --- | --- |
This example demonstrates bounded correctness: verification is absolute within
| bounds, |     | and         | gracefully | refused      |     | outside | them. |     |     |     |
| ------- | --- | ----------- | ---------- | ------------ | --- | ------- | ----- | --- | --- | --- |
| 2.10    |     | Operational |            | Consequences |     |         |       |     |     |     |
1. Composable Proof Availability: Clients can cache and share proof segments
|     | without |     | needing | trust. |     |     |     |     |     |     |
| --- | ------- | --- | ------- | ------ | --- | --- | --- | --- | --- | --- |
2. Proof Marketplaces: Because proofs are verifiable objects, third parties can
|     | offer | them | for | a fee | without | custody |     | risk. |     |     |
| --- | ----- | ---- | --- | ----- | ------- | ------- | --- | ----- | --- | --- |
3. Lightweight Client Inclusivity: Deviceswithhundredsofmegabytesofstorage
|     | can | still | independently |     | verify |     | activity. |     |     |     |
| --- | --- | ----- | ------------- | --- | ------ | --- | --------- | --- | --- | --- |
4. Data Sovereignty: Verifiers decide their own trust and retention policies.
| 2.11     |     | Summary |     | of Bounded |              |     | Verification |           | Properties    |     |
| -------- | --- | ------- | --- | ---------- | ------------ | --- | ------------ | --------- | ------------- | --- |
| Property |     |         |     |            | Meaning      |     |              |           | Guarantee     |     |
| Refusal  |     | Safety  |     |            | Refusals     |     | cannot       |           | Soundness     |     |
|          |     |         |     |            | produce      |     | false        | positives |               |     |
| Bounded  |     | Storage |     |            | Verification |     |              | state ≤   | 𝑆 Scalability |     |
𝑉
Bounded Computation Each proof verifies in Device compatibility
|     |     |     |     |     | ≤   | 𝐶 steps |     |     |     |     |
| --- | --- | --- | --- | --- | --- | ------- | --- | --- | --- | --- |
𝑉
| Bounded |     | Bandwidth |     |     | Proof |     | fetch | ≤ 𝐵 per | Intermittent | operation |
| ------- | --- | --------- | --- | --- | ----- | --- | ----- | ------- | ------------ | --------- |
𝑉
sync
| Genesis  |     | Anchoring  |     |     | Trust       |     | root exists | forever | Offline recovery |     |
| -------- | --- | ---------- | --- | --- | ----------- | --- | ----------- | ------- | ---------------- | --- |
| Adaptive |     | Retention  |     |     | Finite      |     | storage     | with    | Longevity        |     |
|          |     |            |     |     | progressive |     |             | decay   |                  |     |
| 2.12     |     | Conclusion |     | of  | Pillar      | I   |             |         |                  |     |
Bounded verification redefines validation as a finite, resource-constrained, crypto-
graphically sound process. It replaces the illusion of universal completeness with
15

ZenonGreenpaperSeries
explicitly bounded correctness. Every verifier knows precisely what it can prove, what
| it cannot, | and when | to refuse. |     |     |     |
| ---------- | -------- | ---------- | --- | --- | --- |
This foundation supports the next two pillars: * Proof-Native Applications (zApps)
– applications whose correctness is proven cryptographically, not replayed; and *
Composable External Verification (CEV) – trustless validation of external facts.
| 3. Pillar | II: | Proof-Native | Applications |     | (zApps) |
| --------- | --- | ------------ | ------------ | --- | ------- |
This section describes a proposed extension to the base architecture: proof-native
applications where correctness is established via cryptographic proofs rather than
| execution | replay. |     |     |     |     |
| --------- | ------- | --- | --- | --- | --- |
3.1 Motivation
Traditional smart-contract systems equate verification with re-execution: to confirm
a transaction’s correctness, verifiers must replay every instruction inside a virtual
machine. This ties verification cost to execution complexity–an inherent scalability
bottleneck.
Proof-native applications (zApps) invert that relationship. Rather than replaying
computation, verifiers check succinct proofs that attest a computation’s correctness.
Execution can therefore occur anywhere–off-chain, asynchronously, or on heteroge-
| neous          | hardware–without | compromising | verifiability. |     |     |
| -------------- | ---------------- | ------------ | -------------- | --- | --- |
| 3.2 Definition |                  | of a zApp    |                |     |     |
| Definition     | 3.1 (zApp):      |              |                |     |     |
A zApp is an application that emits, for every state transition, a validity proof
(output,state′)
|     |     | 𝜋 ∶ Compute(input,state) |     | →   |     |
| --- | --- | ------------------------ | --- | --- | --- |
such that
|       |               | Verify(𝜋,input,state,output,state′) |              |         | = TRUE |
| ----- | ------------- | ----------------------------------- | ------------ | ------- | ------ |
| under | the soundness | assumption                          | of its proof | system. |        |
16

ZenonGreenpaperSeries
A zApp is therefore a proof-emitting function with deterministic semantics, not an
| interpreted | program   | requiring       | replay.   |             |     |
| ----------- | --------- | --------------- | --------- | ----------- | --- |
| 3.2.1       | Execution | vs Verification |           | Separation  |     |
| Layer       |           | Role            |           | Cost Domain |     |
| Executor    |           | Runs            | arbitrary | Unbounded   |     |
computation
off-chain
| Verifier |     | Checks | succinct | Bounded | (≤ 𝐶 ) |
| -------- | --- | ------ | -------- | ------- | ------ |
𝑉
|     |     | proof | on-chain | or  |     |
| --- | --- | ----- | -------- | --- | --- |
locally
This separation decouples expressiveness from verification overhead.
| 3.3 Proof | Systems |     |     |     |     |
| --------- | ------- | --- | --- | --- | --- |
zApps may use any sound proof system that satisfies verification constraints. Typical
| examples | include: |     |     |     |     |
| -------- | -------- | --- | --- | --- | --- |
• zk-SNARKs (e.g., Groth16, PLONK): constant-size proofs, fast verification.
• STARKs: transparent, post-quantum-secure proofs; larger but scalable.
| • Bulletproofs: |            | logarithmic     | proof | size, no trusted | setup. |
| --------------- | ---------- | --------------- | ----- | ---------------- | ------ |
| Property        | 3.1 (Proof | Verifiability): |       |                  |        |
Each proof system provides a deterministic verification function
|             |                       |           | Verify(𝜋,𝑥)     | → {0,1}      |     |
| ----------- | --------------------- | --------- | --------------- | ------------ | --- |
| whose       | cost is upper-bounded |           | by a polynomial | in log(|𝑥|). |     |
| 3.3.1       | Proof Object          | Format    |                 |              |     |
| Every proof | object                | includes: |                 |              |     |
𝜋 = (proof_bytes,schema_hash,public_inputs)
17

ZenonGreenpaperSeries
Theschema_hashensurestheverifierinterpretsproofsaccordingtothecorrectcircuit
| or constraint |     | system.   |     |     |     |     |     |     |     |
| ------------- | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
| 3.4 zApp      |     | Lifecycle |     |     |     |     |     |     |     |
1. Circuit Design: Developer defines the computation as an arithmetic circuit or
| constraint |     | system. |     |     |     |     |     |     |     |
| ---------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
2. Setup: Generates verification key 𝑣𝑘 and (if required) proving key 𝑝𝑘.
| 3. Deployment: |     |     | Publishes |     | 𝑣𝑘 in the | account-chain |     | metadata. |     |
| -------------- | --- | --- | --------- | --- | --------- | ------------- | --- | --------- | --- |
4. Execution: Users or executors generate proofs 𝜋 for state transitions.
| 5. Verification: |     |                            | Verifiers | evaluate: |     |     |      |          |         |
| ---------------- | --- | -------------------------- | --------- | --------- | --- | --- | ---- | -------- | ------- |
|                  |     | Verify(𝑣𝑘,𝜋,public_inputs) |           |           |     | =   | TRUE | and Cost | (𝜋) ≤ 𝐶 |
verify 𝑉
returning TRUE, FALSE, or REFUSED based on proof validity and resource
constraints.
This lifecycle ensures every observable state change is accompanied by a verifiable
proof.
| 3.5 Proof-Native |      |               | State         |     | Updates  |     |     |     |     |
| ---------------- | ---- | ------------- | ------------- | --- | -------- | --- | --- | --- | --- |
| Definition       | 3.2  | (Proof-Native |               |     | Block):  |     |     |     |     |
| A block          | 𝐵 in | a zApp        | account-chain |     | consists |     | of  |     |     |
𝑧
|              |     |        | 𝐵                           | = (ℎ | ,inputs,outputs,𝜋,metadata) |     |     |        |     |
| ------------ | --- | ------ | --------------------------- | ---- | --------------------------- | --- | --- | ------ | --- |
|              |     |        | 𝑧                           |      | prev                        |     |     |        |     |
| and is valid |     | if and | only if                     |      |                             |     |     |        |     |
|              |     |        | Verify(𝑣𝑘,𝜋,inputs,outputs) |      |                             |     |     | = TRUE |     |
Hence, state transitions are self-verifying; replay is unnecessary.
3.6 Composability
| Multiple | zApps | can | interoperate |     | by  | composing | their | proofs. |     |
| -------- | ----- | --- | ------------ | --- | --- | --------- | ----- | ------- | --- |
18

ZenonGreenpaperSeries
| Definition |     | 3.3 (Composable |     |     | Proof): |     |     |     |     |     |
| ---------- | --- | --------------- | --- | --- | ------- | --- | --- | --- | --- | --- |
Given proofs 𝜋 ,𝜋 ,…,𝜋 over circuits 𝐶 ,…,𝐶 , a composed proof Π verifies if
|        |             | 1   | 2       | 𝑘   |              |       | 1     | 𝑘            |     |     |
| ------ | ----------- | --- | ------- | --- | ------------ | ----- | ----- | ------------ | --- | --- |
|        |             |     |         |     | ∀𝑖,Verify(𝑣𝑘 |       |       | ,𝜋 ) = TRUE  |     |     |
|        |             |     |         |     |              |       | 𝑖     | 𝑖            |     |     |
| and an | aggregation |     | circuit |     | verifies     | their | joint | correctness. |     |     |
Aggregated proofs enable efficient multi-application verification while respecting
| resource | bounds. |          |               |       |               |     |     |     |     |     |
| -------- | ------- | -------- | ------------- | ----- | ------------- | --- | --- | --- | --- | --- |
| 3.6.1    | Bounded |          | Composability |       |               |     |     |     |     |     |
| Theorem  | 3.1     | (Bounded |               | Proof | Composition): |     |     |     |     |     |
For a verifier with bound 𝐶 , there exists a maximum compositional depth 𝑑 such
𝑉 max
that verification of 𝑑 > 𝑑 proofs exceeds 𝐶 . Verifiers must therefore refuse deeper
|     |     |     |     | max |     |     |     | 𝑉   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
compositions.
Operational implication: Light clients might verify up to 5 composed proofs and
| refuse                        | further | nesting.       |     |             |            |              |             |     |               |     |
| ----------------------------- | ------- | -------------- | --- | ----------- | ---------- | ------------ | ----------- | --- | ------------- | --- |
| 3.7 Proof-Native              |         |                |     | Application |            |              | Interfaces  |     |               |     |
| zApps                         | expose  | deterministic, |     |             | verifiable |              | APIs:       |     |               |     |
| Function                      |         |                |     | Description |            |              |             |     | Verifiability |     |
| verifyProof(π)                |         |                |     | Checks      | proof      |              | correctness |     | Deterministic |     |
| getCommitment()               |         |                |     | Returns     |            | Merkle       | root        | of  | Deterministic |     |
|                               |         |                |     | current     | state      |              |             |     |               |     |
| requestState(height)Retrieves |         |                |     |             |            | proof-backed |             |     | Bounded       |     |
snapshot
| composeProofs([π₁…πₙR]e)turns |     |     |     |     |     | aggregated |     | proof | Bounded | by 𝐶 |
| ----------------------------- | --- | --- | --- | --- | --- | ---------- | --- | ----- | ------- | ---- |
𝑉
These interfaces are designed for browser-native operation and machine verification.
| 3.8 zApp |              | Example: |     | Token |        | Ledger      |     |       |        |     |
| -------- | ------------ | -------- | --- | ----- | ------ | ----------- | --- | ----- | ------ | --- |
| A simple | proof-native |          |     | token | ledger | illustrates |     | these | ideas. |     |
| Circuit  | Definition   |          |     |       |        |             |     |       |        |     |
19

ZenonGreenpaperSeries
Constraints:
|     |     | ⎧ ⎪balance[𝐴] |     | ≥   | amount |     |
| --- | --- | ------------- | --- | --- | ------ | --- |
⎪ ⎪
|     |     |     | balance′[𝐴] |     | = balance[𝐴]−amount |     |
| --- | --- | --- | ----------- | --- | ------------------- | --- |
⎨
⎪ ⎪
⎪
|     |     |     | balance′[𝐵] |     | = balance[𝐵]+amount |     |
| --- | --- | --- | ----------- | --- | ------------------- | --- |
⎩
The proof attests that balances are updated correctly without exposing private data.
Verification
Verifiers check 𝜋 against the published verification key 𝑣𝑘 . If valid, they update
token
the account-chain state root; otherwise, they reject or refuse.
| 3.9 Proof-Carried |     |     | Execution |     |     |     |
| ----------------- | --- | --- | --------- | --- | --- | --- |
In this architecture, execution artifacts themselves are proofs.
| Definition | 3.4 (Proof-Carried |     |     | Computation): |     |     |
| ---------- | ------------------ | --- | --- | ------------- | --- | --- |
A computation 𝑓(𝑥) is proof-carried if it emits (𝑦,𝜋) such that
|               |       |             |     | Verify(𝑣𝑘,𝜋,𝑥,𝑦) |           | = TRUE |
| ------------- | ----- | ----------- | --- | ---------------- | --------- | ------ |
| The verifier  | never | re-executes |     | 𝑓; it only       | validates | 𝜋.     |
| 3.10 Security |       | Model       |     |                  |           |        |
Soundness of zApps inherits from the underlying proof system.
| Theorem | 3.2 (Soundness |     | of zApps): |     |     |     |
| ------- | -------------- | --- | ---------- | --- | --- | --- |
If the proof system is sound and the verification key is authentic, no adversary can
produce 𝜋 that passes verification for an incorrect computation.
𝜋.
Proof Sketch. Assume an adversary generates a false By proof-system soundness,
the probability of this is negligible in 𝜆, the security parameter.
| Hence,          | correctness | reduces | to           | verifying | 𝑣𝑘  | authenticity. |
| --------------- | ----------- | ------- | ------------ | --------- | --- | ------------- |
| 3.11 Deployment |             |         | Implications |           |     |               |
1. Off-ChainScalability: Heavycomputationoccursoff-chain;on-chainverification
| remains     | constant. |     |          |        |       |                   |
| ----------- | --------- | --- | -------- | ------ | ----- | ----------------- |
| 2. Privacy: | zk-proofs |     | can hide | inputs | while | proving validity. |
20

ZenonGreenpaperSeries
3. Cross-Environment Portability: Proofs remain valid across networks if the
| verification | key is | portable. |     |     |     |     |
| ------------ | ------ | --------- | --- | --- | --- | --- |
4. User-Side Verification: Browsers can independently verify proofs without RPC
trust.
5. Composable Services: Applications can reuse proofs from others without re-
execution.
| 3.12 Summary | of  | Pillar II  |     |     |         |     |
| ------------ | --- | ---------- | --- | --- | ------- | --- |
| Concept      |     | Definition |     |     | Benefit |     |
Proof-Native Execution Computations emit proofs Removes replay
| Sound Verification |     | Constant-time | validation     |     | Bounded       | cost |
| ------------------ | --- | ------------- | -------------- | --- | ------------- | ---- |
| Proof Composition  |     | Aggregation   | of independent |     | Inter-zApp    |      |
|                    |     | proofs        |                |     | composability |      |
| Resource-Aware     |     | Refusals      | beyond 𝐶       |     | Predictable   |      |
𝑉
| Verification |     |     |     |     | performance |     |
| ------------ | --- | --- | --- | --- | ----------- | --- |
Off-Chain Scalability Heavy work moved off-chain High throughput
zApps demonstrate how verification-first design enables expressive applications under
explicit resource bounds. They form the operational layer on top of the bounded
| verification | foundation.     |     |          |              |     |       |
| ------------ | --------------- | --- | -------- | ------------ | --- | ----- |
| 4. Pillar    | III: Composable |     | External | Verification |     | (CEV) |
This section describes a proposed mechanism for independently confirming exter-
nal chain events (like Bitcoin transactions) without trusting bridges, custodians, or
intermediaries, using the same verification-first principles and bounded resource
constraints.
21

ZenonGreenpaperSeries
4.1 Motivation
Cross-chain interoperability traditionally relies on trusted intermediaries: bridges,
relayers,orcustodialcontracts. Theseentitiesattestthataneventoccurredonanother
| chain–but | such attestations |     |     | require | trust, | not | verification. |     |     |     |
| --------- | ----------------- | --- | --- | ------- | ------ | --- | ------------- | --- | --- | --- |
Composable External Verification (CEV) replaces trust with cryptographic evidence.
A verifier can independently confirm a claim about an external system–such as “this
Bitcointransactionwasconfirmed”–usingonlypublicdataandsuccinctproofs,without
| executing | or trusting | that | external |     | system. |     |     |     |     |     |
| --------- | ----------- | ---- | -------- | --- | ------- | --- | --- | --- | --- | --- |
4.2 Definition
| Definition | 4.1 (External |             | Verification |        | Claim): |             |     |     |     |     |
| ---------- | ------------- | ----------- | ------------ | ------ | ------- | ----------- | --- | --- | --- | --- |
| A claim    | 𝑋 about       | an external |              | system | 𝑆       | is a tuple: |     |     |     |     |
ext
|     |     |     | 𝑋 = | (𝑆  | ,statement,proof,reference) |     |     |     |     |     |
| --- | --- | --- | --- | --- | --------------------------- | --- | --- | --- | --- | --- |
ext
where: * 𝑆 identifies the external system (e.g., Bitcoin mainnet), * statement is the
ext
factual claim (e.g., “txid 𝑇 confirmed in block 𝑏”), * proof is the cryptographic proof
attesting to the claim, and * reference includes consensus parameters such as block
| header     | hash.           |     |     |          |                |     |     |     |     |     |
| ---------- | --------------- | --- | --- | -------- | -------------- | --- | --- | --- | --- | --- |
| Definition | 4.2 (Composable |     |     | External | Verification): |     |     |     |     |     |
A CEV mechanism is a protocol that allows internal verifiers to check external claims
within bounded resources. For claim 𝑋, the verification predicate evaluates to:
⎧
|     |     | ⎪TRUE |     |     | if all | proofs | validate | and | costs ≤ | 𝑅   |
| --- | --- | ----- | --- | --- | ------ | ------ | -------- | --- | ------- | --- |
|     |     | ⎪ ⎪   |     |     |        |        |          |     |         | 𝑉   |
Verify (𝑋,𝐷,𝑅 ) = FALSE if proofs cryptographically contradict the claim
|     | CEV | 𝑉 ⎨ |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
⎪ ⎪
⎪
|          |       |          | REFUSED |       | if data | unavailable |     | or  | costs exceed | 𝑅   |
| -------- | ----- | -------- | ------- | ----- | ------- | ----------- | --- | --- | ------------ | --- |
|          |       | ⎩        |         |       |         |             |     |     |              | 𝑉   |
| 4.3 Core | Idea: | External |         | Proof |         | Composition |     |     |              |     |
Instead of relaying full foreign state, the external system’s consensus digest (e.g., Bit-
coinblockheader)isimportedperiodicallyintotheMomentumchainasacommitment
root.
| Verifiers | then check | inclusion |     | proofs | against |     | that root. |     |     |     |
| --------- | ---------- | --------- | --- | ------ | ------- | --- | ---------- | --- | --- | --- |
22

ZenonGreenpaperSeries
| Definition  | 4.3        | (External  | Commitment): |          |                   |      |     |
| ----------- | ---------- | ---------- | ------------ | -------- | ----------------- | ---- | --- |
| An external | commitment |            | is           | a tuple: |                   |      |     |
|             |            |            | 𝑐            | = (𝑆 ,ℎ  | ,height,metadata) |      |     |
|             |            |            | ext          | ext      | header            |      |     |
| anchored    | within     | a Momentum |              | block:   |                   |      |     |
|             |            |            |              | 𝑀 =      | (…,𝐶 ∪{𝑐          | },…) |     |
|             |            |            |              | 𝑖        | ext               |      |     |
where ℎ is the hash of the external chain’s block header at the specified height.
header
Thisanchoringtiesanexternalchain’sverifiedstateintotheinternalcommitmentchain
without requiring continuous synchronization. The anchored commitment provides
header hash authenticity, while consensus confidence (e.g., that the header represents
the canonical chain with sufficient finality) requires additional header-chain evidence
such as PoW linkage or confirmation depth within bounded resources. Verifiers
seekingstrongerguaranteesmayvalidatethisadditionalevidence;otherwisetheymay
refuse queries if the available evidence is insufficient for their security requirements,
consistent with the refusal semantics of §2.7 and the consensus-agnostic design
principle.
| 4.4 Example: |     | Verifying |     | a Bitcoin | Transaction |     |     |
| ------------ | --- | --------- | --- | --------- | ----------- | --- | --- |
A verifier wishes to confirm that a Bitcoin transaction with hash txid was included in
| a sufficiently |           | confirmed | block | at height   | ℎ.  |     |     |
| -------------- | --------- | --------- | ----- | ----------- | --- | --- | --- |
| Step           | 1: Obtain | External  |       | Commitment  |     |     |     |
| A recent       | Momentum  |           | block | 𝑀 contains: |     |     |     |
𝑖
|     |     |     | 𝑐   | = (𝑆 = Bitcoin,ℎ |        | ,height | = ℎ) |
| --- | --- | --- | --- | ---------------- | ------ | ------- | ---- |
|     |     |     | ext | ext              | header |         |      |
where ℎ = 𝐻(hdr ) is the hash of the Bitcoin block header at height ℎ.
|      | header      |       | ℎ   |         |     |     |     |
| ---- | ----------- | ----- | --- | ------- | --- | --- | --- |
| Step | 2: Retrieve | Proof | and | Headers |     |     |     |
Theverifierdownloads: *Bitcoinblockheaderhdr *BitcoinSPVproof𝜋 consisting
ℎ SPV
of: * Transaction hash txid * Merkle branch 𝑃 (path from txid to Merkle root) *
(Optional, for confirmation depth) subsequent headers hdr ,…,hdr
ℎ+1 ℎ+𝑘
| Step | 3: Verify | Header | Anchoring |     |     |     |     |
| ---- | --------- | ------ | --------- | --- | --- | --- | --- |
Verify that 𝐻(hdr ) = ℎ (matching the anchored commitment in 𝑀 ).
ℎ header 𝑖
23

ZenonGreenpaperSeries
| Step 4: | Evaluate |        | Merkle |      | Inclusion |              |                    |     |     |     |     |     |     |
| ------- | -------- | ------ | ------ | ---- | --------- | ------------ | ------------------ | --- | --- | --- | --- | --- | --- |
| Compute | the      | Merkle | root   | from | the       | transaction: |                    |     |     |     |     |     |     |
|         |          |        |        | root |           | =            | MerkleRoot(txid,𝑃) |     |     |     |     |     |     |
computed
| where | MerkleRoot |     | applies |     | the Merkle | branch |     | 𝑃 to | txid. |     |     |     |     |
| ----- | ---------- | --- | ------- | --- | ---------- | ------ | --- | ---- | ----- | --- | --- | --- | --- |
Check if root = hdr .merkle_root (the Merkle root field in the Bitcoin header).
|         |        | computed |              | ℎ   |       |            |     |     |           |     |     |     |     |
| ------- | ------ | -------- | ------------ | --- | ----- | ---------- | --- | --- | --------- | --- | --- | --- | --- |
| Step 5: | Verify |          | Confirmation |     | Depth | (Consensus |     |     | Evidence) |     |     |     |     |
To establish that the transaction is sufficiently confirmed: * Verify the header chain
hdr → hdr → … → hdr by checking: * Each header’s prev_block_hash matches
| ℎ   |     | ℎ+1 |     | ℎ+𝑘 |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
𝐻(previous header) * Each header satisfies PoW validity by checking that 𝐻(hdr ) <
𝑗
target(hdr ), where target(hdr ) is derived from the difficulty field (e.g., nBits) in hdr
|     | 𝑗   |     |     |     | 𝑗   |     |     |     |     |     |     |     | 𝑗   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
* If the verifier’s policy requires 𝑘 confirmations and the chain has valid PoW linkage
| for 𝑘 blocks, |          | the | transaction |     | is considered |     | confirmed. |     |     |     |     |     |     |
| ------------- | -------- | --- | ----------- | --- | ------------- | --- | ---------- | --- | --- | --- | --- | --- | --- |
| Step 6:       | Evaluate |     | Predicate   |     |               |     |            |     |     |     |     |     |     |
⎧⎪⎪⎪⎪⎪⎪⎪⎪⎪⎪
|              |     |     | TRUE        |     | if ro | o t   | =          | h d r  | .m e rk l e | _r o o | t      |     |     |
| ------------ | --- | --- | ----------- | --- | ----- | ----- | ---------- | ------ | ----------- | ------ | ------ | --- | --- |
|              |     |     |             |     |       | c o m | pu t ed    | ℎ      |             |        |        |     |     |
|              |     |     |             |     | a n   | d h e | a d e r ch | a in v | al id f o   | r 𝑘 b  | l ocks |     |     |
| 𝑃 (txid,ℎ,𝑘) |     | =   |             |     | and   | Cost  |            | ≤ 𝐶    |             |        |        |     |     |
| BTC          |     |     | ⎨⎪⎪⎪⎪⎪⎪⎪⎪⎪⎪ |     |       |       | v e ri fy  | 𝑉      |             |        |        |     |     |
FALSE if Merkle p r o o f or h eader chain cryptographically invalid
|         |        |     | REFUSED |     | if data | unavailable |     | or  | cost exceeds |     | 𝑅   |     |     |
| ------- | ------ | --- | ------- | --- | ------- | ----------- | --- | --- | ------------ | --- | --- | --- | --- |
|         |        |     | ⎩       |     |         |             |     |     |              |     |     | 𝑉   |     |
| Step 7: | Output |     |         |     |         |             |     |     |              |     |     |     |     |
If valid, the verifier declares the transaction confirmed under the external proof com-
mitment with 𝑘 confirmations. If the Merkle proof or header chain is cryptographically
invalid, return FALSE. Otherwise, refuse due to unavailable or unverifiable data.
| 4.5 Formal |     | Structure |           |              |        |               |     |        |      |     |      |        |       |
| ---------- | --- | --------- | --------- | ------------ | ------ | ------------- | --- | ------ | ---- | --- | ---- | ------ | ----- |
| Definition |     | 4.4       | (External | Verification |        | Predicate):   |     |        |      |     |      |        |       |
|            |     | ⎧ ⎪TRUE,  |           |              | if all | cryptographic |     | checks | pass | and | Cost | (𝐷)    | ≤ 𝐶 , |
|            |     | ⎪         |           |              |        |               |     |        |      |     |      | verify | 𝑉     |
⎪ ⎪
⎪
|          |     | ⎪   |     |     | BytesFetched(𝐷) |     |     | ≤   | 𝐵 ,BytesStored(𝐷) |     |     | ≤ 𝑆 |     |
| -------- | --- | --- | --- | --- | --------------- | --- | --- | --- | ----------------- | --- | --- | --- | --- |
|          |     |     |     |     |                 |     |     |     | 𝑉                 |     |     | 𝑉   |     |
| 𝑃 (𝑋,𝐷,𝑅 |     | ) = |     |     |                 |     |     |     |                   |     |     |     |     |
| ext      | 𝑉   |     |     |     |                 |     |     |     |                   |     |     |     |     |
⎨ ⎪ ⎪FALSE, if provided cryptographic objects contradict the claim
⎪
⎪
⎪ ⎪
⎩ REFUSED, if data is unavailable, out of scope, or resource bounds would be exceeded
24

ZenonGreenpaperSeries
This mirrors the bounded verification semantics of internal predicates (§2.6). External
| proofs | must | therefore | be  | succinct | and | efficiently | checkable. |     |     |     |
| ------ | ---- | --------- | --- | -------- | --- | ----------- | ---------- | --- | --- | --- |
4.6 Properties
1. Trust-Minimized: Verifiers depend only on cryptographic commitments an-
|     | chored | in the Momentum |     |     | chain. |     |     |     |     |     |
| --- | ------ | --------------- | --- | --- | ------ | --- | --- | --- | --- | --- |
2. Composable: External verification results can themselves be inputs to other
|     | predicates  | (e.g.,       | DeFi | apps | using   | BTC proofs). |     |     |     |     |
| --- | ----------- | ------------ | ---- | ---- | ------- | ------------ | --- | --- | --- | --- |
|     | 3. Bounded: | Verification |      | cost | remains | within       | 𝑅 . |     |     |     |
𝑉
4. Refusal Safety: If external data is unavailable, the verifier refuses deterministi-
cally.
| 4.7 | External | Proof |     | Structures |     |     |     |     |     |     |
| --- | -------- | ----- | --- | ---------- | --- | --- | --- | --- | --- | --- |
External proofs depend on the external system’s commitment model:
| External |     | System |     | Proof Type  |     | Root  | Type   | Verification | Cost     |        |
| -------- | --- | ------ | --- | ----------- | --- | ----- | ------ | ------------ | -------- | ------ |
| Bitcoin  |     |        |     | SPV (Merkle |     | Block | header | 𝑂(log𝑛       | ) hashes | + 𝑂(𝑘) |
tx
|     |     |     |     | inclusion  | +   | hash        | +   | header | checks |     |
| --- | --- | --- | --- | ---------- | --- | ----------- | --- | ------ | ------ | --- |
|     |     |     |     | PoW chain) |     | merkle_root |     |        |        |     |
field
| Ethereum |     |     |     | Merkle | Patricia | State | root | 𝑂(log𝑛 | ) hashes |     |
| -------- | --- | --- | --- | ------ | -------- | ----- | ---- | ------ | -------- | --- |
state
proof
| Mina  |         |                 |     | Recursive  |       | State      |     | 𝑂(1)    |        |     |
| ----- | ------- | --------------- | --- | ---------- | ----- | ---------- | --- | ------- | ------ | --- |
|       |         |                 |     | SNARK      |       | commitment |     |         |        |     |
| Other | PoS/BFT | Chains          |     | Header     |       | Consensus  |     | 𝑂(log𝑛) | hashes |     |
|       |         |                 |     | signatures | +     | root       |     |         |        |     |
|       |         |                 |     | inclusion  | proof |            |     |         |        |     |
| 4.8   | Bounded | Synchronization |     |            |       |            |     |         |        |     |
Verifiers do not need to track all external headers. They only require recent ones
| anchored |     | via CEV commitments. |     |     |     |     |     |     |     |     |
| -------- | --- | -------------------- | --- | --- | --- | --- | --- | --- | --- | --- |
25

ZenonGreenpaperSeries
| Property | 4.1 (Bounded | Header Set): |     |     |     |     |
| -------- | ------------ | ------------ | --- | --- | --- | --- |
Let 𝐻 be the external header set anchored up to height ℎ. Verifiers need only store
ext
| the last        | 𝑘 headers satisfying |             |                   |      |     |     |
| --------------- | -------------------- | ----------- | ----------------- | ---- | --- | --- |
|                 |                      |             | |𝐻 | ≤ 𝑓(𝑆        | ,𝐵 ) |     |     |
|                 |                      |             | ext 𝑉             | 𝑉    |     |     |
| This ensures    | synchronization      | remains     | resource-bounded. |      |     |     |
| 4.9 Multi-Chain |                      | Composition |                   |      |     |     |
CEV allows aggregation of multiple external verifications into a single proof.
Example:
AzAppverifiesthat: *aBitcoinpaymentoccurred,and*anEthereumcontractemitted
| a matching      | event. |              |           |     |     |     |
| --------------- | ------ | ------------ | --------- | --- | --- | --- |
| Both predicates | can    | be combined: |           |     |     |     |
|                 |        |              | 𝑃 = 𝑃 ∧𝑃  |     |     |     |
|                 |        |              | multi BTC | ETH |     |     |
By Refusal Propagation (§2.6.2), if either is REFUSED, the entire composite predicate
is REFUSED.
Thus, the system composes external facts without introducing cross-chain trust.
| 4.10 Cross-Domain |     | Proof | Aggregation |     |     |     |
| ----------------- | --- | ----- | ----------- | --- | --- | --- |
To support scalable interoperability, the system can embed aggregated proofs inside
| Momentum   | blocks.         |          |         |     |     |     |
| ---------- | --------------- | -------- | ------- | --- | --- | --- |
| Definition | 4.5 (Aggregated | External | Proof): |     |     |     |
An aggregated proof Π combines multiple external verifications:
ext
|                 |              | Π = {(𝜋       | ,𝑣𝑘 ),(𝜋      | ,𝑣𝑘 ),…} |      |     |
| --------------- | ------------ | ------------- | ------------- | -------- | ---- | --- |
|                 |              | ext           | BTC BTC       | ETH ETH  |      |     |
| A meta-verifier | validates    | all subproofs | under bounded | cost:    |      |     |
|                 | ∀𝑖,Verify(𝑣𝑘 | ,𝜋 ) =        | TRUE and      | ∑Cost    | (𝜋 ) | ≤ 𝐶 |
|                 |              | 𝑖 𝑖           |               | verify   | 𝑖    | 𝑉   |
𝑖
This produces efficient multi-chain verification that remains within client limits.
26

ZenonGreenpaperSeries
| 4.11                      | Refusal |               | Semantics |           |     | for             | External | Data    |          |           |        |       |
| ------------------------- | ------- | ------------- | --------- | --------- | --- | --------------- | -------- | ------- | -------- | --------- | ------ | ----- |
| Refusal                   |         | is especially |           | important |     | for cross-chain |          | claims: |          |           |        |       |
| Refusal                   |         | Code          |           |           |     |                 |          |         | Meaning  |           |        |       |
| REFUSED_HEADER_MISSING    |         |               |           |           |     |                 |          |         | Anchored | header    | not    | found |
|                           |         |               |           |           |     |                 |          |         | within   | retention | window |       |
| REFUSED_PROOF_UNAVAILABLE |         |               |           |           |     |                 |          |         | SPV or   | external  | proof  | not   |
retrievable
| REFUSED_VERIFICATION_COST |     |     |     |     |     |     |     |     | Proof size | or  | verification | cost |
| ------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | ---------- | --- | ------------ | ---- |
|                           |     |     |     |     |     |     |     |     | exceeds    | 𝑅   |              |      |
𝑉
| REFUSED_INSUFFICIENT_CONFIRMATIONS |     |     |     |     |     |     |     |     | Header       | chain | evidence |     |
| ---------------------------------- | --- | --- | --- | --- | --- | --- | --- | --- | ------------ | ----- | -------- | --- |
|                                    |     |     |     |     |     |     |     |     | insufficient | for   | required |     |
|                                    |     |     |     |     |     |     |     |     | confirmation |       | depth    |     |
Refusal explicitly signals unverifiable external data, preserving system soundness.
| 4.12 | Genesis |     |     | Anchoring |     | for | External | Systems |     |     |     |     |
| ---- | ------- | --- | --- | --------- | --- | --- | -------- | ------- | --- | --- | --- | --- |
The first external commitment is embedded at genesis as a trust root. From that point,
all subsequent external commitments are chained cryptographically.
| Definition |     | 4.6 | (External |     | Trust | Root): |       |            |     |     |     |     |
| ---------- | --- | --- | --------- | --- | ----- | ------ | ----- | ---------- | --- | --- | --- | --- |
|            |     |     |           |     |       | 𝑇 = (𝑆 | ,ℎ(0) | ,metadata) |     |     |     |     |
|            |     |     |           |     |       | ext    | ext   |            |     |     |     |     |
header
All verifiable external claims must derive from 𝑇 by recursive commitments.
ext
This ensures long-term verifiability even after long offline periods.
| 4.13 | Example: |     |     | Trustless |     | Cross-Chain |     |     | Swap |     |     |     |
| ---- | -------- | --- | --- | --------- | --- | ----------- | --- | --- | ---- | --- | --- | --- |
A user executes a cross-chain atomic swap between ZNN and BTC.
Sequence:
1. User locks BTC in a Bitcoin HTLC (script-based timelocked output); generates
|     | SPV | proof | 𝜋   | with | confirmation |     | evidence. |     |     |     |     |     |
| --- | --- | ----- | --- | ---- | ------------ | --- | --------- | --- | --- | --- | --- | --- |
BTC
|     | 2. Submits |     | 𝜋   | to a | zApp | on the | dual-ledger | system. |     |     |     |     |
| --- | ---------- | --- | --- | ---- | ---- | ------ | ----------- | ------- | --- | --- | --- | --- |
BTC
27

ZenonGreenpaperSeries
3. zApp verifies 𝜋 using the latest CEV commitment and confirmation depth
BTC
check.
| 4. Upon | success, | zApp releases | equivalent | ZNN on-chain. |     |
| ------- | -------- | ------------- | ---------- | ------------- | --- |
No intermediary ever holds both assets–security derives purely from verification.
| 4.14    | Security      | Model        |             |     |     |
| ------- | ------------- | ------------ | ----------- | --- | --- |
| Theorem | 4.1 (External | Verification | Soundness): |     |     |
Assuming: 1. externalcommitmentanchoringiscorrect,and2. externalproofsystems
are sound,
then no adversary can produce a false verified external claim without breaking under-
lying cryptography.
Proof Sketch. External proofs verify against anchored roots. To falsify a claim, the
adversary must either forge a valid proof (break soundness) or rewrite anchored
Momentum history (break commitment immutability under Property 2.1). Both are
computationally infeasible under standard cryptographic assumptions.
| 4.15 | System | Implications |     |     |     |
| ---- | ------ | ------------ | --- | --- | --- |
1. No Trusted Bridges: CEV replaces bridges with verifiable proofs.
2. Verifiable Oracles: External data (e.g., prices) can be verified cryptographically.
3. Cross-Chain Composability: Applications can depend on multiple external
proofs.
4. Bounded Cost: Verification remains feasible for light clients.
5. Self-Sovereign Verification: Any verifier can confirm external claims indepen-
dently.
| 4.16    | Summary | of Pillar  | III |     |         |
| ------- | ------- | ---------- | --- | --- | ------- |
| Concept |         | Definition |     |     | Benefit |
External Commitments Anchored roots from external Trustless cross-chain
|          |        | chains |              |               | linkage   |
| -------- | ------ | ------ | ------------ | ------------- | --------- |
| External | Proofs | SPV    | or zk proofs | from external | No replay |
data
28

ZenonGreenpaperSeries
| Concept |     |     |     |     | Definition |     |     |     |     | Benefit |
| ------- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | ------- |
Refusal Semantics Explicit refusals for missing data Safety under
unavailability
| Composability |     |     |     |     | Cross-chain |     | proof | aggregation |     | Interoperability |
| ------------- | --- | --- | --- | --- | ----------- | --- | ----- | ----------- | --- | ---------------- |
Genesis Anchoring Permanent external trust roots Long-term verification
Composable External Verification extends verification-first design beyond a single
ledger, enabling a web of independently verifiable systems. It transforms interoper-
ability from a problem of trust into one of cryptographic composition.
| 5.  | System  |     | Integration  |     |     |     |     |     |     |     |
| --- | ------- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
| 5.1 | Unified |     | Architecture |     |     |     |     |     |     |     |
The three pillars–Bounded Verification, Proof-Native Applications, and Composable
| External |       | Verification–compose |           |     |       | into   | a single, | layered    | system:  |     |
| -------- | ----- | -------------------- | --------- | --- | ----- | ------ | --------- | ---------- | -------- | --- |
|          | Layer |                      | Component |     |       | Core   | Function  |            |          |     |
|          | L₁    |                      | Momentum  |     | Chain | Global |           | commitment | ordering |     |
L₂ Account Chains Parallel local execution and proof emission
|     | L₃           |     | zApps     |           |                      | Proof-native |          | state       | transitions  |         |
| --- | ------------ | --- | --------- | --------- | -------------------- | ------------ | -------- | ----------- | ------------ | ------- |
|     | L₄           |     | CEV       | Interface |                      | Verification |          | of external |              | systems |
| The | architecture |     | forms     |           | a verification-first |              |          | stack:      |              |         |
|     |              |     | Execution |           | ⊆                    | Proof        | Emission | ⊆ Bounded   | Verification |         |
Everyobservablestatechange–internalorexternal–isverifiablebyaresource-bounded
| participant |     | operating |     | solely |     | on cryptographic |     | data. |     |     |
| ----------- | --- | --------- | --- | ------ | --- | ---------------- | --- | ----- | --- | --- |
29

ZenonGreenpaperSeries
| 5.2 Data | Flow |     |     |     |     |     |     |     |     |     |     |
| -------- | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
1. Local Execution: Each account runs its zApp, producing state updates and
| validity | proofs. |     |     |     |     |     |     |     |     |     |     |
| -------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
2. Commitment Inclusion: Proof-anchored state digests are committed into the
| Momentum |     | chain. |     |     |     |     |     |     |     |     |     |
| -------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
3. External Verification: CEV anchors external commitments (e.g., Bitcoin head-
ers).
| 4. Verification |     | Path:    |     |            |     |        |     |              |     |     |         |
| --------------- | --- | -------- | --- | ---------- | --- | ------ | --- | ------------ | --- | --- | ------- |
|                 |     | Verifier |     | ⇒ Momentum |     | Header |     | ⇒ Commitment |     |     | ⇒ Proof |
At any point, if data or cost exceed 𝑅 , the verifier returns a refusal code.
𝑉
| 5.3 Formal   |             | Composition   |          |            |       |         |        |       |           |          |     |
| ------------ | ----------- | ------------- | -------- | ---------- | ----- | ------- | ------ | ----- | --------- | -------- | --- |
| Definition   | 5.1         | (Verification |          | Pipeline): |       |         |        |       |           |          |     |
|              | 𝑃           |               | (𝑥) =    | 𝑃          | (𝑥)∧𝑃 |         | (𝑥)∧𝑃  |       | (𝑥)∧𝑃     |          | (𝑥) |
|              |             | system        |          | momentum   |       | account |        | proof |           | external |     |
| with refusal | propagation |               |          | (§2.6.2):  |       |         |        |       |           |          |     |
|              |             |               | ∃𝑖,𝑃 (𝑥) | = REFUSED  |       | ⇒       | 𝑃      | (𝑥)   | = REFUSED |          |     |
|              |             |               | 𝑖        |            |       |         | system |       |           |          |     |
This closure ensures global soundness without global execution.
| 5.4 Security |             | Model        |         |     |              |           |              |             |     |     |        |
| ------------ | ----------- | ------------ | ------- | --- | ------------ | --------- | ------------ | ----------- | --- | --- | ------ |
|              | Threat      |              |         |     | Mitigation   |           |              |             |     |     | Source |
|              | Forged      | transactions |         |     | Proof-system |           | soundness    |             |     |     | §3.10  |
|              | Header      | rewriting    |         |     | Momentum     |           | immutability |             |     |     | §2.2   |
|              | Data        | withholding  |         |     | Refusal      | semantics |              |             |     |     | §2.7   |
|              | Cross-chain |              | forgery |     | Anchored     |           | external     | commitments |     |     | §4.14  |
|              | State       | overflow     |         |     | Adaptive     | retention |              |             |     |     | §2.8   |
30

ZenonGreenpaperSeries
Security reduces to the cryptographic primitives; no single party can induce accep-
| tance        | of an | invalid claim. |     |     |     |     |     |     |     |     |
| ------------ | ----- | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| 5.5 Resource |       | Scaling        |     |     |     |     |     |     |     |     |
Let: * 𝑁 = number of Momentum blocks * 𝑚 = average number of commitments per
Momentum block * 𝐿 = length of account-chain segment being verified (in blocks)
𝐴
* 𝜎 = average bytes per account-chain block * 𝜎 = average bytes per proof object
| 𝐵   |     |     |     |     |     |     |     | 𝜋   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
* 𝐶 = verification cost per proof (operations or time) * 𝑅 = (𝑆 ,𝐵 ,𝐶 ) = verifier
| verify |     |     |     |     |     |     |     |     | 𝑉   | 𝑉 𝑉 𝑉 |
| ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | ----- |
bounds
Then for a verifier tracking headers and selectively verifying accounts:
| Storage     | (Momentum |             | headers): |               |                |         |                |            |     |     |
| ----------- | --------- | ----------- | --------- | ------------- | -------------- | ------- | -------------- | ---------- | --- | --- |
|             |           |             |           |               | 𝑂(𝑁)           | headers |                |            |     |     |
| Bandwidth   |           | (commitment |           | membership    |                |         | proof):        |            |     |     |
|             |           |             |           |               | 𝑂(log𝑚)        |         | hashes         |            |     |     |
| Computation |           | (commitment |           |               | membership     |         | verification): |            |     |     |
|             |           |             |           |               | 𝑂(log𝑚)        | hash    | operations     |            |     |     |
| Bandwidth   |           | (account    | segment   |               | retrieval):    |         |                |            |     |     |
|             |           |             |           |               | 𝑂(𝐿            | (𝜎 +𝜎   | )) bytes       |            |     |     |
|             |           |             |           |               | 𝐴              | 𝐵       | 𝜋              |            |     |     |
| Computation |           | (account    |           | proof         | verification): |         |                |            |     |     |
|             |           | 𝑂(𝐿         | ⋅𝐶        | ) operations, |                | where   | 𝐶              | is bounded | by  | 𝐶   |
|             |           | 𝐴           | verify    |               |                |         | verify         |            |     | 𝑉   |
The commitment membership proof scales logarithmically with commitments per
block; account-chain verification cost scales linearly with segment length and depends
| on the | specific | proof | system | used. |     |     |     |     |     |     |
| ------ | -------- | ----- | ------ | ----- | --- | --- | --- | --- | --- | --- |
31

ZenonGreenpaperSeries
| 6.  | Related    |     | Work |              |     |     |            |     |     |     |     |     |
| --- | ---------- | --- | ---- | ------------ | --- | --- | ---------- | --- | --- | --- | --- | --- |
| 6.1 | Blockchain |     |      | Verification |     |     | Approaches |     |     |     |     |     |
• Full Nodes: Execute every transaction; verification = replay.
• Light Clients: Validate headers only; depend on unverified intermediaries.
• Rollups/ValidityProofs: Off-chainexecution,on-chainverification–buttypically
|     | bounded |     | to one | chain | and | large | proofs. |     |     |     |     |     |
| --- | ------- | --- | ------ | ----- | --- | ----- | ------- | --- | --- | --- | --- | --- |
The proposed architecture generalizes these patterns into a dual-ledger, verification-
| first     | model         | with   | explicit |                | resource    | limits.     |              |            |     |        |           |      |
| --------- | ------------- | ------ | -------- | -------------- | ----------- | ----------- | ------------ | ---------- | --- | ------ | --------- | ---- |
| 6.2       | Cryptographic |        |          |                | Foundations |             |              |            |     |        |           |      |
| The       | design        | builds |          | on established |             | primitives: |              |            |     |        |           |      |
| Primitive |               |        |          |                | Role        | in          | Architecture |            |     |        |           |      |
| Merkle    |               | trees  |          |                | Commitment  |             |              | membership |     | proofs | (Momentum | 𝑟 ); |
𝐶
|           |        |             |     |     | transaction |          |        | inclusion | proofs     | (Bitcoin | SPV) |     |
| --------- | ------ | ----------- | --- | --- | ----------- | -------- | ------ | --------- | ---------- | -------- | ---- | --- |
| SNARKs    |        | / STARKs    |     |     | zApp        | validity |        | proofs    |            |          |      |     |
| Hash      | chains |             |     |     | Momentum    |          |        | ordering  |            |          |      |     |
| Signature |        | aggregation |     |     | Consensus   |          | header |           | validation |          |      |     |
Unlike rollups or zero-knowledge blockchains, verification cost here is tunable via 𝑅 ,
𝑉
| not | fixed      | to a | single | circuit. |            |     |             |     |               |     |     |     |
| --- | ---------- | ---- | ------ | -------- | ---------- | --- | ----------- | --- | ------------- | --- | --- | --- |
| 6.3 | Conceptual |      |        | Lineage  |            |     |             |     |               |     |     |     |
|     | • Bitcoin  |      | SPV    | (2009):  | Introduced |     | header-only |     | verification. |     |     |     |
• Plasma (2017): Proposed bounded off-chain state commitment.
|     | • zkRollups |     | (2018+): |     | Shifted | execution |     | to  | proofs. |     |     |     |
| --- | ----------- | --- | -------- | --- | ------- | --------- | --- | --- | ------- | --- | --- | --- |
• Celestia (2022): Modularized consensus and data availability.
|     | • Mina | Protocol |     | (2023): |     | Emphasized |     | succinct | chain | proofs. |     |     |
| --- | ------ | -------- | --- | ------- | --- | ---------- | --- | -------- | ----- | ------- | --- | --- |
This work synthesizes their insights into a single verification-bounded framework.
32

ZenonGreenpaperSeries
| 7. Discussion |      | and Implications |     |     |
| ------------- | ---- | ---------------- | --- | --- |
| 7.1 Refusal   | as a | Primitive        |     |     |
Traditional systems treat unresponsiveness as failure. Here, refusal is correctness:
|     |     | Unverifiable | ⇒ Refuse, | not Trust |
| --- | --- | ------------ | --------- | --------- |
This principle converts resource limitations into formally safe boundaries.
| 7.2 Verifiable | Sovereignty |     |     |     |
| -------------- | ----------- | --- | --- | --- |
Each verifier defines its own trust radius and resource policy. The network becomes
a federation of independently verifying participants, not a monolithic consensus on
execution.
This supports lightweight nodes, mobile wallets, and intermittent connectivity without
delegation.
| 7.3 Sustainability |     | and Longevity |     |     |
| ------------------ | --- | ------------- | --- | --- |
Adaptive retention limits data growth; verifiers can remain functional indefinitely
with finite storage. Genesis anchoring guarantees recovery after long offline periods–
| critical | for archival and | planetary-scale | participation. |     |
| -------- | ---------------- | --------------- | -------------- | --- |
| 7.4 Open | Research         | Questions       |                |     |
• Efficient proof markets for decentralized proof distribution.
| • Recursive | composition | limits under | tight | 𝐶 bounds. |
| ----------- | ----------- | ------------ | ----- | --------- |
𝑉
| • Post-quantum-secure |        | proof systems           | optimized | for browsers. |
| --------------------- | ------ | ----------------------- | --------- | ------------- |
| • Incentive           | design | for external commitment |           | publication.  |
| These remain          | active | areas for community     | research. |               |
33

ZenonGreenpaperSeries
8. Conclusion
Boundedverificationtransformsdistributedsystemsfromexecution-firsttoverification-
first architectures. By separating execution, proof generation, and verification, and
by bounding each verifier’s resources, the design achieves three properties simultane-
ously:
1. Independent Verification: Any participant can verify correctness without trust.
2. Bounded Scalability: Verification cost is explicit, predictable, and device-
feasible.
3. Composable Trust: Internal and external proofs integrate seamlessly.
This model redefines what it means for a distributed ledger to be trustless. It replaces
implicit completeness with explicit verifiability and explicit refusal. In doing so, it lays
the groundwork for a sustainable, universally accessible cryptographic economy.
| Appendix |          | A: Reader’s |     | Guide |     |     |     |
| -------- | -------- | ----------- | --- | ----- | --- | --- | --- |
| A.1      | Intended | Audiences   |     |       |     |     |     |
• Protocol Designers / Cryptographers: Formal predicates and proofs.
• Implementers: Algorithms, interfaces, and resource accounting.
| • Conceptual |            | Readers:      | Operational | overviews        |            | and analogies. |              |
| ------------ | ---------- | ------------- | ----------- | ---------------- | ---------- | -------------- | ------------ |
| A.2          | Reading    | Paths         |             |                  |            |                |              |
|              | Level      |               |             | Sections         |            |                | Approx. Time |
|              | Conceptual | Overview      |             | §§1, 2           | (skim),    | 3.1-3.3, 8     | ≈ 2 h        |
|              | Technical  | Understanding |             | All prose        | + examples |                | ≈ 5 h        |
|              | Formal     | Analysis      |             | Full definitions |            | + proofs       | 8 h+         |
A.3 Notation
Mathematical symbols follow standard cryptographic conventions:
34

ZenonGreenpaperSeries
| • 𝐻(⋅) | = cryptographic |      |             | hash    | function |          |              |       |     |     |
| ------ | --------------- | ---- | ----------- | ------- | -------- | -------- | ------------ | ----- | --- | --- |
| • 𝜋 =  | proof           |      |             |         |          |          |              |       |     |     |
| • 𝑣𝑘 = | verification    |      | key         |         |          |          |              |       |     |     |
| • 𝑅 =  | (𝑆 ,𝐵           | ,𝐶 ) | = verifier  |         | resource | bounds   |              |       |     |     |
| 𝑉      | 𝑉               | 𝑉 𝑉  |             |         |          |          |              |       |     |     |
| • 𝑁 =  | number          | of   | Momentum    |         | blocks   |          |              |       |     |     |
| • 𝑚 =  | number          | of   | commitments |         | per      | Momentum |              | block |     |     |
| • 𝑟 =  | commitment      |      | root        | (Merkle | root     | over     | commitments) |       |     |     |
𝐶
| Appendix      |     | B:          | Refusal |         | Codes    |     |            |         |       |             |
| ------------- | --- | ----------- | ------- | ------- | -------- | --- | ---------- | ------- | ----- | ----------- |
| Code          |     | Meaning     |         |         |          |     | Example    |         | Cause |             |
| REFUSED_OUT_  |     | Query       |         | exceeds | declared |     | Requesting |         | data  | > Δ         |
| OF_SCOPE      |     | history     |         | window  |          |     |            |         |       |             |
| REFUSED_DATA_ |     | Missing     |         | proof   | or       |     | Peer       | offline |       |             |
| UNAVAILABLE   |     | account     |         | segment |          |     |            |         |       |             |
| REFUSED_COST_ |     | Computation |         |         | > 𝐶      |     | Excessive  |         | proof | aggregation |
𝑉
EXCEEDED
| REFUSED_ |     | External    |     | header |     |     | External |     | anchoring | gap |
| -------- | --- | ----------- | --- | ------ | --- | --- | -------- | --- | --------- | --- |
| HEADER_  |     | unavailable |     |        |     |     |          |     |           |     |
MISSING
| REFUSED_ |     | SPV | or          | external | proof |     | SPV | data | unavailable |     |
| -------- | --- | --- | ----------- | -------- | ----- | --- | --- | ---- | ----------- | --- |
| PROOF_   |     | not | retrievable |          |       |     |     |      |             |     |
UNAVAILABLE
| REFUSED_ |     | Proof |     | size exceeds |     | 𝑅   | Oversized |     | proof |     |
| -------- | --- | ----- | --- | ------------ | --- | --- | --------- | --- | ----- | --- |
𝑉
VERIFICATION_
COST
REFUSED_ Header chain evidence Insufficient PoW confirmations
| INSUFFICIENT_ |     | insufficient |     |     | for required |     |     |     |     |     |
| ------------- | --- | ------------ | --- | --- | ------------ | --- | --- | --- | --- | --- |
| CONFIRMATIONS |     | confirmation |     |     | depth        |     |     |     |     |     |
35

ZenonGreenpaperSeries
| Appendix | C: Glossary |            |     |     |     |     |
| -------- | ----------- | ---------- | --- | --- | --- | --- |
| Term     |             | Definition |     |     |     |     |
Momentum Chain Sequential ledger of commitments providing global
order.
Account Chain Per-account ledger enabling parallel execution.
| zApp |     | Proof-native | application | producing | verifiable | state |
| ---- | --- | ------------ | ----------- | --------- | ---------- | ----- |
transitions.
| CEV |     | Composable | External | Verification; | mechanism | for |
| --- | --- | ---------- | -------- | ------------- | --------- | --- |
|     |     | verifying  | external | systems.      |           |     |
Bounded Verification Validation limited by explicit resource constraints.
Refusal Deterministic rejection when proof cannot be verified
within bounds.
| Appendix | D: Notation | Summary |          |                  |            |     |
| -------- | ----------- | ------- | -------- | ---------------- | ---------- | --- |
| Symbol   |             |         | Meaning  |                  |            |     |
| 𝑅 = (𝑆   | ,𝐵 ,𝐶 )     |         | Resource | bounds (storage, | bandwidth, |     |
| 𝑉 𝑉      | 𝑉 𝑉         |         |          |                  |            |     |
computation)
| 𝑃(𝑥,𝐷,𝑅 | )   |     | Verification | predicate |     |     |
| ------- | --- | --- | ------------ | --------- | --- | --- |
𝑉
| 𝜌(𝑡) |     |     | Retention | function   |     |     |
| ---- | --- | --- | --------- | ---------- | --- | --- |
| 𝑐    |     |     | External  | commitment |     |     |
ext
| 𝑇   |     |     | External | trust root |     |     |
| --- | --- | --- | -------- | ---------- | --- | --- |
ext
| 𝑣𝑘,𝜋 |     |     | Verification  | key / proof    |              |     |
| ---- | --- | --- | ------------- | -------------- | ------------ | --- |
| 𝐻(⋅) |     |     | Cryptographic | hash           | function     |     |
| 𝑁    |     |     | Number        | of Momentum    | blocks       |     |
| 𝑚    |     |     | Number        | of commitments | per Momentum |     |
block
36

ZenonGreenpaperSeries
| Symbol | Meaning    |              |      |      |
| ------ | ---------- | ------------ | ---- | ---- |
| 𝑟      | Commitment | root (Merkle | root | over |
𝐶
commitments)
| 𝐿   | Length | of account-chain | segment | (in blocks) |
| --- | ------ | ---------------- | ------- | ----------- |
𝐴
| 𝜎   | Average | bytes per account-chain |     | block |
| --- | ------- | ----------------------- | --- | ----- |
𝐵
| 𝜎   | Average | bytes per proof | object |     |
| --- | ------- | --------------- | ------ | --- |
𝜋
| 𝐶   | Verification | cost per | proof (operations | or  |
| --- | ------------ | -------- | ----------------- | --- |
verify
time)
| Cost (𝜋) | Cost function | returning | verification | cost for |
| -------- | ------------- | --------- | ------------ | -------- |
verify
proof 𝜋
| BytesFetched(𝐷) | Total bytes | downloaded | for data     | set 𝐷 |
| --------------- | ----------- | ---------- | ------------ | ----- |
| BytesStored(𝐷)  | Total bytes | retained   | for data set | 𝐷     |
37

Zenon Greenpaper Series
Appendix E: Data Availability and Proof
Distribution
This appendix makes the data-availability (DA) and proof-distribution assumptions explicit for
Zenon’s current architecture (Phase 0 / Alphanet) and for the verification-first model used
throughout this paper. The goal is not to claim perfect availability, but to specify: (i) who is
expected to store and serve which objects, (ii) how clients retrieve them, and (iii) the exact failure
modes (including refusal).
E.1 Objects that must remain available
For a verifier to answer a query without refusal, the following objects must be retrievable from
some peer set:
(cid:127) Momentum headers (and the commitment root r for each Momentum): required to anchor
C
account-chain segments and commitment-membership proofs.
(cid:127) Account-chain segments for the queried address over the requested history window D.
(cid:127) Commitment membership proofs (Merkle branches) for commitments under r .
C
(cid:127) zApp proof objects p and verification keys vk, when a query depends on proof-native application
claims.
(cid:127) External header chains (e.g., Bitcoin headers) and any required inclusion proofs, when evaluating
external predicates.
E.2 Who stores what (Phase 0 / Alphanet roles)
Zenon defines several staked roles that are explicitly designed to retain and relay state and
history:
Role Primary responsibility (DA / distribution)
Pillars Produce Momentums and, as full nodes, retain and archive the entire ledger history.
Nodes Full archival nodes that store and share the ledger and passively validate state.
Sentinels Network participants that are registered on-chain and rewarded; commonly used as
relays and availability peers for constrained clients.
Operational reading: Pillars and Nodes are the default archival substrate. Sentinels improve
reachability for constrained clients but do not replace archival incentives.
E.3 Retrieval paths for bounded verifiers
A bounded verifier (browser / mobile) is expected to use a layered retrieval strategy:
(cid:127) Fast path: fetch the latest Momentum header sequence (or a recent verified frontier) from any
available peer set; verify producer/consensus validity per the current rules.
(cid:127) Query path: request the minimum account-chain segment and the corresponding
commitment-membership proof(s) needed to answer the query.
38

Zenon Greenpaper Series
(cid:127) Proof path: if the query depends on p, retrieve p and vk (or a hashed reference to vk already committed
under r ).
C
(cid:127) External path: for CEV predicates, retrieve the relevant external header-chain suffix and required
inclusion proofs.
E.4 Adversarial availability and explicit refusal
If any required object is unavailable within the verifier’s bandwidth bound B (or outside its
V
declared history window D), the correct response is explicit refusal rather than an unverifiable
answer. The refusal codes in Appendix B correspond to the following DA failure classes:
Failure class Refusal surface
Outside declared REFUSED_OUT_OF_SCOPE
window D
Missing proof / REFUSED_DATA_UNAVAILABLE
segment
Missing external REFUSED_HEADER_MISSING
headers
Missing external REFUSED_PROOF_UNAVAILABLE
inclusion proof
Exceeds REFUSED_COST_EXCEEDED (or REFUSED_VERIFICATION_COST for external
resource bounds proofs)
E.5 Minimum-viable DA commitments (recommended)
To reduce “availability hand-waving” while staying consistent with Zenon’s Phase 0 roles, a
minimum-viable DA posture is:
(cid:127) Pillar archival expectation: Pillars are treated as archival by default; clients should assume
Momentum headers and recent account segments are widely replicated.
(cid:127) Node archival expectation: Nodes act as additional archival replicas and improve long-horizon
availability.
(cid:127) Redundancy principle: verifiers should request objects from k distinct peers (k‡2) before refusing,
subject to B .
V
(cid:127) Content-addressing: proof objects and large artifacts should be hash-addressed (or committed) so that
any mirror can serve them without trust.
39

Zenon Greenpaper Series
Appendix F: Economic Layer (Phase 0 /
Alphanet)
This appendix summarizes the on-chain incentive structure that supports liveness and data
retention in Phase 0. It is not a complete equilibrium analysis, but it grounds the roles referenced
in Appendix E in concrete, implemented mechanisms.
F.1 Emission schedule (daily distribution)
Zenon distributes fixed daily rewards on a 24-hour cadence:
Asset Daily distribution
ZNN 4,320 ZNN / 24h
QSR 5,000 QSR / 24h
These emissions are the primary budget used to reward consensus production, staking, and
availability roles.
F.2 Pillar incentives
Pillars participate in consensus by producing and validating Momentums, and they are explicitly
described as full archival nodes. Pillar rewards are split into:
(cid:127) Momentum-interval rewards: proportional to the number of Momentums produced during the reward
period.
(cid:127) Delegation rewards: distributed proportionally to delegated stake, subject to the Pillar’s configured
sharing percentages.
(cid:127) Uptime coupling: if a Pillar produces fewer than its expected Momentums, its rewards decrease
proportionally.
F.3 Registration costs and “skin in the game”
Phase 0 uses explicit stake and burn mechanics to bound Sybil participation:
(cid:127) Pillar stake: 15,000 ZNN required to register a Pillar (refundable on disassembly); QSR is burned to
create the Pillar slot and is not refundable.
(cid:127) Dynamic QSR registration cost: the chain exposes the current registration cost via the embedded
Pillar contract (e.g., embedded.pillar.getQsrRegistrationCost).
(cid:127) Node stake: Nodes (archival full nodes) require staked ZNN and QSR and are rewarded when eligible.
(cid:127) Sentinel stake: Sentinels are registered on-chain and can receive rewards; they are commonly used to
improve relay availability for light clients.
F.4 Who pays for proof generation?
40

Zenon Greenpaper Series
In Phase 0, “proof generation” is not a single global market: many proofs are produced by the
party that benefits from the claim (e.g., a zApp operator, bridge relayer, or client). The
protocol-level economic primitive available today is: (i) rewards for maintaining
consensus/availability roles (Pillars, Nodes, Sentinels) and (ii) content-addressed commitments
under Momentum roots so that third parties can mirror proofs without changing trust assumptions.
41

Zenon Greenpaper Series
Appendix G: Consensus Instantiation and Timing
fi
(Phase 0 Phase I)
The main body of this paper treats consensus abstractly via f (k). This appendix
consensus
instantiates the abstraction with Zenon’s current Phase 0 consensus, and summarizes the Phase I
roadmap direction.
G.1 Phase 0 (Alphanet) consensus summary
Zenon Phase 0 uses a delegated Proof of Stake (dPoS) approach where a set of staked nodes
(“Pillars”) take turns producing Momentum blocks on a strict schedule.
(cid:127) Scheduled production: time is divided into short slots (“ticks”); one Pillar is assigned per tick to
produce the next Momentum.
(cid:127) Weighted selection: higher-staked Pillars produce more frequently; selection draws from (i) the top 30
by delegated weight and (ii) additional Pillars outside the top 30 with lower frequency.
(cid:127) Archive expectation: Pillars are treated as full nodes that retain and archive the entire ledger history.
G.2 Momentum interval parameter
The published target Momentum interval is 10 seconds (rewards are commonly presented per
minute or per day). This parameter is the key bridge between abstract “step counts” and real-time
latency in the verification and availability bounds.
G.3 Finality and reorg considerations
Phase 0’s scheduled producer model reduces proposer conflicts, but practical finality still depends
on fork-choice rules and network conditions. For external verification (e.g., Bitcoin headers),
choose the confirmation depth k conservatively to tolerate transient forks in either system. The
refusal codes REFUSED_INSUFFICIENT_CONFIRMATIONS and
REFUSED_HEADER_MISSING are the verifier-visible surface for these finality gaps.
G.4 Phase I direction (Narwhal & Tusk)
Zenon documentation describes a roadmap transition toward a high-performance, leaderless
consensus influenced by Narwhal & Tusk, separating transaction dissemination from ordering to
improve throughput and resilience under asynchrony. This direction is consistent with the
dual-ledger separation emphasized in the main paper.
42

Zenon Greenpaper Series
Appendix H: Resource Budgets and Practical
Defaults
This appendix translates the abstract verifier bounds R = (S , B , C ) into concrete,
V V V V
implementation-friendly budgets. The values below are recommended starting points for
builders; they should be measured and tuned for target devices.
H.1 Suggested baseline budgets
Profile S_V (storage) B_V (bandwidth per C_V (compute per query)
query)
Browser-light £ 256 MB local £ 2–5 MB £ 250 ms (single-thread)
(indexed headers + small
cache)
Mobile-light £ 128 MB local £ 1–3 MB £ 300 ms
Desktop-light £ 512 MB local £ 5–10 MB £ 150 ms
H.2 How to account for C_V (verification cost)
A practical verifier should treat C as a “budget envelope” over a small set of primitives:
V
(cid:127) Hashing: SHA-256 / Blake2 (Merkle branches, header chaining).
(cid:127) Signature verification: producer signatures and transaction signatures (where applicable).
(cid:127) SNARK verification: verifying p against vk (bounded by circuit choice).
(cid:127) Parsing / decoding: bounded by message sizes that are already constrained by B .
V
Implementers should instrument end-to-end query verification time and expose it as
Cost_verify(p) in logs to support empirical tuning.
H.3 Refusal-rate measurement protocol (recommended)
To prevent “theoretically correct but unusable” configurations, clients should measure refusal
rates under realistic conditions:
(cid:127) Fix (S_V, B_V, C_V) and D for a device profile.
(cid:127) Replay a representative workload (wallet history, token transfers, CEV queries).
(cid:127) Report the fraction of queries returning each refusal code (Appendix B) and the median verification
time for successful queries.
43

Zenon Greenpaper Series
Appendix I: Comparative Notes (Verification,
Proving, DA)
This appendix provides a compact comparison along the axes most relevant to a verification-first
design: what must be verified by clients, who bears proving costs, and what DA assumptions
remain.
System Client verification Proving / execution cost DA assumption
(simplified)
Zenon (this paper) Bounded verification; explicit refusal Proof generation borne by claimants Availability via
when bounds or data are missing. / operators; consensus roles rewarded roles (Pillars
rewarded on-chain. /Nodes/Sentinels);
refusal on missing
data.
zkSync / StarkNet Verify validity proofs + data Heavy proving by DA published to L1;
(zk-rollups) commitments. sequencers/relayers; throughput and censorship resistance
latency depend on batching. depends on L1
inclusion.
Celestia-style DA layer Verify DA sampling / headers. Execution/proving off-chain on DA guaranteed by the
rollup chains; DA posts to the DA DA layer; applications
layer. must publish data
there.
Mina (succinct chain) Verify recursive proof of chain state. Recursive proof generation by block State availability still
producers. needed for user-level
proofs; often relies on
archival services.
I.1 Interpretation for Zenon builders
Zenon’s distinguishing choice is not “DA solved” but “DA made explicit”: when data or proofs
are unavailable within declared bounds, the system returns refusal instead of silently degrading
trust assumptions. This makes the availability layer a first-class engineering target (peer selection,
replication, archival incentives) rather than an implicit externality.
I.2 Source pointers (non-exhaustive)
For implemented Phase 0 parameters and roles, see: Zenon’s public site (daily distribution), the
Alphanet specification note (roles, target Momentum interval), and Zenon documentation pages
(consensus and embedded contracts).
44

Zenon Greenpaper Series
Appendix J: Contributions and Novelty Statement
This greenpaper is intentionally conservative in its primitives (SPV, membership proofs, validity
proofs, and light-client patterns). Its contribution is the unified verification-first interface: explicit
resource bounds, explicit refusal surfaces, and a single model that spans internal commitments
and external facts.
J.1 Claimed contributions (summary)
C1. Verification-first semantics: A verifier model parameterized by explicit resource bounds R_V =
(S_V, B_V, C_V) with refusal as a correctness outcome (not a failure).
C2. Dual-ledger split as a verification interface: Parallel execution is separated from sequential
commitment ordering, so clients verify commitments rather than replay full execution.
C3. Composable External Verification (CEV): A uniform predicate interface for external facts (e.g.,
Bitcoin SPV) with explicit refusal surfaces for missing headers/proofs.
C4. Bounded composability: A formal limit on verification depth under fixed budgets, enabling
engineering-time budgeting rather than implicit “infinite composability” assumptions.
45

Zenon Greenpaper Series
Appendix J (cont.): Novelty framing
J.2 Synthesis vs. incremental contribution
To avoid over-claiming novelty, the table below separates well-known building blocks from the
incremental value of this paper: formalizing them under R_V and refusal semantics so
implementers can reason about safety, liveness, and usability under constrained clients.
Prior art Where it appears This paper's incremental contribution
SPV / header-chain Bitcoin light clients, SPV Formalized as a CEV predicate with explicit
verification literature refusal codes and budget accounting under
R_V.
zk-rollups / validity zkSync, StarkNet, etc. Separated proving vs. verifying roles, and
proofs integrated verification into a refusal-first
client model.
Light clients / Many chains Unified “resume from local trust root” with
checkpoints adaptive retention and explicit out-of-scope
refusal.
Dual-ledger or layered Various L1/L2 hybrids Treated as a deterministic verification
designs interface: commitment ordering is primary;
execution is secondary.
46

Zenon Greenpaper Series
Appendix H (Addendum): Benchmark Harness and
Target Budgets
To close the gap between formal guarantees and deployment reality, the project should publish a
minimal, reproducible verifier harness. The harness is not a full node: it is a collection of
deterministic test vectors and microbenchmarks that measure costs corresponding to (S_V, B_V,
C_V) and refusal rates under retention policies.
H.A Harness outline (reproducible)
(cid:127) Test vectors: fixed Momentum header sequences, commitment trees, account-chain segments, and
CEV external headers/proofs.
(cid:127) Workloads: (i) header sync/verify, (ii) membership verification, (iii) CEV verification, (iv)
representative zApp proof verification.
(cid:127) Reporting: median + p95 timings, peak memory, bytes fetched, and refusal counts by code.
(cid:127) Environments: Chromium desktop, mid-range phone browser, and a low-power single-board node
(optional).
H.B Initial target budgets (design, to be validated)
| Workload | Metric | Target (design) | Measurement notes |
| -------- | ------ | --------------- | ----------------- |
Momentum header sync headers/sec; Desktop: Hash + signature verification only;
| (N headers) | p95 | 5k-20k/sec       | run in JS/WebAssembly; report |
| ----------- | --- | ---------------- | ----------------------------- |
|             |     | Phone: 1k-5k/sec | median and p95.               |
Commitment verify time; <1 ms; O(log m) Measure on typical m; include
| membership proof | bytes | hashes | deserialization cost. |
| ---------------- | ----- | ------ | --------------------- |
(Merkle branch)
CEV (BTC header suffix end-to-end <50 ms (cached Cache model: last K headers
| + SPV proof) | verify | headers)       | retained; cold path includes |
| ------------ | ------ | -------------- | ---------------------------- |
|              |        | <200 ms (cold) | download within B_V.         |
SNARK verification verify time; Class A: <250 ms Measure chosen proof system;
(representative zApp memory Class B: <1 s include wasm constraints; report
| proof) |     |     | failures as |
| ------ | --- | --- | ----------- |
REFUSED_COST_EXCEEDED.
Refusal rate under % queries <1% (steady-state Simulate partitions + retention
retention policy refused target) windows; report by refusal code
class.
47

Zenon Greenpaper Series
Appendix H (Addendum): Proof budget classes
The phrase “browser-native verification” should be interpreted as: verification is feasible for
proofs whose declared class fits within the verifier’s C_V budget. zApps should declare a proof
class; verifiers refuse when the class exceeds their budget.
Class Verification budget Intended environment Action if exceeded
A C_V £ 250 ms; small memory Browser / mobile default REFUSED_COST_E
XCEEDED
B C_V £ 1 s; moderate memory Mobile with batching; desktop REFUSED_COST_E
browser XCEEDED or batch
C Unbounded / delegated Native node / delegated verifier REFUSED_OUT_O
F_SCOPE unless
delegation policy
permits
48

Zenon Greenpaper Series
Appendix E (Addendum): Data Availability
Security Properties
Appendix E makes DA explicit via refusal. To reduce “DA hand-waving,” DA can be elevated to
named security properties that are testable and implementable incrementally.
E.A DA-Detectability (mandatory)
Definition (DA-Detectability). For any query q whose verification requires an object o (proof,
segment, header suffix), an honest verifier operating under (B_V, D) either (i) retrieves o from the
serving layer within its bounds, or (ii) returns an explicit refusal code indicating which
dependency is missing (e.g., REFUSED_DATA_UNAVAILABLE,
REFUSED_HEADER_MISSING). No silent degradation of trust is permitted.
E.B DA-Retrievability (recommended target)
Definition (DA-Retrievability). Under a stated redundancy model (e.g., k independent peers,
erasure coding with rate r), the probability of retrieving any required object within bounds
exceeds 1-e for typical workloads. This is an engineering target, validated by measurement
(refusal-rate benchmarks) rather than assumed.
E.C Minimum cryptographic enforcement path
(cid:127) Content addressing: proofs/segments are referenced by hash (or committed under r_C) so any mirror
can serve them without additional trust.
(cid:127) Redundant querying: verifiers request from k ‡ 2 distinct peers before refusing, subject to B_V.
(cid:127) Availability attestations (optional): nodes/pillars publish signed “I have blob X” claims; misbehavior
can be audited and penalized by policy.
(cid:127) Erasure-coded publication (optional): large artifacts are encoded into chunks; sampling-based audits
detect withholding with high probability.
49

Zenon Greenpaper Series
Appendix F & 3 (Addendum): Proof Economics and
Practical Bounded Composability
Bounding verification without addressing proving/serving incentives can create a two-tier system.
This addendum specifies implementable payment models and connects Theorem 3.1 to a usable
budgeting rule for composition depth.
F.A Who pays for proving? (three viable models)
(cid:127) User-pays: the claimant submitting a zApp result pays for proof generation and inclusion (simple;
aligns costs with demand).
(cid:127) Sponsor-pays: the zApp operator subsidizes proving to reduce user friction; costs recovered via
app-level fees.
(cid:127) Market provers: independent provers bid to generate proofs; a fee market clears based on proof
complexity and latency.
Recommended default for Phase 0: user-pays with optional sponsor subsidies. Fees should be
parameterized by (i) proof byte size, (ii) declared proof class, and (iii) worst-case verifier cost
envelope, so spam scales with the burden it imposes on bounded verifiers.
3.A Corollary (engineering bound for d_max)
Let each additional composition layer consume at least (DS, DB, DC) of storage, bandwidth, and
computation for a target verifier class. Then a conservative bound is:
Corollary. d_max £ min( floor(S_V/DS), floor(B_V/DB), floor(C_V/DC) ).
3.B Worked example (mobile verifier)
Example (illustrative, to be validated by the harness): suppose a mobile verifier declares C_V =
250 ms and B_V = 2 MB for a query. If one composition layer requires (i) one membership proof
verification (~1 ms), (ii) a cached external header check (~20 ms), and (iii) one Class A proof
verification (~150 ms), then DC » 171 ms and d_max is at most 1 under this budget. Higher-depth
composition would require batching, delegation, or a larger C_V class.
50
