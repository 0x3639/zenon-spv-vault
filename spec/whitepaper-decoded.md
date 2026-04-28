and internal consistency.

What This Document Is

Reader’s Guide — How to Read This Document

This document is a community-authored reconstruction of the original Network of Momentum (NoM)

to the canonical text. Readers should approach it as an interpretive aid designed to clarify intent, structure,

whitepaper released circa 2020. It is not a protocol specification, implementation guide, or amendment

Status: Community-authored reconstruction (interpretive, non-normative). Purpose: Decode and
clarify the original Network of Momentum (NoM) / Zenon early whitepaper intent (circa 2020).

The Network of Momentum (NoM) — Decoded and Expanded
Whitepaper (Community Reconstruction)

DRAFT
COMMUNITY

Where this document appears more concrete than the original draft, it does so only to explain constraints,

• A separation of what the original paper states from what logically follows from those statements.

• A guide for reasoning about NoM without presuming its current implementation status.

• A structured attempt to make implicit architectural assumptions explicit.

• A decoding of an intentionally under-specified research draft.

• Not a claim that all described mechanisms exist today.

• Not an assertion of “official” Zenon design authority.

What This Document Is Not

not to introduce new mechanics.

• Not a normative specification.

• Not a new protocol proposal.

How to Read Technical Sections

Canonical vs Interpretive Content

Throughout the document, content is categorized into three classes:

intentionally incomplete. These are framed as questions, not answers.

Readers are encouraged to distinguish these categories when forming conclusions.

coexist coherently. These do not add new protocol primitives, actors, or guarantees.

clarify relationships and invariants but should not be treated as implementation-level definitions.

1. Canonical Statements explicitly present in the 2020 whitepaper or directly paraphrased from it.

3. Not Specified in Draft (Open Questions) Areas where the original draft is silent, ambiguous, or

2. Interpretive (Non-normative) Logical elaborations intended to clarify how canonical statements can

• Mathematical expressions in this document are illustrative abstractions, not binding specifications. They

• Security analysis is aligned strictly to attack classes explicitly listed in the original draft. No new threat

DRAFT
COMMUNITY

If a mechanism appears unusually abstract or incomplete, this likely reflects faithful preservation of the

It assumes familiarity with distributed systems and decentralized consensus but does not assume prior agree-

• Consensus descriptions explain how the system could reason about agreement, not how to code it.

• Developers reasoning about what NoM permits, not what it mandates.

• Researchers evaluating verification-first and dual-ledger architectures.

• Readers seeking clarity beyond high-level summaries.

ment with any specific interpretation.

original draft’s level of detail.

This document is written for:

Intended Audience

models are introduced.

How to Disagree Productively

It does not claim Zenon was fully specified in 2020

It does not claim REFUSE semantics were formally defined

2. Identify which assumptions are interpretive rather than canonical.

1. Point to specific canonical text that contradicts the reconstruction.

3. Propose alternative interpretations that satisfy the same constraints.

Comparison Index — What This Reconstruction Does Not Claim

This document is intended to be falsifiable through citation, not authoritative by assertion.

The reconstruction explicitly treats NoM as a research architecture, not a finalized protocol.

Disagreement is expected and welcome. Readers who contest interpretations are encouraged to:

This index clarifies common misreadings by explicitly stating positions this document does not take.

DRAFT
COMMUNITY

Three-outcome verification is presented as an interpretive model consistent with bounded verification con-

zApps are treated as downstream, optional, and execution-layer concerns. Consensus correctness does not

Incentives, proof markets, and pricing dynamics are discussed only where implied and are explicitly marked

All cryptographic mechanisms referenced are already implied or mentioned in the canonical draft.

Unikernels are presented as illustrative execution environments, not required infrastructure.

No throughput, latency, or scaling figures are asserted beyond qualitative behavior.

It does not introduce new cryptographic primitives

It does not claim zApps are consensus-critical

It does not override implementation reality

It does not claim performance guarantees

It does not redefine Zenon’s economics

straints, not as canonical doctrine.

It does not mandate unikernels

depend on their behavior.

as open research areas.

and expected.

Summary Statement

It is an aid to understanding — not a declaration of truth.

and clarifies structure where the original draft implies structure without specification.

serting ownership over its evolution. It preserves ambiguity where the original draft preserves ambiguity

This reconstruction aims to make the internal logic of the Network of Momentum intelligible without as-

Discrepancies between this reconstruction and current Zenon implementations are acknowledged as possible

DRAFT
COMMUNITY

mechanisms.

Preface

rather than a finalized system.

Canonical (from the 2020 draft)

Reconstruction (Interpretive, Non-normative)

• Core ideas include a dual-ledger design, distributed actor model, and verification-driven correctness.

• The original draft distinguishes between what the architecture allows versus what is already implemented.

• The canonical whitepaper presents the Network of Momentum (NoM) as a partially specified architecture

• The document aims to communicate directional principles and invariants, not a complete execution model.

materials (circa 2020) leave implicit. Those materials outline a conceptual foundation for the Network of

Momentum but intentionally omit full execution semantics, light-client rules, or heterogeneous verification

system. Instead, it functions as an architectural decoding—an effort to make explicit what the early Zenon

This paper is not a proposal for a new distributed ledger architecture, nor an announcement of a finalized

DRAFT
COMMUNITY

appears more concrete than the original whitepaper, such details should be read as interpretive formaliza-

No new primitives, assumptions, or consensus mechanisms are introduced here. When this reconstruction

4. Preserve distinction between architectural capabilities (what the system allows) and implementation

3. Developers reasoning about the architecture’s permissible designs without presuming their current

tions—logical completions of implied design constraints—not as additions to the canonical text.

2. Clarify ambiguous or implied aspects of consensus, verification, and actor interaction.

2. Researchers evaluating the consistency of dual-ledger and verification-first systems.

1. Readers seeking clarity beyond high-level marketing or conceptual summaries.

The purpose of this reconstruction is to make NoM’s internal logic legible for:

3. Formalize behaviors that were informally or contextually described.

1. Extract architectural invariants from the canonical text.

Goals of this reconstruction:

status (what is built).

deployment.

emergent.

(block-lattice).

Abstract

Canonical (from the 2020 draft)

Not Specified in Draft (Open Questions)

• Extent of canonical formalization for light clients and partial verification.

• Emphasizes security, scalability, and decentralization as guiding design principles.

• Whether “bounded verification” was a fully intended design primitive or inferred retrospectively.

• Introduces multiple classes of network participants (“actors”) with different verification responsibilities.

• Whether the “REFUSE” verification mode (as later discussed in community materials) was implicit or

• Describes a dual-ledger system separating consensus ordering (meta-layer) and transactional execution

DRAFT
COMMUNITY

• An actor hierarchy spanning full consensus participants (Pillars), relays (Sentinels), and light verifiers

• A dual-ledger architecture consisting of a meta-DAG (for consensus ordering) and a block-lattice (for

These verification semantics and the explicit notion of “REFUSE” are interpretive constructs, included to

• Bounded verification semantics allowing nodes to maintain correctness under constrained resources, using

• States that the paper is a research draft—not a deployment specification.

explain the correctness guarantees implied by the canonical design.

• Canonical content — information directly in the 2020 draft.

This reconstruction clarifies the implied structure of NoM:

The document maintains a strict separation between:

Reconstruction (Interpretive, Non-normative)

three outcomes: accept, reject, or refuse.

transactional state).

(Sentries).

added by later interpreters.

Not Specified in Draft (Open Questions)

• Interpretive content — logical elaborations for clarity.

• Open questions — intentionally unspecified or unresolved aspects of the 2020 design.

• How the meta-DAG’s finality interacts with partial proofs during asynchronous operation.

• Whether “three-outcome verification” (accept/reject/refuse) was formally present in the original draft or

DRAFT
COMMUNITY

operations.

and DAGs.

global synchronization.

I. Introduction

Canonical (from the 2020 draft)

• States four guiding design principles:

4. Verifiability: Support for bounded, resource-limited verification.

1. Decentralization: Trustless operation without central coordination.

2. Scalability: High throughput and low latency across large networks.

3. Security: Resistance to Sybil, double-spend, and denial-of-service attacks.

• Suggests that NoM overcomes these limits via a dual-layer ledger enabling asynchronous and parallelized

• Notes that traditional blockchains (e.g., Bitcoin, Ethereum) suffer scalability limits due to linearity and

• Introduces the Network of Momentum as a decentralized ledger system combining aspects of blockchains

DRAFT
COMMUNITY

structure explicitly separates global consensus ordering from local transactional execution, enabling each

Distributed ledger technology (DLT) evolved rapidly from Bitcoin’s linear proof-of-work chain to diverse

architectures that seek parallelism and asynchrony. NoM belongs to this second wave—its dual-ledger

• Together, they yield a distributed system that can tolerate heterogeneous participants, intermittent connec-

Conceptually, NoM’s position among DLT families can be seen as a synthesis:

• The block-lattice provides user-level transaction histories for each account.

• The meta-DAG handles consensus events, ordering, and epoch transitions.

• Like blockchains, it maintains strong ordering and finality guarantees.

Reconstruction (Interpretive, Non-normative)

• Like DAGs, it supports parallel updates.

tivity, and variable resource capacities.

component to scale independently.

Under this design:

2020 draft.

Context (Non-canonical background)

NoM from throughput-optimized systems.

• Blockchain: Linear, globally replicated history.

To situate NoM in broader distributed systems research:

• Block-lattice: Each user maintains an account-chain (e.g., Nano).

• DAG-based ledgers: Non-linear structures permitting concurrency (e.g., Zilliqa).

• Like agent-centric systems, it allows local state verification and asynchronous operation.

• Agent-centric ledgers: Validation occurs per-agent rather than globally (e.g., Holochain).

• BFT consensus: Systems using Byzantine Fault Tolerance mechanisms (e.g., Tendermint).

This contextual framing is non-canonical—provided solely for comparison and not drawn directly from the

The introduction of a verification-first architecture—where correctness is prioritized over synchrony—distinguishes

DRAFT
COMMUNITY

• Indicates that separating ordering (meta-layer) from execution (transaction layer) provides modularity,

• How the system prioritizes between decentralization and latency under adverse conditions.

• Introduces several ledger archetypes: blockchain, DAG, block-lattice, and others.

• How “heterogeneous verification” is implemented or incentivized across actors.

II. Ledger Structures and Design Rationale

• Whether NoM assumes partial synchrony or complete asynchrony.

• Describes a dual-ledger architecture consisting of:

2. A block-lattice for transactional storage.

1. A meta-DAG for consensus ordering.

Not Specified in Draft (Open Questions)

scalability, and improved data locality.

Canonical (from the 2020 draft)

sequence.

A. Blockchain

in the block-lattice.

B. Directed Acyclic Graph (DAG)

Reconstruction (Interpretive, Non-normative)

through linear ordering, but limits scalability because every node must process and store all transactions in

The traditional blockchain structure (as in Bitcoin, Ethereum) forms a sequential chain of blocks, each

• Highlights that consensus finality occurs in the meta-DAG, while user transactions are executed and stored

referencing its predecessor through a cryptographic hash. This structure provides immutability and security

exist concurrently. Each transaction references multiple predecessors, forming a graph structure without cy-

DAG-based systems attempt to solve blockchain scalability by allowing multiple branches of transactions to

Canonical interpretation: The 2020 draft acknowledges the blockchain’s reliability but identifies linearity
as the bottleneck preventing scalability and parallel verification.

DRAFT
COMMUNITY

Canonical reference: The draft uses DAG principles for NoM’s meta-layer but adds stake-weighted virtual
voting to reimpose determinism.

Interpretive clarification: The canonical whitepaper implies that each account-chain is part of a larger mesh
coordinated by the meta-DAG, which provides transaction ordering and prevents inconsistencies.

cles. This design improves throughput but increases the complexity of achieving consistent global ordering

In a block-lattice architecture, each user controls an independent account-chain recording personal transac-

tions asynchronously. Each send or receive transaction is independent and can be appended without waiting

for network-wide consensus. The block-lattice model enables high throughput, minimal contention, and

1. A meta-DAG — governs ordering, epoch transitions, and consensus decisions.

localized verification—forming the foundation for NoM’s transactional layer.

and raises the possibility of conflicting subgraphs.

NoM combines both paradigms by introducing:

D. The Dual-Ledger Approach

C. Block-Lattice

DAG

Blockchain

Advantages

Ledger Type

Disadvantages

Benefits inferred from canonical structure:

• Lower synchronization costs across the network.

states, etc.) occurs asynchronously in the block-lattice.

• Scalability through concurrent transaction processing.

• Modular separation of consensus logic from state management.

2. A block-lattice — stores confirmed transactional states per account.

• Improved efficiency for light clients that only need account-specific data.

The interaction between these ledgers decouples agreement from execution. Consensus decisions (what

transactions are valid and in what order) occur on the meta-DAG, while execution (updating balances, zApp

DRAFT
COMMUNITY

Simple, secure, and widely un-
derstood
Parallel
throughput
Independent account chains, lo-
calized verification
Combines scalability with deter-
minism

Linear bottleneck, limited scala-
bility
Ordering complexity, fork risk

• The exact interface between the meta-DAG and block-lattice (how ordering proofs are referenced in

• Whether epoch boundaries in the meta-DAG explicitly map to checkpoints in the block-lattice.

III. Consensus Algorithms and Protocol Families

• Whether the two ledgers are stored separately or as an integrated data structure.

Coordination between layers
adds complexity

• How light clients efficiently synchronize across both layers.

Not Specified in Draft (Open Questions)

Table 1: Comparison of ledger types

Requires external ordering logic

Canonical (from the 2020 draft)

NoM Dual-Ledger

account-chains).

Block-Lattice

transactions,

high

despite faults).

A. Consensus Properties

Reconstruction (Interpretive, Non-normative)

paradigms to satisfy different architectural goals.

ance decentralization, scalability, and energy efficiency.

(PoS), and hybrid Byzantine Fault Tolerance (BFT) systems.

• References “virtual voting” as an implicit ordering mechanism embedded within the meta-DAG.

• Defines consensus as the process by which distributed participants agree on a consistent system state.

• Mentions several families of consensus mechanisms including Proof-of-Work (PoW), Proof-of-Stake

• Indicates that NoM leverages hybrid principles—combining PoW and stake-based virtual voting—to bal-

der without centralized control. NoM’s design follows a hybrid approach, blending multiple consensus

Consensus determines how participants in a decentralized network achieve agreement on transaction or-

• Notes that consensus ensures both safety (agreement among honest nodes) and liveness (continued progress

DRAFT
COMMUNITY

• Denial-of-Service (DoS) Resistance: Maintain functionality even under resource exhaustion attempts.

• Sybil Resistance: Prevent identity inflation; nodes cannot gain influence by creating more identities.

• Fault Tolerance: Maximum Byzantine fraction tolerable while maintaining correctness.

• Censorship Resistance: No participant can unilaterally suppress valid transactions.

• Adversary Resistance: Tolerate Byzantine faults and arbitrary node misbehavior.

• Finality: Once finalized, a transaction remains immutable in the ledger.

• Accountability: Actions are cryptographically signed and attributable.

• Scalability: Ability to maintain throughput as participation grows.

Core objectives for a decentralized consensus protocol include:

• Latency: Time from transaction broadcast to confirmation.

• Throughput: Transactions processed per second.

Performance indicators often discussed:

C. Proof-of-Stake (PoS)

B. Proof-of-Work (PoW)

making attacks economically expensive.

Interpretive Clarification: In NoM, PoW has two layers:

to gain block production or voting rights, proportionally to their holdings.

1. Pillar PoW: Used for epoch completion and participation in consensus.

2. Sentinel PoW links: Used to throttle transaction submission and prevent spam.

Canonical: The draft references PoW as an anti-Sybil and spam-resistance mechanism.

Nodes must expend measurable energy or computational effort to submit valid blocks or proofs.

This two-level PoW structure ensures that both consensus and transaction propagation are resource-bound,

PoW involves solving computational puzzles whose solutions are costly to generate but cheap to verify.

PoS replaces computational expenditure with economic commitment. Participants lock collateral (“stake”)

DRAFT
COMMUNITY

Canonical notes: The draft references stake-weighted voting and indicates that adding more nodes does not
increase voting power. Thus, Sybil attacks do not yield advantage since consensus power scales with staked

Interpretive: Not adopted directly by NoM, but useful context for understanding hybridization. Delegates
introduce centralization trade-offs which NoM avoids by distributing consensus responsibilities across many

Interpretive: NoM applies PoS in virtual voting: each Pillar’s voting weight corresponds to its stake, and
consensus decisions depend on cumulative stake-weighted support.

for comparison. The 2020 draft does not indicate their direct use in NoM. They are presented to highlight

Other mechanisms (e.g., Proof-of-Storage, Proof-of-Retrievability, Proof-of-Elapsed Time) are referenced

Canonical: Mentioned briefly in comparison as a scalability-oriented model using elected delegates.

potential adaptations or extensions of PoW/PoS mechanics for specialized applications.

D. Delegated Proof-of-Stake (DPoS)

E. Proof-of-X Variants (Context)

value, not node count.

Pillars.

H. Virtual Voting

in the meta-DAG structure.

F. Hybrid BFT Consensus

G. Cellular Automata Consensus (Context)

local interactions yield eventual global agreement without centralized orchestration.

Canonical: The draft discusses combining PoW or PoS with Byzantine Fault Tolerance (BFT).

Referenced as an abstract model for local update rules achieving global convergence. This concept supports

the interpretive view that NoM’s meta-DAG consensus can be viewed as a distributed automaton, where

Interpretive: NoM’s hybridization separates validator selection (stake-weighted identity) from consensus
execution (virtual voting). BFT-like safety emerges through deterministic supermajority voting embedded

Context (Non-canonical background): Systems like Zilliqa (PoW-BFT) and Tendermint (PoS-BFT) repre-
sent similar hybrid approaches but are not directly implemented in NoM.

DRAFT
COMMUNITY

• Nodes deduce votes based on observed data structures (e.g., DAG topology), minimizing communication

• Consensus is achieved when all honest Pillars converge on identical deterministic ordering derived from

• “Virtual voting” replaces explicit message-passing with inference from message histories.

• Each Pillar derives a view of others’ votes implicitly from received DAG links.

Interpretive: In NoM, the meta-DAG itself embodies this mechanism:

• Scales with DAG propagation rather than quorum chatter.

• Pillars broadcast events (transactions, PoW completions).

Canonical (explicitly stated in 2020 draft):

• Eliminates explicit vote messages.

these shared observations.

Properties:

overhead.

Advantages

Disadvantages

Consensus Type

Proof-of-Work
Proof-of-Stake

High Sybil resistance
Energy-efficient

Not Specified in Draft (Open Questions)

Table 2: Comparison of consensus types

• Thresholds for PoW difficulty adjustment within epochs.

• Provides asynchronous BFT-like safety in open networks.

• How randomness (if any) influences tie-breaking in virtual voting.

Delegated PoS
BFT
Virtual Voting
Cellular Automata

• Exact function describing how stake weight maps to voting influence.

• The extent to which the hybrid PoW–PoS mechanism is finalized versus conceptual in the 2020 draft.

High scalability
Strong consistency
Scalable, implicit consensus
Local rules, emergent order

Energy cost, low throughput
Requires economic security as-
sumptions
Centralization risk
High communication cost
Requires high DAG connectivity
Sensitive to topology and latency

DRAFT
COMMUNITY

• Describes several classes of network actors—each responsible for specific roles in communication, veri-

• Indicates that consensus safety and liveness depend on the assumption that less than one-third of total

• Describes the network as asynchronous, with no global clock or guaranteed message timing.

• Mentions Sentinels as intermediaries that relay data and perform partial proofs.

• Mentions lightweight observers capable of verification within resource limits.

IV. Prerequisites and Actor Model

• Identifies the “Pillar” as the full consensus participant.

Reconstruction (Interpretive, Non-normative)

Canonical (from the 2020 draft)

stake behaves maliciously.

fication, and consensus.

Pillar

Actor

Sentry

Sentinel

Representative

Canonical Role

A. Definitions

Consensus participant

Optional intermediary

Table 3: Actor roles in NoM

Reconstruction Description

Each node operates within explicit resource bounds defined by:

Relay and proof construc-
tor
Lightweight verifier

A node is any software entity executing the NoM protocol. Nodes differ in storage, computation, and
connectivity capacity, leading to the hierarchical actor model summarized below.

Maintains both ledgers (meta-DAG +
block-lattice); executes virtual voting; fi-
nalizes epochs.
Relays transactions, constructs PoW frag-
ments (“links”), serves proofs to verifiers.
Maintains pruned ledger view, verifies lo-
cally under resource constraints.
Provides transaction relay and proof ac-
cess for light clients; non-consensus par-
ticipant.

DRAFT
COMMUNITY

where SV is storage, BV bandwidth, and CV computational capacity. Verification performance and decision
modes depend on these local limits.

A supermajority condition is reached when the cumulative active stake of agreeing Pillars exceeds two-thirds

Representatives serve as accessible endpoints for light clients, helping them broadcast transactions and

retrieve verification proofs. Although they aid in network propagation, correctness does not depend on their

This threshold ensures deterministic agreement across all honest Pillars.

• δ: small positive margin ensuring decisiveness

• Wϵ: total active stake in epoch ϵ

B. Supermajority Definition

C. Representative Role

RV = (SV , BV , CV )

of the total:

Wϵ + δ

where:

wi ≥

(cid:88)

2
3

E. Epoch

D. Transaction Types

• Pillars perform PoW work.

Canonical transactions include:

1. Send/Receive transfers between account-chains.

3. Smart interactions (zApps), representing application-level logic.

2. Protocol messages marking PoW completions or epoch boundaries.

honesty—clients always verify proofs locally (or refuse when incomplete).

Each transaction contains sender/receiver addresses, balances, signatures, and PoW link data.

An epoch is a discrete period used for grouping transactions and finalizing consensus. During each epoch:

DRAFT
COMMUNITY

Canonical: Described as consensus where votes are inferred, not transmitted. Each Pillar observes other
Pillars’ PoW completions and transaction acknowledgments within the DAG, deducing majority opinion

Interpretive: The DAG’s topology acts as a record of message causality, from which all honest Pillars
independently infer identical results.

• Once a supermajority of Pillars complete their PoW, the epoch finalizes, and the next begins.

Epochs serve as synchronization boundaries for virtual voting rounds.

• Epoch completion (“finishing PoW”) messages, and

• Transactions propagate and accumulate.

G. Broadcast Mechanism

Broadcasts disseminate:

F. Virtual Voting

deterministically.

maliciously.

chronous conditions.

H. Network Model

• No timing guarantees are assumed.

• Nodes may join or leave at any time.

• Transaction summaries for inclusion.

The network is open and asynchronous:

I. Verification and Resource Bounds

• Messages are authenticated via asymmetric cryptography.

Reliable broadcast ensures every honest node eventually receives identical finalized data, even in asyn-

Safety and liveness hold under the honest-majority assumption: fewer than one-third of total stake acts

DRAFT
COMMUNITY

REFUSE maintains correctness by preventing unsound conclusions when proofs are incomplete.

Each node’s verification function operates within resource constraints:

• Probability of correct verification approaches 1 for honest nodes.

• Adequate connectivity and complete proof access.

• REFUSE: Insufficient data/resources to verify.

1. Regime I — Connected Verification

Verifyv(p) → {⊤, ⊥, REFUSE}

J. Verification Regimes

• ⊥: Determined invalid.

• ⊤: Verified as valid.

Where:

respond for rewards or fees.

• Limited bandwidth or connectivity.

2. Regime II — Bounded Verification

K. Proof Availability and Incentives

This ensures correctness under partial knowledge.

Pr[Verifyv(p) = ⊤ | honest network] → 1

L. Consensus Independence from Verification

• Nodes may output REFUSE rather than incorrect decisions.

This mechanism creates an economically self-correcting proof market.

When a verifier emits REFUSE, it signals market demand for missing proofs—creating an incentive to

Proofs represent economic goods. Pillars and Sentinels are incentivized to supply proofs to light clients.

DRAFT
COMMUNITY

Execute consensus, maintain dual ledgers, finalize epochs.
Relay transactions, construct PoW links, supply proofs.
Verify account-level transactions within resource bounds.
Connect clients to the network; correctness remains local.

Global consensus progresses regardless of local verifier capability. Even if some verifiers operate under

bounded verification (and refuse some proofs), global ordering and finality are unaffected. This separation

Light clients (Sentries) often operate via browser or mobile interfaces. They use WebAssembly or similar

environments to perform cryptographic verification. They can verify locally or refuse safely—preserving

ensures system-wide determinism while supporting heterogeneous devices.

Pillars
Sentinels
Sentries
Representatives

N. Actor Responsibilities Summary

correctness even in intermittent connectivity.

M. Browser and Mobile Clients

Table 4: Actor responsibilities

Responsibilities

Actor

Canonical (from the 2020 draft)

Not Specified in Draft (Open Questions)

• Describes a dual-ledger architecture consisting of:

• Cryptographic construction of PoW link fragments.

• Criteria for Representative selection or reputation weighting.

• Detailed economics of proof supply and pricing mechanisms.

capacity, while lightweight verifiers preserve universal accessibility.

• Relationship between stake-weighted voting and epoch boundaries.

• Extent of fault tolerance if multiple Pillars drop out simultaneously.

V. NoM Ledger and Consensus Mechanism

This hierarchical model ensures that correctness and scalability coexist—heavy nodes provide consensus

DRAFT
COMMUNITY

• Indicates that consensus proceeds in epochs, each culminating in a PoW completion broadcast by Pillars.

• States that a supermajority of Pillar stake finalizes each epoch, ensuring agreement and immutability.

• Each account maintains an independent chain recording send/receive events and balance updates.

• Indicates that consensus safety holds if fewer than one-third of total stake is Byzantine.

• References virtual voting and shared coin rounds as the theoretical basis for finality.

• Transactions can occur asynchronously without waiting for global confirmation.

The Network of Momentum (NoM) employs two ledgers working in concert:

2. The block-lattice, which stores and executes user-level transactions.

1. The meta-DAG, which orders and finalizes transactions.

Reconstruction (Interpretive, Non-normative)

A. The Dual-Ledger Architecture

1. Transactional Ledger (Block-Lattice)

as:

• Account balances.

edgments, and PoW commitments.

2. Consensus Ledger (Meta-DAG)

B. Ledger Query Model and Proof Retrieval

• Each account-chain is cryptographically linked through signatures and PoW fragments.

• The meta-DAG provides a consistent, deterministic ordering of all finalized transactions.

• Maintained by Pillar nodes, it records consensus events such as epoch completions, transaction acknowl-

Clients query the ledger through Representatives (typically Sentinels) to obtain verifiable information, such

Interpretive Clarification: This architectural separation enables execution decoupling—transactions can
propagate and execute locally, while consensus handles ordering and conflict resolution at the global level.

DRAFT
COMMUNITY

The meta-DAG orders transactions deterministically via virtual voting. Once consensus finalizes an epoch,

Proof bundles are designed to be modular—a verifier can confirm local state without downloading the global

Π(Q) = {commitments, signatures, PoW metadata, epoch references}

all transactions decided in that epoch are appended to the block-lattice.

if valid within resource constraints, or REFUSE if incomplete.

C. Interaction Between Dual Ledgers

• Epoch and finality confirmations.

• Inclusion proofs for transactions.

Each query returns a proof bundle:

Verification is performed locally:

Verifyv(Π(Q)) = ⊤

ledger.

Let:

Node Type

Verification Scope

Resource hierarchy:

∀t ∈ Oϵ(Dϵ) : append(t)

Pillar
Sentinel
Sentry

Each finalized transaction is appended:

Table 5: Verification scope by node type

• Oϵ: deterministic ordering function.

• Dϵ: transactions decided in epoch ϵ.

D. Verification Scope by Node Type

This ensures every honest node shares an identical ledger state after finalization.

Full verification (signatures, PoW, voting, epoch transitions).
Transaction and PoW link verification; partial ledger validation.
Account-level transaction and balance verification.

DRAFT
COMMUNITY

Interpretive Description: Each transaction accumulates PoW contributions as it travels through the network.
PoW links contribute to accumulated work that helps determine transaction eligibility and ordering priority.

where wj represents individual work contributions. A transaction becomes eligible once accumulated work
meets network requirements, tying resource expenditure to transaction propagation and ensuring anti-spam

The draft does not fully specify the exact format or cryptographic structure of these links.

Canonical: PoW links serve as Sybil and spam mitigation.

This allows scalability without compromising correctness.

Total accumulated work can be represented as:

Not Specified in Draft (Open Questions)

E. Proof-of-Work Links

≫ R(sentinel)
V

≫ R(sentry)
V

enforcement.

R(pillar)
V

W (t) =

h
(cid:88)

wj

j=1

other factors.

F. Conflict Resolution

Not Specified in Draft (Open Questions)

• Complete specification of the deterministic ordering function.

• Whether PoW links carry explicit Sentinel identity or are anonymous.

• Detailed per-link field structure (nonces, signatures, identity binding).

• How work contributions are cryptographically verified and aggregated.

referenced earlier in the consensus mechanism to select one valid transaction and discard others.

guity. The draft references these ordering rules but does not provide their complete specification.

When conflicting transactions arise (e.g., double-spends), the network applies predefined deterministic rules

All honest Pillars applying these rules reach identical outcomes, ensuring conflict resolution without ambi-

• Whether ordering considers accumulated PoW weight, timestamps, transaction depth, hash values, or

DRAFT
COMMUNITY

If a Pillar hasn’t completed its PoW by this time, it aborts computation and synchronizes to the next epoch.

• Priority and composition of multiple tiebreak criteria if present.

Consensus proceeds through epochs. Each Pillar maintains:

G. Consensus Process Overview

• Received PoW completions (Fϵ).

• Local transaction pool (Tϵ).

the epoch finalizes.

• Epoch index (ϵ).

Wϵ + δ

Once:

wi ≥

(cid:88)

i∈Fϵ

2
3

i∈P

2
3

(cid:88)

O(p)

Wϵ + δ

∀ honest p, q

ϵ = O(q)
ϵ

1[t ∈ Know(i, ϵ)] · wi ≥

transaction knowledge converges.

H. Knowledge Convergence Across Epochs

I. Virtual Voting and Deterministic Ordering

All Pillars deterministically derive the same transaction order:

This ensures eventual convergence to a single canonical ordering.

Consensus therefore requires no explicit votes—only shared observation of DAG structure.

Due to asynchronous communication, not all Pillars see identical data instantly. Over successive epochs,

Let Know(p, ϵ) represent transactions known to Pillar p at epoch ϵ. A transaction becomes decidable once:

DRAFT
COMMUNITY

The draft references a shared coin round as a termination mechanism if consensus stalls (e.g., due to parti-

tions or DoS). This mechanism is mentioned as providing eventual convergence guarantees but the specific

Pillars complete proof-of-work as part of epoch finalization. The draft indicates that difficulty adjusts based

on epoch completion times to maintain stable consensus intervals.

K. Pillar Proof-of-Work and Difficulty Adjustment

• How the coin round interacts with existing consensus state.

• Detailed algorithmic steps for the shared coin mechanism.

This is what grants NoM’s consensus its “virtual” nature.

• Randomness source and generation procedure.

algorithmic details are not provided in the draft.

• Conditions triggering shared coin activation.

J. Shared Coin for Termination

Not Specified in Draft (Open Questions)

Not Specified in Draft (Open Questions)

L. zApps and Unikernel Execution

• Specific difficulty adjustment formula or parameters.

Pillar-level PoW computation requirements for subsequent epochs.

• Whether Pillars can delegate or outsource PoW computation to pools.

• How difficulty changes propagate and achieve consensus among Pillars.

• Relationship between Pillar PoW difficulty and transaction PoW link difficulty.

Canonical mention: zApps (application-layer logic) exist but are not part of core consensus.

Interpretive Description: Difficulty adjustment follows a feedback mechanism where faster epoch times
increase difficulty and slower times decrease it, stabilizing the network rhythm over time. This affects

Interpretive expansion: zApps execute in sandboxed “unikernel” environments to ensure deterministic, iso-
lated computation. Each application state follows:

DRAFT
COMMUNITY

Light clients can verify or refuse (REFUSE) if resource limits are exceeded—preserving local correctness

State(A) ∈ {Proposed, Provisioned, Running, Checkpointed, Terminated}

A gas-like fee model funds execution, ensuring bounded computation.

zApps may emit cryptographic proofs of state transitions:

M. Proof-Native Verification for zApps

Execution costs resources according to:

Price(A) = (pcpu, pmem, pnet, pdisk)

producing proof πS such that:

regardless of resource capacity.

Check(S, πS) = ⊤

S : (sin, x) (cid:55)→ sout

N. Summary

• PoW-based Sybil resistance,

nodes with diverse capabilities.

• Specific proof format for zApps.

• Stake-weighted virtual voting, and

• Deterministic epoch-based ordering.

Not Specified in Draft (Open Questions)

• Randomness source for shared coin rounds.

The Network of Momentum’s consensus mechanism merges:

• Full mathematical definition of Oϵ (ordering function).

• Whether the meta-DAG references block-lattice hashes directly or indirectly.

Its dual-ledger architecture provides scalable, verifiable, and fault-tolerant distributed consensus, supporting

DRAFT
COMMUNITY

ministic ordering (meta-DAG) to maintain correctness and progress. Each canonical attack class is outlined

NoM’s security model combines economic disincentives (PoW), stake-weighted voting (PoS), and deter-

• Each subsection (“Possible Attacks”) corresponds to a distinct vector: double spending, forking, DNS,

– Consensus guarantees are probabilistic but converge deterministically under normal conditions.

• The draft’s language focuses on qualitative resilience rather than formal proofs.

– Safety and liveness depend on less than one-third Byzantine stake.

• The security section explicitly outlines possible attack vectors.

below with reconstruction commentary and open questions.

eclipse, Sybil, DoS, consensus delay, and majority control.

– An asynchronous network (no timing guarantees).

Reconstruction (Interpretive, Non-normative)

• The canonical assumptions include:

VI. Security Model

Canonical (from the 2020 draft)

consideration for malicious actors.

A. Double-Spending Attack

Not Specified in Draft (Open Questions):

B. Forking (Ledger Cloning) Attack

• The exact specification of conflict resolution rules.

• The “penalizing algorithm” is mentioned but undefined.

Thus, only one transaction survives, preventing double spend.

• Whether offenders lose stake, PoW credit, or reputation is unspecified.

valid one, discarding the other using predefined rules. It mentions a potential penalizing algorithm under

Canonical Claim: The draft indicates that conflicting transactions (“double spends”) are resolved determin-
istically after several epochs. All honest Pillars eventually learn both transactions and converge on a single

Clarification (Interpretive): Convergence depends on the supermajority condition. As both conflicting trans-
actions propagate, every honest Pillar observes both and applies the deterministic resolution mechanism.

DRAFT
COMMUNITY

Clarification (Interpretive): Ledger weight represents the aggregate work across Pillars and transaction
links. Multi-source synchronization prevents deception because an attacker cannot easily fabricate PoW

The heavier ledger (with greater accumulated PoW) is considered canonical. New nodes synchronize with

• The exact synchronization or bootstrap algorithm is not given.

Canonical Claim: Forking is mitigated by dual PoW layers:

• “Several Pillars” is undefined—minimum count unknown.

multiple Pillars to confirm the heaviest valid ledger.

Not Specified in Draft (Open Questions):

history across independent Pillar sets.

1. Transaction-level PoW (links).

2. Epoch-level PoW by Pillars.

C. DNS Attacks

D. Eclipse Attacks

Not Specified in Draft (Open Questions):

• No canonical countermeasure is defined.

• Whether NoM uses DNS seeds, static lists, or DHTs for discovery.

The draft suggests randomizing connections at startup to reduce success probability.

Clarification (Interpretive): The draft treats peer discovery as out of scope for NoM-specific solutions,
implying reliance on standard DNS hardening or alternative bootstrap methods.

Canonical Claim: DNS-based peer discovery can be subverted by IP injection. The draft acknowledges this
as a real risk and references mitigations “existing in similar systems.”

Canonical Claim: Eclipse attacks (isolating a node by controlling its peers) are unlikely for Pillars because
of their connectivity and identity hardness. However, users connecting to only a few Pillars could be isolated.

DRAFT
COMMUNITY

Clarification (Interpretive): The design assumes that Pillars maintain sufficient redundancy and diversity in
connections, reducing eclipse feasibility except for isolated clients.

Canonical Claim: Sybil attacks confer no advantage since consensus power is weighted by stake, not node
count.

Clarification (Interpretive): This holds if stake distribution is honest and stake cannot be rapidly split or
recombined. PoW link costs further discourage node inflation for spam purposes.

• Quantitative peer connection thresholds are unspecified.

• How stake is measured under churn (joining/leaving).

• Interaction between stake and PoW layers over time.

Not Specified in Draft (Open Questions):

Not Specified in Draft (Open Questions):

• No formal bootstrap policy described.

E. Sybil Attacks

delayed.

G. Consensus Delay

Not Specified in Draft (Open Questions):

• Sentinel overload behavior unspecified.

F. Denial-of-Service (DoS) Attacks

• Minimum fee requirements and adaptive mechanisms not defined.

Mentions a shared coin epoch invoked after several consecutive non-finalizing epochs.

Clarification (Interpretive): DoS resistance derives from economic friction: attackers must expend real
resources to maintain spam. Even if Sentinels are overwhelmed, the consensus layer remains safe, albeit

Canonical Claim: Transaction flooding (DoS) against Sentinels is mitigated by transaction fees, which
impose a cost on spamming. Consensus is unaffected because Pillars process only finalized transactions.

Canonical Claim: If an attacker interferes with Pillar communication (e.g., through DDoS), consensus
may stall temporarily. However, probability of eventual supermajority approaches 1 as epochs progress.

DRAFT
COMMUNITY

Clarification (Interpretive): The “shared coin” acts as a probabilistic termination mechanism to break tie
situations. Though theoretical, it guarantees eventual convergence without central intervention.

Clarification (Interpretive): This corresponds to the classical security limit in stake-weighted systems. An
attacker exceeding the honest majority undermines safety but cannot retroactively forge prior epochs due to

Canonical Claim: If an adversary controls >50% of total stake, it can include or reorder new transactions
but cannot rewrite past ones. The draft explicitly states that the honest-majority assumption must hold and

PoW commitments and finality checkpoints.

• Public auditability of randomness events.

• Randomness source for the shared coin.

Not Specified in Draft (Open Questions):

Not Specified in Draft (Open Questions):

• How consensus delay is detected.

H. Majority (51%) Attack

mentions a “hard limit condition.”

to

coin

DoS

Sybil

Attack

ensures

Forking

Open Gaps

Clarification

DNS
Eclipse

Canonical Claim

Peer count unspecified

Penalization undefined

Consensus
Delay
Majority

Double Spend Conflicts resolved deter-

ministically
Heaviest ledger rule

I. Consolidated Security Table

Probabilistic termination Detection/randomness

Peer discovery injection
Client isolation risk

• Recovery protocol after majority takeover.

Bootstrap unspecified
Peer selection undefined

• How long-range stake attacks are mitigated.

Stake churn rules miss-
ing
Fee policy undefined

Relies on convergence
and resolution rules
PoW accumulation pre-
vents fake forks
Standard mitigations
Pillars
robust due
identity hardness
Node inflation yields no
advantage
Costs limit spam

Stake-weighted protec-
tion
Economic friction via
fees
Shared
progress
Honest majority required Cannot alter past ledger

DRAFT
COMMUNITY

3. Eventual propagation: Every valid transaction eventually reaches a supermajority.

4. PoW costs: Spam and Sybil resistance enforced economically.

• Quantitative connectivity requirements for eclipse resistance.

5. Deterministic ordering: Virtual voting ensures convergence.

J. Summary of Canonical Security Assumptions

• Detailed detection mechanism for consensus delay.

1. Asynchronous network: No timing guarantees.

• Recovery protocol for temporary 51% takeover.

2. Honest majority: Safety holds if < 1

• Randomness generation for coin rounds.

• Concrete fee policy for DoS mitigation.

• Implementation of penalization system.

Not Specified in Draft (Open Questions)

missing
Recovery unspecified

Table 6: Consolidated security analysis

3 Byzantine stake.

cost.

stake.

Canonical (from the 2020 draft)

• Indicates that during an epoch:

– Verification occurs locally per node.

– Pillars conduct broadcasts for consensus.

– Users issue transactions through Sentinels.

VII. Parameters and Complexity Analysis

• Emphasizes scalability through resource heterogeneity (light clients and full nodes).

• Provides high-level asymptotic behaviors for message propagation and consensus communication.

• Analyzes overall protocol efficiency in terms of message complexity, time complexity, and verification

• States that safety and liveness scale with the number of Pillars (N ), assuming a supermajority of honest

DRAFT
COMMUNITY

Transaction dissemination follows logarithmic complexity through the Sentinel layer:

Consensus broadcast among Pillars is quadratic globally or linear per node:

• M : number of user transactions per epoch.

Reconstruction (Interpretive, Non-normative)

O(N 2) globally, O(N ) per Pillar.

• S: number of Sentinel nodes.

• N : number of Pillar nodes.

A. Overall Complexity

O(log S)

Let:

where:

O(log n + m)

handle user interactions.

• n = total number of transactions in the ledger.

B. Verification and Asymptotic Behavior

• m = number of proofs retrieved for the specific account.

Verification complexity for a light verifier is approximately:

vergence time bounded by network latency rather than computation.

chronization. Expected epoch duration remains approximately constant under stable conditions, with con-

Each Pillar must send messages to every other Pillar for epoch finalization, ensuring complete state syn-

Interpretive Clarification: This analysis assumes all Pillars maintain authenticated communication channels
and use deterministic message processing (virtual voting). Even with O(N 2) message exchanges, the system
achieves scalability by limiting consensus participation to a finite Pillar set while Sentinels and Sentries

DRAFT
COMMUNITY

Interpretive Note: Asymptotic behavior indicates that verification costs grow sublinearly with ledger size,
supporting scalability for resource-constrained devices. Actual throughput depends heavily on network

As k increases, Pfail decays exponentially, ensuring strong resilience even if a significant portion of Sentinels
are malicious.

This logarithmic relation ensures light clients can validate their data efficiently using compact proof bundles.

Users select multiple Representatives (Sentinels) to connect for redundancy and reliability. Let:

topology, propagation delays, and implementation details not specified in the 2020 draft.

The probability that a user connects exclusively to compromised Representatives:

C. Representative Selection and Network Robustness

• k = ⌈log S⌉: number of Representatives contacted.

• f : fraction of malicious Sentinels.

Pfail = f k

requirements for subsequent epochs.

Not Specified in Draft (Open Questions):

D. Epoch Management and Difficulty Adjustment

• Specific difficulty adjustment formula, parameters, or convergence rate.

• How difficulty changes propagate and achieve consensus among Pillars.

• Whether difficulty adjustment applies symmetrically to both PoW layers (Pillar vs. transaction).

in consensus intervals. The adjustment occurs deterministically and affects Pillar-level PoW computation

Epoch duration depends on PoW difficulty (Dϵ) and broadcast efficiency. The draft indicates that difficulty
adjusts based on actual versus target epoch completion times to maintain stable consensus intervals.

Interpretive Note: This probabilistic connectivity model emphasizes fault tolerance through multi-peer ran-
domness rather than centralized trust.

Interpretive Description: If epochs complete faster than the target, difficulty increases; if slower, difficulty
decreases. This feedback mechanism stabilizes network rhythm over time and prevents excessive variance

DRAFT
COMMUNITY

Interpretive Clarification: If a Pillar fails to complete its PoW before supermajority finalization, it forfeits
epoch rewards. This creates competition to maintain network liveness and discourages idle or faulty Pillars.

Transaction fees, PoW link
rewards
Epoch PoW completion re-
wards
Gas-like resource pricing

The cryptoeconomic layer balances incentives for participation, ensuring fairness and availability across

Relay
proofs
Maintain consensus integrity

Provide deterministic computa-
tion

E. Cryptoeconomic Incentives

Table 7: Cryptoeconomic incentives

Behavior Incentivized

Reward Source

zApp Executors

transactions,

Sentinels

supply

actors.

Pillars

Role

2
3

Wϵ + δ

V (t, ϵ) ≥

Not Specified in Draft (Open Questions):

• Stake update frequency and withdrawal procedures.

F. Proof-of-Stake Integration in Consensus

• Economic penalties or slashing conditions for misbehavior.

• How stake is locked or committed for consensus participation.

• Whether delegation mechanisms exist for smaller stakeholders.

G. Managing Consensus Under Network Degradation

where V (t, ϵ) is the total observed stake of Pillars that have acknowledged transaction t.

The 2020 draft integrates stake-weighted voting directly into virtual voting. A transaction t is finalized when
the observed cumulative stake supporting it meets the supermajority threshold:

DRAFT
COMMUNITY

Interpretive Clarification: The shared coin acts as a randomized mechanism ensuring consensus termination
without introducing central control. While rarely invoked, it provides theoretical completeness—proof that

If network disruption prevents finalization after several epochs, the shared coin mechanism guarantees even-

• Quantitative upper limits for epoch durations or block sizes.

• Actual network performance metrics (throughput, latency).

• Specific distribution ratios for Pillar and Sentinel rewards.

• Detailed conditions for invoking the shared coin round.

• How Representative nodes are elected or retired.

the system cannot remain indefinitely stalled.

Not Specified in Draft (Open Questions)

tual progress probabilistically:

as epochs increase.

Pfinish → 1

Canonical (from the 2020 draft)

• It highlights three architectural pillars:

Reconstruction (Interpretive, Non-normative)

VIII. Conclusions and Future Work

• Emphasizes NoM as an ongoing research effort rather than a finalized protocol.

• Encourages further formalization, performance evaluation, and implementation testing.

1. Dual-ledger structure — separating ordering (meta-DAG) from execution (block-lattice).

3. Bounded verification — ensuring correctness even with limited connectivity or resources.

2. Hybrid consensus — combining proof-of-work pacing with stake-weighted virtual voting.

• The draft concludes by reaffirming NoM’s design as a hybrid, verification-first distributed ledger.

The Network of Momentum (NoM) represents a conceptual evolution in distributed ledger architecture. It

achieves secure, scalable consensus without sacrificing accessibility or correctness by decoupling verifica-

DRAFT
COMMUNITY

Together, these properties establish a foundation for a self-sustaining, trust-minimized network capable of

5. Future adaptability: Its design leaves space for integrating new verification methods, zero-knowledge

2. Dual-ledger architecture: The meta-DAG ensures global order and finality; the block-lattice sup-

3. Economic and cryptographic equilibrium: Proof-of-work maintains Sybil resistance, while stake-

1. Verification-first paradigm: NoM prioritizes correctness over throughput—ensuring that nodes can

4. Heterogeneous participation: By accommodating light clients (Sentries) alongside full Pillars, NoM

weighted voting enforces fairness and convergence. The system’s cryptoeconomic model aligns in-

ports parallel user transactions. This division simplifies scaling and improves modularity.

refuse unverifiable data rather than propagate uncertainty.

democratizes participation without compromising safety.

centives for all participants (Pillars, Sentinels, verifiers).

operating securely across heterogeneous environments.

tion, ordering, and execution into distinct layers.

proofs, or future consensus optimizations.

Key Interpretive Insights:

(Sentinels/Pillars).

A. Canonical Future Work

• Quantitative evaluation of throughput and latency at scale.

The canonical draft mentions several open research directions:

B. Reconstruction (Interpretive, Non-normative)

• Formal verification of NoM’s correctness properties under partial synchrony.

• Exploration of “proof-carrying execution” for distributed applications (zApps).

• Development of formal specifications for proof markets and bounded verification.

The community recognizes several ongoing research priorities derived from the canonical intent:

place for proof availability. Study equilibrium behaviors between verifiers (demand) and proof suppliers

2. Formalization of REFUSE Semantics: Develop a rigorous logical model for three-outcome verification

1. Proof Market Dynamics: Investigate how bounded verification naturally creates an economic market-

DRAFT
COMMUNITY

3. Proof Dissemination Optimization: Design caching and relay strategies to minimize latency in deliver-

4. Cross-Ledger Interoperability: Explore how the dual-ledger model might connect with external con-

5. zApp Infrastructure and Execution Proofs: Advance research on verifiable computation and proof-

6. Security Evaluation and Incentive Modeling: Formalize adversarial models for DoS, stake manipula-

carrying execution, extending NoM’s verification-first principles into the application layer.

• Whether the REFUSE condition can integrate with cross-chain verifications.

tion, and consensus delay, analyzing resilience and incentive compatibility.

• Trade-offs between proof latency and network decentralization.

• How proof markets might be priced or stabilized economically.

• Specific interoperability protocols between external ledgers.

• Implementation constraints for zApp proof generation.

(accept/reject/refuse) ensuring safety and composability.

sensus systems through shared verification interfaces.

Not Specified in Draft (Open Questions)

ing proof bundles to bounded verifiers.

ID

§E

§C

§B

C4

C3

C2

C1

C6

C5

§A

§D

VI.E

VI.C

VI.B

VI.D

VI.A

gence

Claim

resolution

Reference

fectiveness

vulnerability

Double-spend

Draft Section

Sybil advantage

Reconstruction

DNS bootstrap

Claim Summary

Possible Attacks

Possible Attacks

Possible Attacks

Possible Attacks

Possible Attacks

and heaviest-ledger rule

noted; mitigations unspecified

through deterministic conver-

Eclipse risk minimal for Pillars;

Fork resistance via dual PoW

Transaction fees limit DoS ef-

randomized peers recommended

Stake-weighted voting prevents

Appendix A — Traceability Table

DRAFT
COMMUNITY

Interpretive claim: If a transaction is valid and broadcast by its Representatives, all honest Pillars will
eventually observe it over time. Absence beyond reasonable periods may indicate network fault or malicious

represent community-derived reasoning about the system’s theoretical properties and should be treated as

This appendix contains interpretive analytical observations that are not part of the canonical 2020 draft. They

Appendix B — Non-normative Analysis Notes

omission, detectable through querying multiple Representative sets.

Note 1 — Transaction Propagation Observation

Table 8: Claim traceability to canonical draft sections

speculative illustrations rather than verified theorems.

Shared coin ensures consensus

Majority control can reorder fu-

termination under delay

ture transactions only

Possible Attacks

Possible Attacks

Possible Attacks

VI.G

VI.H

VI.F

§G

§H

C7

C8

§F

Not Specified in Draft (Open Questions):

• Specific convergence bounds or timing guarantees.

Note 2 — Conflict Resolution Observation

Note 3 — Knowledge Convergence Pattern

propagates and converges toward completeness across the Pillar set.

• Whether convergence can be formally proven under stated assumptions.

• Quantitative relationship between epoch count and knowledge completeness.

double-spend inclusion. Specific convergence time and conditions are not provided in the draft.

Interpretive claim: The asynchronous nature of the network means Pillars operating in any given epoch
may have incomplete knowledge of earlier transactions. Over successive epochs, transaction knowledge

Interpretive claim: Given two conflicting transactions, the draft indicates that honest Pillars should con-
verge on one transaction through deterministic rules. The losing transaction would be discarded, preventing

DRAFT
COMMUNITY

Interpretive claim: Message complexity per consensus round appears to grow with the product of transac-
tions and logarithm of relay nodes, potentially growing sublinearly as the network scales if relay topology

Interpretive claim: Once a Pillar completes its PoW and broadcasts it, the draft suggests other honest Pillars
will include it in their consensus view, contributing to epoch finalization and fair participation.

Interpretive claim: The separation of consensus (Pillars) from transaction relay (Sentinels) suggests that
transaction processing could scale more favorably than traditional single-layer architectures, though actual

• Exact complexity bounds and their dependence on network parameters.

• Whether sublogarithmic scaling holds under adversarial conditions.

Note 5 — Message Complexity Observation

Note 6 — Asymptotic Scaling Pattern

Note 4 — PoW Inclusion Pattern

Not Specified in Draft (Open Questions):

is optimized.

future-proof.

X.1 Purpose

Canonical (from the 2020 draft)

Reconstruction (Interpretive, Non-normative)

performance depends on implementation details not provided in the draft.

• Mentions zApps as a potential application layer on top of the base ledger.

• Indicates explicitly that execution semantics are “intentionally under-specified.”

• Clarifies that consensus, correctness, and verification are defined independently of application execution.

Appendix X — zApps and Intentional Under-Specification

over execution. By not coupling correctness to application runtime, the protocol remains open-ended and

This appendix interprets the rationale for under-specification: Zenon’s architecture prioritizes verification

DRAFT
COMMUNITY

zApps are not required for consensus; they exist downstream of it. Ordering and correctness remain valid

Unikernels serve as examples of lightweight, bounded execution environments aligning with verification-

first design. They enable reproducible computation, explicit resource control, and isolation—but are not

2. Optional Participation: Nodes may ignore zApps without affecting correctness.

4. Asynchronous Compatibility: Verification may be delayed or partial.

3. Bounded Verifiability: Execution verification must permit REFUSE.

1. Non-Interference: Execution outcomes cannot alter consensus state.

5. No Implicit Trust: zApps cannot demand global acceptance.

X.3 Unikernels as Illustration

X.2 Execution Constraints

even if zApps fail or diverge.

mandated by protocol.

Y.1 Definition

Not Specified in Draft (Open Questions)

• Formal proof-of-execution format for zApps.

• Whether unikernels are canonical or illustrative only.

locally. Refusal to verify never compromises ledger safety.

X.4 Proof-Carrying Execution (Non-normative)

• Economic incentives for zApp execution or proof publication.

• Integration pathways between zApp outputs and block-lattice states.

Appendix Y — Unikernels (Illustrative, Non-normative)

Future zApps may provide cryptographic proofs of computation, enabling verifiers to check correctness

A unikernel is a single-purpose machine image bundling an application and minimal operating system com-

DRAFT
COMMUNITY

ponents into one verifiable binary artifact. It reduces complexity, improves isolation, and allows explicit

Can be distributed and referenced by digest rather than mutable server state.

Compiled as immutable images with hash-based identity:

Unikernels fit the NoM philosophy by supporting:

Y.2 Role in Verification-First Design

• Explicit CPU, memory, and I/O limits.

Y.3 Deployment Considerations

• Deterministic execution boundaries.

ID(U ) = H(unikernel_image_bytes)

• Small trusted computing base.

resource bounding.

local verification.

Y.6 Summary

Y.4 Operational Notes

• Must remain optional and correctness-neutral.

Y.5 Relationship to Bounded Verification

• Reduced debugging visibility but higher determinism.

• Should expose explicit, auditable input/output interfaces.

ness. Their inclusion reflects architectural flexibility rather than protocol dependence.

Unikernels must allow verifiers to refuse unverifiable outputs. They enhance modularity but do not replace

Unikernels illustrate how execution can remain bounded, verifiable, and independent of consensus correct-

DRAFT
COMMUNITY

asynchronous conditions. Its modular design ensures adaptability for evolving proof systems and verifiable

The Network of Momentum (NoM) unites dual-ledger structure, hybrid consensus, and bounded verification

computation, establishing NoM as both a theoretical framework and an evolving experimental architecture.

END OF DOCUMENT — Community Reconstruction (Interpretive, Non-normative)

It preserves decentralization, scalability, and correctness under

to form a verification-first architecture.

Final Summary


