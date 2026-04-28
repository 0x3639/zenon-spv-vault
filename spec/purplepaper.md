| Zenon | Purplepaper | Series |
| ----- | ----------- | ------ |
Economic and Interaction Consequences of Veri(cid:28)cation-First
Architecture
Status: Community-authored purplepaper (interpretive, non-normative, non-o(cid:30)cial)
Date: January 2026

Abstract
TheZenonGreenpaperdemonstratedthatveri(cid:28)cationcanexistindependentlyfromexecutionwhen
| bounded | by  | explicit | resource | limits, |     |         |      |
| ------- | --- | -------- | -------- | ------- | --- | ------- | ---- |
|         |     |          |          |         | R   | = (S ,B | ,C ) |
|         |     |          |          |         | V   | V V     | V    |
where storage (S ), bandwidth (B ), and computation (C ) de(cid:28)ne the veri(cid:28)er’s physical limits. If
|     |     | V   |     |     | V   |     | V   |
| --- | --- | --- | --- | --- | --- | --- | --- |
veri(cid:28)cation cannot complete within these limits, the only correct outcome is refusal.
This Purplepaper explores the world that results when veri(cid:28)cation-(cid:28)rst is not an optional feature
but a foundational rule. When veri(cid:28)cation capacity is scarce, proofs themselves gain economic
value(cid:22)they become artifacts that can be traded, cached, or prioritized. In such an environment,
| data being | (cid:16)available(cid:17) |     | does | not | automatically | mean it | is (cid:16)veri(cid:28)able.(cid:17) |
| ---------- | ------------------------- | --- | ---- | --- | ------------- | ------- | ------------------------------------ |
Our aim is to reason from the Greenpaper’s premises: if its axioms hold true, then the behaviors,
economics, and coordination structures that follow are inevitable. We analyze how scarcity, co-
ordination, and application design evolve when refusal becomes part of correctness, not a sign of
error.
This version also provides intuitive examples of these dynamics(cid:22)for instance, how refusing unver-
i(cid:28)able claims resembles a payment processor declining transactions that cannot be authenticated
| within         | its fraud-check |             | limits.      |             |           |     |     |
| -------------- | --------------- | ----------- | ------------ | ----------- | --------- | --- | --- |
| Part           | I: Foundations  |             |              | Revisited   |           |     |     |
| 1. Why         | a               | Purplepaper |              | Exists      |           |     |     |
| 1.1 The        | Gap             | After       | Architecture |             |           |     |     |
| The Greenpaper |                 | asked       | a            | theoretical | question: |     |     |
Can veri(cid:28)cation operate independently of execution under explicit bounds?
| This Purplepaper |     |     | asks the | behavioral | one: |     |     |
| ---------------- | --- | --- | -------- | ---------- | ---- | --- | --- |
What happens when participants live inside those bounds(cid:22)where some proofs are missing, and (cid:16)re-
| fusal(cid:17) means |     | safety, | not failure? |     |     |     |     |
| ------------------- | --- | ------- | ------------ | --- | --- | --- | --- |

Think of this as moving from (cid:16)Can a system survive in a vacuum?(cid:17) to (cid:16)What’s it like to live
there?(cid:17) Once veri(cid:28)cation-(cid:28)rst becomes the environment itself, not a setting, its economic and social
| consequences | emerge     | naturally.   |                         |
| ------------ | ---------- | ------------ | ----------------------- |
| 1.2 From     | Can Verify | to Must Live | With Veri(cid:28)cation |
Veri(cid:28)cation-(cid:28)rst is not a user experience choice(cid:22)it’s a fundamental constraint. If a claim cannot
be veri(cid:28)ed within a veri(cid:28)er’s resource limit R , refusal is the only correct response.
V
This means applications, markets, and interfaces must accept that some truths will remain locally
| unprovable | unless extra | trust or resources | are introduced. |
| ---------- | ------------ | ------------------ | --------------- |
For example, imagine your mobile wallet trying to verify an old transaction. If the proof data
exceeds its memory or bandwidth capacity, the wallet should not guess(cid:22)it must safely refuse. This
isn’t a failure of the network but a correct expression of its physical limits.
| 1.3 Why | This Is Inevitable |     |     |
| ------- | ------------------ | --- | --- |
Bounded veri(cid:28)cation arises directly from physical limits: (cid:28)nite storage, bandwidth, and compu-
tational power. By expressing these limits explicitly as R and enforcing refusal semantics, the
V
| architecture | ensures | several consequences | emerge automatically: |
| ------------ | ------- | -------------------- | --------------------- |
1. Veri(cid:28)cation scarcity (cid:22) Only so much veri(cid:28)cation can occur per device or per time unit.
2. Proof distribution markets (cid:22) Proofs become valuable and tradable.
3. Visible veri(cid:28)cation states (cid:22) Users can see what their devices can or cannot verify.
4. Topologies shaped by refusal, not availability (cid:22) Networks evolve around what can be veri(cid:28)ed
| locally, | not merely | what exists globally. |     |
| -------- | ---------- | --------------------- | --- |
These are not features or design preferences(cid:22)they are the physics of a (cid:28)nite system.
| 2. Inherited | Constraints |     |     |
| ------------ | ----------- | --- | --- |
The following assumptions are restated from the Greenpaper. They are not optional guidelines but
immutable truths that every application built on Zenon already inherits.

2.1 Veri(cid:28)cation Bounds
De(cid:28)nition 1 (Resource Bound Tuple (cid:22) Greenpaper 2.5). Every veri(cid:28)er V declares
R = (S ,B ,C )
V V V V
where:
(cid:136) S = persistent storage bound,
V
(cid:136) B = bandwidth bound per synchronization window,
V
(cid:136) C = computation bound per veri(cid:28)cation session.
V
De(cid:28)nition 2 (Correct Boundedness). For any veri(cid:28)cation operation o, it must either:
(cid:136) complete within bounds (TRUE or FALSE), or
(cid:136) return REFUSED without exceeding them.
There is no (cid:16)best-e(cid:27)ort(cid:17) state.
In practical terms, this means if your node’s veri(cid:28)cation job is like checking an invoice, and your
time window runs out before you can con(cid:28)rm its signature, you stop rather than guess.
Developer takeaway: Applications cannot assume that retrying or (cid:16)waiting longer(cid:17) guarantees
success(cid:22)because correctness is tied to resource limits, not time.
2.2 Proof Objects
In veri(cid:28)cation-(cid:28)rst systems, proofs are (cid:28)rst-class citizens(cid:22)independent data structures that prove
claims without needing trust in their source. They can be stored, shared, and veri(cid:28)ed by anyone
with su(cid:30)cient resources. This is similar to how digital signatures or certi(cid:28)cates can be validated by
any computer, regardless of who provides them.
2.2.1 Minimality and Source-Agnostic Validity
De(cid:28)nition 3 (Proof Object). A proof object π is a (cid:28)nite byte string interpreted under a schema
h with public inputs x , such that veri(cid:28)cation is deterministic:
schema pub
Verify(h ,x ,π) ∈ {0,1}
schema pub

The proof’s source does not a(cid:27)ect veri(cid:28)cation. In other words, a valid proof remains valid whether
downloaded from a friend, a relay node, or an unknown peer.
Thisproperty(cid:22)Source-AgnosticValidity(cid:22)meansthatwhilethenetworkmightlieaboutavailability
((cid:16)I have the proof(cid:17)), it cannot lie about validity ((cid:16)This proof works(cid:17)).
Hence, proof markets sell bytes and latency, not truth.
2.2.2 Independence and Cache Value
Proofs can be cached, traded, or reused as long as their reference data remains within the veri(cid:28)er’s
retentionwindow. Theirresalevaluedependsonhowmanyveri(cid:28)erscanstillvalidatethem(cid:22)similar
to how a (cid:28)le format has more utility when many systems can open it.
E(cid:30)cient proofs have short dependency chains and broad scope compatibility(cid:22)like a compact ZIP
(cid:28)le that works on most devices without additional libraries.
Developer takeaway: Design proofs that remain veri(cid:28)able for many peers, over wide time spans.
2.2.3 Proof Size, Cost, and the Usability Boundary
Veri(cid:28)cation is feasible when:
Φ (π) ≡ (|π| ≤ B )∧(Cost (π) ≤ C )∧(Cost (π) ≤ Salloc)
V V C V S V
Iftypicalproofsfromanapplicationexceedmostveri(cid:28)ers’R ,thatapplicationcannotbewidelyus-
V
able without reintroducing trust. This means proof e(cid:30)ciency de(cid:28)nes adoption boundaries(cid:22)if users’
devices cannot verify something within their resource limits, they must rely on others, undermining
decentralization.
Think of this like video streaming: a platform o(cid:27)ering only 4K streams excludes users on slow
connections. Similarly, a blockchain app with heavy proofs excludes users with small devices.
2.2.4 Illustrative Resource Envelopes
Approximate proof size references (non-normative):
(cid:136) Merkle inclusion: 0.3(cid:21)0.6 KB

(cid:136)
| Signatures:       |     | 0.06(cid:21)0.2 | KB       |          |     |     |     |
| ----------------- | --- | --------------- | -------- | -------- | --- | --- | --- |
| (cid:136) SNARKs: |     | a few hundred   |          | bytes to | KB  |     |     |
| (cid:136) STARKs: |     | tens to         | hundreds | of KB    |     |     |     |
These magnitudes will later support arguments about proof markets, caching incentives, and user
experience.
| 2.3 Refusal |     | Semantics |     |     |     |     |     |
| ----------- | --- | --------- | --- | --- | --- | --- | --- |
Refusal is not failure(cid:22)it’s a safe and correct response when veri(cid:28)cation exceeds resource bounds.
For example, when your phone declines to open a massive encrypted (cid:28)le because it lacks memory,
it’s refusing safely(cid:22)it’s not crashing, just acknowledging physical limits.
| 2.3 Refusal |     | Semantics |     |     |     |     |     |
| ----------- | --- | --------- | --- | --- | --- | --- | --- |
Refusal is not a system error(cid:22)it is the only safe and correct outcome when a veri(cid:28)er cannot con(cid:28)rm
| a claim | within | its declared | resource | limits. |     |     |     |
| ------- | ------ | ------------ | -------- | ------- | --- | --- | --- |
In traditional systems, a failed request often implies that something broke. In a veri(cid:28)cation-(cid:28)rst
system, refusal means the veri(cid:28)er stayed honest by not guessing beyond its means. It is similar to
a payment processor declining a transaction when it cannot con(cid:28)rm the sender’s balance(cid:22)it’s not
| saying             | the balance | is wrong,       |       | only that   | it cannot | be proven | right now. |
| ------------------ | ----------- | --------------- | ----- | ----------- | --------- | --------- | ---------- |
| 2.3.1 Refusal      |             | as a Third      |       | Truth Value |           |           |            |
| Veri(cid:28)cation |             | in Zenon yields | three | possible    | outcomes: |           |            |
(cid:136)
| TRUE            | (cid:21) | the claim          | is veri(cid:28)ed | and | valid, |     |     |
| --------------- | -------- | ------------------ | ----------------- | --- | ------ | --- | --- |
| (cid:136) FALSE |          | (cid:21) the claim | is disproven,     |     |        |     |     |
(cid:136)
| REFUSED |       | (cid:21) the veri(cid:28)er |     | cannot complete |     | veri(cid:28)cation | within bounds. |
| ------- | ----- | --------------------------- | --- | --------------- | --- | ------------------ | -------------- |
| Refusal | codes | further describe            |     | the reason:     |     |                    |                |
(cid:136) OUT_OF_SCOPE (cid:21) the veri(cid:28)er’s retention window no longer includes the necessary data.
(cid:136)
DATA_UNAVAILABLE (cid:21) the proof or supporting information is missing.
(cid:136) COST_EXCEEDED (cid:21) the proof is too large or computationally heavy to verify.

Theorem 1 (Refusal Soundness). A veri(cid:28)er that refuses has not accepted any unveri(cid:28)ed claim.
Therefore, refusal preserves correctness(cid:22)just as a responsible auditor suspends judgment until suf-
| (cid:28)cient records |     | are available. |     |     |     |     |     |
| --------------------- | --- | -------------- | --- | --- | --- | --- | --- |
Operational Rule: Treat REFUSED as an expected and (cid:28)nal state, not as an exception to (cid:28)x.
| 2.3.2 Refusal |     | as an | Economic |     | Signal |     |     |
| ------------- | --- | ----- | -------- | --- | ------ | --- | --- |
Each refusal provides a map of where veri(cid:28)cation demand exceeds supply. When a veri(cid:28)er publishes
| a refusal | witness |     |     |         |               |               |            |
| --------- | ------- | --- | --- | ------- | ------------- | ------------- | ---------- |
|           |         |     | w R | = (last | header,object | id,code,bound | dimension) |
itdescribespreciselywhereveri(cid:28)cationfailed. Theserefusalwitnessescansafelybesharedtoinform
the ecosystem:
| (cid:136) Where | to  | cache | missing | data. |     |     |     |
| --------------- | --- | ----- | ------- | ----- | --- | --- | --- |
(cid:136)
| Which | proofs | are | in high | demand. |     |     |     |
| ----- | ------ | --- | ------- | ------- | --- | --- | --- |
(cid:136)
| Which | resource |     | limits | are most | often exceeded. |     |     |
| ----- | -------- | --- | ------ | -------- | --------------- | --- | --- |
Inpractice, thisfunctionsmuchlikehowcontentdeliverynetworks(CDNs)identify(cid:16)hot(cid:28)les(cid:17) based
onfailedcacherequests. Arefusal, therefore, becomesaneconomicsignal(cid:22)apointertowherevalue
| lies in (cid:28)lling | the | veri(cid:28)cation |       | gap. |     |     |     |
| --------------------- | --- | ------------------ | ----- | ---- | --- | --- | --- |
| 2.3.3 REFUSED         |     | ̸=                 | FALSE |      |     |     |     |
A missing proof does not imply a false claim. Applications must never punish or discredit users
| when veri(cid:28)cation |     | is  | refused. |     |     |     |     |
| ----------------------- | --- | --- | -------- | --- | --- | --- | --- |
Example: If a payment app cannot verify an older transaction due to data expiry, the sender is
not automatically accused of fraud. The veri(cid:28)er is simply stating, (cid:16)I cannot con(cid:28)rm this now.(cid:17)
| 2.4 Availability |            | Non-Guarantee |               |     |          |                    |     |
| ---------------- | ---------- | ------------- | ------------- | --- | -------- | ------------------ | --- |
| The Zenon        | Greenpaper |               | distinguishes |     | ordering | from availability: |     |
(cid:136)
The ordering plane (Momentum) guarantees the sequence of commitments.

(cid:136) The distribution plane (proofs and segments) does not guarantee that all data is accessible to
everyone.
This separation means a claim may be properly ordered in consensus but still unveri(cid:28)able by some
peers who lack bandwidth or data.
Theorem 2. Any application assuming that proofs are always retrievable contradicts bounded veri-
(cid:28)cation. Correctness remains local(cid:22)it depends only on what the veri(cid:28)er can prove.
Analogy: Two auditors can agree on the order of transactions in a ledger, even if one lacks access
to all receipts. Both remain correct within their limits.
2.5 O(cid:31)ine Veri(cid:28)ability
In Zenon, o(cid:31)ine is the normal state, not a degraded mode. A veri(cid:28)er can con(cid:28)rm claims from
cached data as long as it remains within scope. When reconnecting, it simply resumes from its last
veri(cid:28)ed state and refuses anything unveri(cid:28)able.
This approach mirrors how a smartphone wallet operates when o(cid:31)ine: it can verify your recent
transactions from cached headers but will safely refuse to con(cid:28)rm very old ones until reconnected.
Developer consequence: Applications must produce portable proof bundles, bounded snapshots,
and explicit expiration policies(cid:22)so that proofs remain valid and veri(cid:28)able even when users discon-
nect for long periods.
Part II: The Veri(cid:28)cation-First Mental Model
Thissectiontranslatesthetheoreticalrulesofboundedveri(cid:28)cationintoadeveloper’sworkingmind-
set. In a veri(cid:28)cation-(cid:28)rst architecture, the smallest unit of interaction is no longer an API call(cid:22)it
is a claim supported by veri(cid:28)able data.
3.1 From Services to Claims
3.1.1 The Claim Model
In traditional systems, a call such as getBalance(user) requests data from a trusted service. The
user must trust that the service is honest and up-to-date.
In a veri(cid:28)cation-(cid:28)rst system, the request becomes a claim:

(cid:16)User X has balance = Y at commitment root r , proven by proof bundle B.(cid:17)
C
Formally,
c = (statement,anchor,π,meta)
where
(cid:136) statement = the fact being asserted,
(cid:136) anchor = the reference point in the veri(cid:28)able ledger,
(cid:136) π = proof bundle,
(cid:136) meta = optional freshness or scope data.
The veri(cid:28)er evaluates and returns:
(cid:136) VERIFIED (TRUE)
(cid:136) DISPROVEN (FALSE)
(cid:136) REFUSED (unveri(cid:28)able within bounds)
This is conceptually similar to submitting documents for review: the reviewer does not accept your
statement until they can check the evidence within their capacity.
Developer pattern: Every read operation should submit a claim with proofs, not merely request
information from a trusted server.
3.1.2 Anti-Pattern: Best-E(cid:27)ort Retry
In ordinary systems, if something fails, we retry. However, under veri(cid:28)cation-(cid:28)rst semantics, retries
do not alter correctness. If a veri(cid:28)er refuses due to bound limits, repeating the request does not
change the outcome(cid:22)unless new data, smaller proofs, or expanded scope are introduced.
Imagine trying to stream a 4K video over a slow connection: hitting (cid:16)retry(cid:17) won’t help until the
bandwidthincreasesoralower-qualityversioniso(cid:27)ered. Likewise, averi(cid:28)ercannotexceeditslimits
by persistence alone.
3.1.3 Correct Pattern: Progressive Proof Acquisition
Veri(cid:28)cation becomes an interactive process, not a one-shot query. Correct behavior follows these
steps:
1. Attempt local veri(cid:28)cation with cached proofs.

2. If REFUSED_DATA_UNAVAILABLE, fetch or request missing data.
3. If REFUSED_OUT_OF_SCOPE, explicitly o(cid:27)er to expand the veri(cid:28)er’s historical window.
4. If REFUSED_COST_EXCEEDED, suggest alternate or compressed proofs.
This progressive approach ensures users understand why veri(cid:28)cation fails and what resources (time,
| bandwidth,      | or trust) | are needed   | to complete | it. |
| --------------- | --------- | ------------ | ----------- | --- |
| 3.2 From        | Services  | to Artifacts |             |     |
| 3.2.1 Artifacts | Replace   | Endpoints    |             |     |
In a veri(cid:28)cation-(cid:28)rst world, we no longer depend on services for answers but on artifacts(cid:22)veri(cid:28)able
| data objects | distributed | by peers | or relays. |     |
| ------------ | ----------- | -------- | ---------- | --- |
For example, rather than trusting a price oracle’s live feed, you can obtain a signed proof of the
latest price and verify it locally. The oracle no longer needs your trust(cid:22)it only needs to provide
valid artifacts.
| 3.2.2 Integrity | vs. | Availability |     |     |
| --------------- | --- | ------------ | --- | --- |
Integrity is cryptographic and absolute; availability is economic and variable. Applications should
dependonintegrity,notavailability. Theymustacceptartifactsfromanysource,verifythemlocally,
| and treat | missing data | as normal. |     |     |
| --------- | ------------ | ---------- | --- | --- |
ThismirrorshowmodernbrowsersverifySSLcerti(cid:28)cates: theytrustthesignature,notthewebsite’s
uptime.
| 3.3 From      | Failure | to Refusal    |     |     |
| ------------- | ------- | ------------- | --- | --- |
| 3.3.1 Refusal | as      | a Result Type |     |     |
Applications should treat refusal as a structured, predictable outcome, not an exception. Possible
results include:
(cid:136) VERIFIED
(cid:136)
DISPROVEN
| (cid:136) REFUSED | (with | cause) |     |     |
| ----------------- | ----- | ------ | --- | --- |

(cid:136)
| EXPIRED                |     | (if the | anchor | is too | old)   |               |     |
| ---------------------- | --- | ------- | ------ | ------ | ------ | ------------- | --- |
| (cid:136) OUT_OF_SCOPE |     |         | (if    | policy | limits | are exceeded) |     |
Refusal re(cid:29)ects truthfulness within bounds(cid:22)it ensures the system never lies for the sake of respon-
siveness.
| 3.3.2 Developer               |     | Contract: |             | No     | Hidden | Trust |     |
| ----------------------------- | --- | --------- | ----------- | ------ | ------ | ----- | --- |
| A veri(cid:28)cation-faithful |     |           | application | never: |        |       |     |
(cid:136)
| silently          | calls              | trusted | APIs    | when | veri(cid:28)cation |     | fails, |
| ----------------- | ------------------ | ------- | ------- | ---- | ------------------ | --- | ------ |
| (cid:136) accepts | unveri(cid:28)able |         | claims, | or   |                    |     |        |
(cid:136)
| labels | unveri(cid:28)ed |     | data | as con(cid:28)rmed. |     |     |     |
| ------ | ---------------- | --- | ---- | ------------------- | --- | --- | --- |
This contract is what di(cid:27)erentiates a veri(cid:28)cation-(cid:28)rst network from a (cid:16)trusted network with cryp-
tography.(cid:17) It is the philosophical equivalent of scienti(cid:28)c honesty: if something cannot be tested, it
| is not considered |     | true(cid:22)only |     | pending | veri(cid:28)cation. |     |     |
| ----------------- | --- | ---------------- | --- | ------- | ------------------- | --- | --- |
Part III: Economic Consequences of Veri(cid:28)cation-First Design
| 4. Veri(cid:28)cation  |     | as  | an Economic |     | Primitive |     |     |
| ---------------------- | --- | --- | ----------- | --- | --------- | --- | --- |
| 4.1 Veri(cid:28)cation |     | Is  | Scarce      |     |           |     |     |
Veri(cid:28)cation consumes limited resources: storage, bandwidth, and computation. Each veri(cid:28)er there-
fore has a (cid:28)nite (cid:16)budget(cid:17) that determines how many claims it can process in a given period:
(cid:18) (cid:19)
|     |     |     |     |     |     | B      | C      |
| --- | --- | --- | --- | --- | --- | ------ | ------ |
|     |     |     |     |     | min | V      | , V    |
|     |     |     |     |     |     | E[|π|] | E[Cost |
(π)]
C
This means every device(cid:22)whether a phone, node, or data center(cid:22)must choose what to verify. Just
as a commuter with limited fuel decides which destinations are worth driving to, veri(cid:28)ers allocate
| their (cid:28)nite | capacity | toward |     | proofs | they deem | most | valuable. |
| ------------------ | -------- | ------ | --- | ------ | --------- | ---- | --------- |
Whenmoreclaimscompeteforattentionthanaveri(cid:28)ercanprocess,veri(cid:28)cationbandwidthbecomes
a scarce economic resource. Pricing emerges not for (cid:16)truth(cid:17) itself, but for the ability to prove that
| truth within | resource |     | limits. |     |     |     |     |
| ------------ | -------- | --- | ------- | --- | --- | --- | --- |

| 4.2 Execution |     | Is  | Never Free |     |     |     |     |
| ------------- | --- | --- | ---------- | --- | --- | --- | --- |
Even if execution is computationally cheap, veri(cid:28)cation remains expensive because:
| (cid:136) Proof | generation |     | consumes | compute | power, |     |     |
| --------------- | ---------- | --- | -------- | ------- | ------ | --- | --- |
(cid:136)
| Proof                        | distribution |        | consumes | bandwidth, |                  |         |     |
| ---------------------------- | ------------ | ------ | -------- | ---------- | ---------------- | ------- | --- |
| (cid:136) Veri(cid:28)cation |              | itself | consumes | each       | veri(cid:28)er’s | bounded | C . |
V
A common mistake in scalability debates is to focus on faster execution rather than e(cid:30)cient veri(cid:28)-
cation. It is like building faster cars on a highway with (cid:28)xed toll booths(cid:22)the real bottleneck lies
| in checking | tickets, |     | not in driving | speed. |     |     |     |
| ----------- | -------- | --- | -------------- | ------ | --- | --- | --- |
Hence,scalabilityinZenonmeansminimizingproofsizeandveri(cid:28)cationcost,notmerelyaccelerating
transactions.
| 4.3 Proof       | E(cid:30)ciency |             | as Market      | Advantage     |     |     |     |
| --------------- | --------------- | ----------- | -------------- | ------------- | --- | --- | --- |
| Applications    |                 | now compete | on             | a new metric: |     |     |     |
| Value Delivered |                 | per         | Veri(cid:28)ed | Byte          |     |     |     |
Reducing proof size by even a small factor expands the range of devices that can verify it. A proof-
heavy protocol might serve only powerful servers, while a proof-e(cid:30)cient one reaches mobile devices
| and edge | nodes. |     |     |     |     |     |     |
| -------- | ------ | --- | --- | --- | --- | --- | --- |
In economic terms, proof e(cid:30)ciency widens market access. A smaller proof is like a lightweight
shipping container(cid:22)cheaper to move, easier to store, and usable by more participants.
Developer takeaway: Design proofs for minimal cost, broad compatibility, and short dependency
chains. These are not just optimizations(cid:22)they determine who can participate.
| 5. Scarcity             |     | Without  | Supply | Caps |     |     |     |
| ----------------------- | --- | -------- | ------ | ---- | --- | --- | --- |
| 5.1 Veri(cid:28)ability |     | Scarcity |        |      |     |     |     |
Traditional scarcity in blockchains comes from token limits. In veri(cid:28)cation-(cid:28)rst systems, scarcity
arises instead from veri(cid:28)ability(cid:22)the (cid:28)nite ability of the network to process and con(cid:28)rm proofs.
If more users wish to verify than the system can serve, prices naturally emerge for proof access,
much like surge pricing in ride-sharing when driver supply lags demand. However, what is traded
is not trust, but veri(cid:28)cation opportunity(cid:22)who gets to prove (cid:28)rst and at what cost.

| 5.2 Retention |     | Windows |     | as Markets |     |     |     |     |     |
| ------------- | --- | ------- | --- | ---------- | --- | --- | --- | --- | --- |
Each veri(cid:28)er stores data for a limited retention window. Recent proofs are easy to con(cid:28)rm because
their data is fresh; old proofs require archived data and thus become rarer and more expensive.
This dynamic mirrors the economics of cloud storage: recent (cid:28)les on local disks are cheap to access,
| but old | backups | in cold | storage | cost | more | to retrieve. |     |     |     |
| ------- | ------- | ------- | ------- | ---- | ---- | ------------ | --- | --- | --- |
Applications that depend on long historical state therefore face choices:
| (cid:136) compress |     | and repackage |     | proofs | into smaller |     | bundles, |     |     |
| ------------------ | --- | ------------- | --- | ------ | ------------ | --- | -------- | --- | --- |
(cid:136)
| accept         | that        | some           | requests | will            | yield OUT_OF_SCOPE |        |               | refusals, | or  |
| -------------- | ----------- | -------------- | -------- | --------------- | ------------------ | ------ | ------------- | --------- | --- |
| (cid:136) rely | on archival | markets        |          | that specialize |                    | in     | serving older | data.     |     |
| Thus, the      | past        | itself becomes |          | an economic     |                    | layer. |               |           |     |
| 6. Proofs      | as          | Economic       |          | Objects         |                    |        |               |           |     |
| 6.1 Proofs     | as          | Goods          |          |                 |                    |        |               |           |     |
In this model, proofs behave like commodities with unique physical and economic properties:
|     |     | Property  |              |          | Meaning   |      |             | Analogy  |              |
| --- | --- | --------- | ------------ | -------- | --------- | ---- | ----------- | -------- | ------------ |
|     |     | Non-rival | in           | validity | Everyone  |      | can verify  | Public   | knowledge    |
|     |     |           |              |          | the       | same | proof.      | (like    | mathematics) |
|     |     | Rival in  | distribution |          | Bandwidth |      | and storage | Shipping | goods        |
are (cid:28)nite.
|           |         | Durable    | while                      | in scope      | Proofs |             | retain value      | Perishable  | goods  |
| --------- | ------- | ---------- | -------------------------- | ------------- | ------ | ----------- | ----------------- | ----------- | ------ |
|           |         |            |                            |               | until  | anchors     | expire.           | with        | expiry |
|           |         | Composable |                            |               | Proofs |             | can be bundled    | Financial   |        |
|           |         |            |                            |               | or     | aggregated. |                   | derivatives |        |
| Formally, | a proof | bundle     | is                         | de(cid:28)ned | as:    |             |                   |             |        |
|           |         | B          | = {headers,witness,account |               |        |             | segments,π,schema |             | IDs}   |
Bundles can be tailored for di(cid:27)erent veri(cid:28)er classes(cid:22)mobile clients receive lighter bundles; archival
| nodes may | handle | full-scope |     | sets. |     |     |     |     |     |
| --------- | ------ | ---------- | --- | ----- | --- | --- | --- | --- | --- |
Thus, proofs become tradeable digital assets, each with measurable size, cost, and shelf-life.

| 6.2 Proof | Markets |     |     |     |     |     |     |     |
| --------- | ------- | --- | --- | --- | --- | --- | --- | --- |
Markets for proofs emerge spontaneously even without protocol-level changes because veri(cid:28)cation
| scarcity creates |     | demand. |     |     |     |     |     |     |
| ---------------- | --- | ------- | --- | --- | --- | --- | --- | --- |
(cid:136)
| Sellers:          | peers           | who | hold    | or  | produce  | proofs. |     |     |
| ----------------- | --------------- | --- | ------- | --- | -------- | ------- | --- | --- |
| (cid:136) Buyers: | veri(cid:28)ers |     | seeking | to  | validate | claims. |     |     |
(cid:136)
| Veri(cid:28)cation: |         | immediate |         | upon    | receipt(cid:22)no |               | counterparty | trust required. |
| ------------------- | ------- | --------- | ------- | ------- | ----------------- | ------------- | ------------ | --------------- |
| (cid:136) Fraud:    | limited | to        | selling | useless |                   | data (invalid | or expired   | proofs).        |
| Market models       |         | include:  |         |         |                   |               |              |                 |
(cid:136)
| Spot                    | delivery | (cid:21) | pay per | proof, | on  | demand.        |          |     |
| ----------------------- | -------- | -------- | ------- | ------ | --- | -------------- | -------- | --- |
| (cid:136) Subscriptions |          | (cid:21) | regular | access | to  | veri(cid:28)ed | bundles. |     |
(cid:136)
| Latency            | arbitrage |     | (cid:21) pay | more | for   | faster  | proof delivery. |         |
| ------------------ | --------- | --- | ------------ | ---- | ----- | ------- | --------------- | ------- |
| (cid:136) Archival | retrieval |     | (cid:21) pay | to   | fetch | expired | or deep-history | proofs. |
Example: imagine a decentralized CDN for cryptographic proofs, where nodes are paid small fees
to store and serve validation bundles. Those fees represent the price of veri(cid:28)ability.
| 6.3 Mini-Blueprint: |     |     | Proof | Relay |     | Network |     |     |
| ------------------- | --- | --- | ----- | ----- | --- | ------- | --- | --- |
Actors
| (cid:136) Veri(cid:28)er | (cid:21) | bounded | client | performing |     | checks. |     |     |
| ------------------------ | -------- | ------- | ------ | ---------- | --- | ------- | --- | --- |
(cid:136)
| Relay              | (cid:21) untrusted |                 | distributor |     | caching |            | and serving proofs. |     |
| ------------------ | ------------------ | --------------- | ----------- | --- | ------- | ---------- | ------------------- | --- |
| (cid:136) Producer |                    | (cid:21) entity | generating  |     | or      | publishing | proofs.             |     |
(cid:136)
| Index | Peer | (cid:21) optional |     | catalog | listing | available | bundles. |     |
| ----- | ---- | ----------------- | --- | ------- | ------- | --------- | -------- | --- |
Objects
(cid:136)
Bundle Descriptor (d ) (cid:21) metadata such as size, anchor, and dependencies.
B
| (cid:136) |        | (B) |              |      |          |      |     |     |
| --------- | ------ | --- | ------------ | ---- | -------- | ---- | --- | --- |
| Proof     | Bundle |     | (cid:21) the | full | artifact | set. |     |     |
(cid:136) Refusal Witness (w ) (cid:21) structured message indicating failed veri(cid:28)cation.
R
| Veri(cid:28)cation | Steps  |       | (client-side): |     |     |     |     |     |
| ------------------ | ------ | ----- | -------------- | --- | --- | --- | --- | --- |
| 1. Verify          | anchor | chain | segment.       |     |     |     |     |     |

| 2. Verify | inclusion         | witness. |          |     |            |     |     |
| --------- | ----------------- | -------- | -------- | --- | ---------- | --- | --- |
| 3. Verify | account linkage.  |          |          |     |            |     |     |
| 4. Verify | proof under       | schema   | keys.    |     |            |     |     |
| 5. Return | one of: VERIFIED, |          | REFUSED, |     | DISPROVEN. |     |     |
Relay Duties
(cid:136)
| Cache              | popular bundles. |           |     |          |     |     |     |
| ------------------ | ---------------- | --------- | --- | -------- | --- | --- | --- |
| (cid:136) Prefetch | frequently       | requested |     | anchors. |     |     |     |
(cid:136)
| Compress  | or aggregate             |     | bundles | (without | altering | validity).  |           |
| --------- | ------------------------ | --- | ------- | -------- | -------- | ----------- | --------- |
| Economic  | Signals                  |     |         |          |          |             |           |
| (cid:136) |                          |     |         |          |          | (cid:25)    |           |
| Frequent  | REFUSED_DATA_UNAVAILABLE |     |         |          |          | opportunity | to cache. |
(cid:136) Frequent REFUSED_COST_EXCEEDED (cid:25) opportunity to aggregate proofs.
| (cid:136) |     |     |     |     | (cid:25) |     |     |
| --------- | --- | --- | --- | --- | -------- | --- | --- |
Frequent REFUSED_OUT_OF_SCOPE opportunity to provide archival access.
Inotherwords, everyrefusalhighlightsanunmetdemand, muchasemptyshelvesinastoreindicate
what customers want most. Relays that (cid:28)ll these gaps pro(cid:28)t from serving veri(cid:28)ability where it is
scarce.
This mechanism becomes the foundation for the self-reinforcing peer-to-peer loop explored later in
Part VII.
| Part IV:    | Coordination   |             | Without |       | Trust |     |     |
| ----------- | -------------- | ----------- | ------- | ----- | ----- | --- | --- |
| 7. Absence  | as a           | First-Class |         | State |       |     |     |
| 7.1 Silence | Is Information |             |         |       |       |     |     |
In traditional networks, silence or lack of response usually means failure. But in a veri(cid:28)cation-(cid:28)rst
environment,silencecarriesmeaning. Whenaveri(cid:28)erreturnsREFUSED_DATA_UNAVAILABLE,
| that absence       | communicates     |     | a precise | truth:     |                 |     |     |
| ------------------ | ---------------- | --- | --------- | ---------- | --------------- | --- | --- |
| (cid:16)This proof | is not available |     | within    | my current | bounds.(cid:17) |     |     |
Absencebecomesasignal,notavoid. Forexample,ifmultiplepeersallrefuseaclaimduetomissing
data, that collective silence highlights a genuine gap in the network’s veri(cid:28)ability coverage(cid:22)similar
to how repeated (cid:16)out-of-stock(cid:17) noti(cid:28)cations signal a supply shortage in a marketplace.

Proposition 1. Because proofs are source-agnostic, the only distinction that matters is whether
a veri(cid:28)er: (a) possesses a veri(cid:28)able proof, or (b) does not. Coordination therefore cannot rely on
responses from trusted services(cid:22)it must rely on the presence or absence of veri(cid:28)able artifacts.
This principle transforms how systems coordinate. Rather than relying on servers to con(cid:28)rm every
state, peers learn from what cannot yet be veri(cid:28)ed and adjust behavior accordingly.
| 7.2 Biological |     | Analogy |     |     |     |     |
| -------------- | --- | ------- | --- | --- | --- | --- |
Refusal behaves less like an error and more like a feedback signal in living systems. It resembles
pain in biology: it informs the organism where demand exceeds capacity.
When veri(cid:28)cation demand outpaces proof supply, refusals cluster(cid:22)just as repeated strain signals
the body to strengthen a weak muscle. In this sense, refusal acts as the network’s nervous system,
| continuously |                          | identifying | pressure    | points in   | the (cid:29)ow | of veri(cid:28)ability. |
| ------------ | ------------------------ | ----------- | ----------- | ----------- | -------------- | ----------------------- |
| 8. Markets   |                          | Replace     | Services    |             |                |                         |
| 8.1 Why      | Services                 |             | Fail Under  | Refusal     |                |                         |
| Traditional  | (cid:16)services(cid:17) |             | assume two  | things:     |                |                         |
| 1. A         | service                  | can always  | return      | an answer.  |                |                         |
| 2. Clients   | can                      | act on      | that answer | as correct. |                |                         |
Under veri(cid:28)cation-(cid:28)rst semantics, both assumptions collapse. An answer without veri(cid:28)able proof
has no operational meaning. Correctness arises only from local veri(cid:28)cation, not from the mere
| availability | of  | responses. |     |     |     |     |
| ------------ | --- | ---------- | --- | --- | --- | --- |
Theorem 3 (Service Incoherence). Any service claiming correctness without proofs implicitly rein-
troduces trust and therefore becomes incoherent within a veri(cid:28)cation-(cid:28)rst system.
In other words, a (cid:16)price oracle(cid:17) that merely tells users a price reintroduces faith; one that shows
| users a | veri(cid:28)able | proof | of the price | preserves | correctness. |     |
| ------- | ---------------- | ----- | ------------ | --------- | ------------ | --- |
Hence,inthisparadigm,artifactsuppliers(cid:22)entitiesthatdistributeveri(cid:28)ablebytes(cid:22)replaceservices
| as the | core building |     | blocks. |     |     |     |
| ------ | ------------- | --- | ------- | --- | --- | --- |

| 8.2 Mini-Blueprint: |     | Veri(cid:28)able |     | Price | Feeds |     |     |     |
| ------------------- | --- | ---------------- | --- | ----- | ----- | --- | --- | --- |
Goal: Design oracle-like feeds that function without trusted intermediaries.
Actors
(cid:136)
| Publisher                | (O):           | Issues | signed | price | statements. |       |     |     |
| ------------------------ | -------------- | ------ | ------ | ----- | ----------- | ----- | --- | --- |
| (cid:136) Veri(cid:28)er | (V): Validates |        | proofs | or    | refuses     | them. |     |     |
(cid:136)
| Consumer | (Z): | Uses | only veri(cid:28)ed |     | data. |     |     |     |
| -------- | ---- | ---- | ------------------- | --- | ----- | --- | --- | --- |
Objects
(cid:136)
| Price statement        |       | s =          | (asset,price,t,context) |       |            |     |      |     |
| ---------------------- | ----- | ------------ | ----------------------- | ----- | ---------- | --- | ---- | --- |
| (cid:136) Proof bundle | B     | = {publisher |                         | key,σ | (s),anchor |     | ref} |     |
|                        |       | s            |                         |       | O          |     |      |     |
| Veri(cid:28)cation     | Steps |              |                         |       |            |     |      |     |
σ (s).
| 1. Verify       | the publisher’s |           | digital | signature |        | O             |     |                 |
| --------------- | --------------- | --------- | ------- | --------- | ------ | ------------- | --- | --------------- |
| 2. Check        | that the        | timestamp |         | t falls   | within | the freshness |     | policy.         |
| 3. If the price | is anchored,    |           | verify  | inclusion |        | within        | the | current ledger. |
| Refusal Cases   |                 |           |         |           |        |               |     |                 |
(cid:136)
| OUT_OF_SCOPE               |     |     | (cid:22) Anchor | is    | too old | to con(cid:28)rm. |       |           |
| -------------------------- | --- | --- | --------------- | ----- | ------- | ----------------- | ----- | --------- |
| (cid:136) DATA_UNAVAILABLE |     |     | (cid:22)        | Proof | missing | from              | cache | or relay. |
(cid:136)
| COST_EXCEEDED |     |     | (cid:22) Proof | too | large | to verify | within | limits. |
| ------------- | --- | --- | -------------- | --- | ----- | --------- | ------ | ------- |
The key insight: The feed does not transmit truth, only claims that become usable once each
| veri(cid:28)er con(cid:28)rms | them | within | its | own | R V . |     |     |     |
| ----------------------------- | ---- | ------ | --- | --- | ----- | --- | --- | --- |
Example: A decentralized exchange could use dozens of such feeds. Even if half of them refuse
(duetomissingdata),thesystemremainscorrect(cid:22)nounveri(cid:28)eddataisused. Refusalmerelydelays
| updates rather | than               | introducing |     | risk. |     |     |     |     |
| -------------- | ------------------ | ----------- | --- | ----- | --- | --- | --- | --- |
| 9. Local       | Truth Zones        |             |     |       |     |     |     |     |
| 9.1 Scoped     | Veri(cid:28)cation |             |     |       |     |     |     |     |
Because each veri(cid:28)er operates under di(cid:27)erent resource bounds, there can be no universal truth
visible to all participants simultaneously. Each veri(cid:28)er maintains a local truth zone(cid:22)the subset of
| claims it can | currently | verify: |     |     |     |     |     |     |
| ------------- | --------- | ------- | --- | --- | --- | --- | --- | --- |

|     |     |     | TZ(V) | =   | {c | P(c,D |     | ,R ) | ̸= REFUSED} |
| --- | --- | --- | ----- | --- | ---------- | --- | ---- | ----------- |
|     |     |     |       |     |            | V   | V    |             |
This means correctness is relative to scope. Your mobile device may know 10,000 veri(cid:28)ed claims;
an archival node might know 10 million. Both are correct within their zones.
In social terms, it’s like local communities each maintaining veri(cid:28)ed records of events(cid:22)truth is
consistent within a community but requires proofs to bridge communities safely.
Implication: Applications must be designed so their logic still works when di(cid:27)erent participants
| see di(cid:27)erent | veri(cid:28)ed | subsets      | of  | reality. |     |     |     |     |
| ------------------- | -------------- | ------------ | --- | -------- | --- | --- | --- | --- |
| 9.2 Composable      |                | Micro-Truths |     |          |     |     |     |     |
(cid:16)Micro-truths(cid:17) are small, individually veri(cid:28)ed claims (e.g., (cid:16)Alice sent Bob 1 token at anchor 100(cid:17)).
Applications can combine these micro-truths into larger composite truths(cid:22)as long as all underlying
| proofs remain | in  | scope. |     |     |     |     |     |     |
| ------------- | --- | ------ | --- | --- | --- | --- | --- | --- |
However, refusal propagates upward: if any sub-claim becomes unveri(cid:28)able, the whole composite
| claim must | also | be refused. |     |     |     |     |     |     |
| ---------- | ---- | ----------- | --- | --- | --- | --- | --- | --- |
Example: Imagineverifyingagame’sleaderboardwhereeachscoreproofdependsonearlierrounds.
If even one old match proof expires or leaves scope, the leaderboard cannot be veri(cid:28)ed globally(cid:22)it
| becomes | partially | refused. |     |     |     |     |     |     |
| ------- | --------- | -------- | --- | --- | --- | --- | --- | --- |
This cascading refusal property ensures the system never fabricates truth from missing data. It
aligns with scienti(cid:28)c methodology: if one experiment’s data is unveri(cid:28)able, the overall conclusion
| must pause    | until   | evidence  | is restored. |      |                  |     |         |     |
| ------------- | ------- | --------- | ------------ | ---- | ---------------- | --- | ------- | --- |
| Part V:       | Time,   | Ordering, |              |      | and O(cid:31)ine |     | Reality |     |
| 10. Time      | Without |           | Clocks       |      |                  |     |         |     |
| 10.1 Momentum |         | Ordering  | as           | Time |                  |     |         |     |
In networks with intermittent or asynchronous connections, participants cannot rely on a shared
physical clock. Instead, Zenon uses Momentum ordering to de(cid:28)ne a veri(cid:28)able concept of time. An
| event’s position |     | in the | Momentum | sequence |     | acts as | its timestamp. |     |
| ---------------- | --- | ------ | -------- | -------- | --- | ------- | -------------- | --- |
De(cid:28)nition 4 (Momentum-Time). Event A precedes event B if its commitment anchor appears at
| a lower | Momentum | height | or earlier |     | within | the same | height | ordering. |
| ------- | -------- | ------ | ---------- | --- | ------ | -------- | ------ | --------- |

This means that (cid:16)before(cid:17) and (cid:16)after(cid:17) are de(cid:28)ned not by wall-clock hours, but by anchored order(cid:22)a
| sequence | that | all veri(cid:28)ers | can | check | independently. |     |
| -------- | ---- | ------------------- | --- | ----- | -------------- | --- |
Analogy: Think of Momentum ordering like page numbers in a shared ledger. Even if two people
read at di(cid:27)erent speeds, they agree that page 10 comes before page 11. Similarly, veri(cid:28)ers can
independently con(cid:28)rm event order without needing synchronized clocks.
Applications built on Zenon should express time-sensitive logic (such as expirations, rate limits, or
contractwindows)usingtheseanchorheightsratherthanabsolutetimestamps. Forexample, aloan
contract might mature after 200 Momentum intervals rather than (cid:16)7 days,(cid:17) ensuring veri(cid:28)ability
| without        | relying | on         | local clock | accuracy. |                  |           |
| -------------- | ------- | ---------- | ----------- | --------- | ---------------- | --------- |
| 10.2 Verifying |         | Order      | Without     |           | Synchrony        |           |
| To prove       | that    | A occurred |             | before B, | a veri(cid:28)er | supplies: |
(cid:136)
| Inclusion     |        | proofs | for both | anchors, | and      |       |
| ------------- | ------ | ------ | -------- | -------- | -------- | ----- |
| (cid:136) The | header | chain  | segment  | that     | connects | them. |
Ifeitheranchorfallsoutsidescope,theveri(cid:28)ermustoutputREFUSED_OUT_OF_SCOPEinstead
| of assuming |     | the order. |     |     |     |     |
| ----------- | --- | ---------- | --- | --- | --- | --- |
This rule prevents unveri(cid:28)able guesswork. For example, in distributed ledgers, guessing event order
without evidence can cause double-spend disputes. Zenon avoids this by formalizing (cid:16)I don’t know(cid:17)
| as the | honest | answer(cid:22)REFUSED. |     |     |     |     |
| ------ | ------ | ---------------------- | --- | --- | --- | --- |
Thus, refusal is safer than assumption, preserving integrity even under uncertain or o(cid:31)ine condi-
tions.
| 11. O(cid:31)ine |              | as Default |             |       |     |     |
| ---------------- | ------------ | ---------- | ----------- | ----- | --- | --- |
| 11.1 The         | O(cid:31)ine |            | Interaction | Model |     |     |
Mostreal-worldusers(cid:22)especiallythoseonmobiledevices, inrestrictedregions, orwithintermittent
connectivity(cid:22)operate o(cid:31)ine by default. Zenon’s veri(cid:28)cation-(cid:28)rst architecture embraces this reality
| rather       | than treating |        | it as a | limitation. |     |     |
| ------------ | ------------- | ------ | ------- | ----------- | --- | --- |
| Applications |               | should | assume: |             |     |     |
(cid:136)
Local intent creation (e.g., user prepares a payment or message o(cid:31)ine),
(cid:136) Portable, proof-carried objects (e.g., digital receipts that can later be veri(cid:28)ed),

(cid:136)
Deferred anchoring (the act of later submitting proofs to Momentum), and
(cid:136) Explicitexpirationandcon(cid:29)icthandling(policiesforwhathappensifaclaimcannotbeveri(cid:28)ed
| when       | reconnected). |                     |     |     |
| ---------- | ------------- | ------------------- | --- | --- |
| The design | question,     | therefore, becomes: |     |     |
(cid:16)What artifacts must I carry to remain veri(cid:28)able later?(cid:17) rather than (cid:16)How do I stay online all the
time?(cid:17)
Example: A traveler in a remote area can sign and exchange veri(cid:28)ed payment proofs using local
devices, then anchor them once reconnected. The integrity of these transactions does not depend
| on continuous        | internet | access.        |          |     |
| -------------------- | -------- | -------------- | -------- | --- |
| 11.2 Mini-Blueprint: |          | Delay-Tolerant | Payments |     |
Goal: Enable payments that are secure, veri(cid:28)able, and portable(cid:22)even without trusted hardware,
| constant | connectivity, | or instant (cid:28)nality. |     |     |
| -------- | ------------- | -------------------------- | --- | --- |
Actors
| (cid:136) Payer | (A) |     |     |     |
| --------------- | --- | --- | --- | --- |
(cid:136)
| Payee           | (B)                |       |     |     |
| --------------- | ------------------ | ----- | --- | --- |
| (cid:136) Local | veri(cid:28)ers (V | , V ) |     |     |
A B
(cid:136)
| Optional           | relays | (R)             |                       |     |
| ------------------ | ------ | --------------- | --------------------- | --- |
| (cid:136) Momentum | plane  | (anchors global | order when available) |     |
Objects
| (cid:136) Payment | intent: | τ = (A,B,amount,nonce,expiry) |     |     |
| ----------------- | ------- | ----------------------------- | --- | --- |
(cid:136)
| Payer | signature: | σ (τ) |     |     |
| ----- | ---------- | ----- | --- | --- |
A
| (cid:136) Spend | proof: π |     |     |     |
| --------------- | -------- | --- | --- | --- |
spend
(cid:136)
| Receipt: | ρ   |     |     |     |
| -------- | --- | --- | --- | --- |
B
| (cid:136)    |                | B             |     |     |
| ------------ | -------------- | ------------- | --- | --- |
| Deferred     | proof bundle:  | τ             |     |     |
| O(cid:31)ine | Exchange Steps |               |     |     |
| 1. A creates | and signs      | the intent τ. |     |     |
2. A provides a spend proof showing that funds are valid under a recent anchor.
| 3. B veri(cid:28)es | the signature, | proof, and | expiry against | local policy. |
| ------------------- | -------------- | ---------- | -------------- | ------------- |

| 4. If all | checks | pass | within | local bounds, |     | B issues | receipt ρ . |
| --------- | ------ | ---- | ------ | ------------- | --- | -------- | ----------- |
B
O(cid:31)ine Outcomes
| (cid:136) VERIFIED-LOCAL |     |     | (cid:22) | proof valid | within | cached | data. |
| ------------------------ | --- | --- | -------- | ----------- | ------ | ------ | ----- |
(cid:136)
| REFUSED           |     | (cid:22) veri(cid:28)cation |      | exceeds | bounds     | or data | missing. |
| ----------------- | --- | --------------------------- | ---- | ------- | ---------- | ------- | -------- |
| (cid:136) EXPIRED |     | (cid:22) intent             | past | expiry  | threshold. |         |          |
Deferred Reconciliation When either party reconnects, they submit B τ to Momentum for an-
choring. If both A and B anchor con(cid:29)icting spends, only one will verify as true(cid:22)the other becomes
| DISPROVEN |     | or REFUSED. |     |     |     |     |     |
| --------- | --- | ----------- | --- | --- | --- | --- | --- |
This ensures consistency without requiring continuous connection or a trusted intermediary.
Design Note: O(cid:31)ine payments demand explicit risk policies (e.g., setting per-day limits). This
isn’t a defect but a transparent re(cid:29)ection of bounded veri(cid:28)cation(cid:22)risk is visible and quanti(cid:28)able
| rather than | hidden | behind |     | trust. |     |     |     |
| ----------- | ------ | ------ | --- | ------ | --- | --- | --- |
Analogy: It’s like using signed cashier’s checks instead of live bank transfers. Each check can
circulate safely o(cid:31)ine, but (cid:28)nal settlement occurs once banks reconnect and verify records.
| 12. Synchronization |     |      | Is       | Optional |     |     |     |
| ------------------- | --- | ---- | -------- | -------- | --- | --- | --- |
| 12.1 Correctness    |     | Over | Liveness |          |     |     |     |
In traditional networks, staying synchronized is vital for correctness. In veri(cid:28)cation-(cid:28)rst systems,
| correctness | is  | independent | of  | synchronization. |     |     |     |
| ----------- | --- | ----------- | --- | ---------------- | --- | --- | --- |
A veri(cid:28)er remains correct even when it refuses new claims or operates o(cid:31)ine. Refusal preserves
truth(cid:22)it prevents the system from assuming unveri(cid:28)ed information. Synchronization only a(cid:27)ects
| freshness, | not | validity. |     |     |     |     |     |
| ---------- | --- | --------- | --- | --- | --- | --- | --- |
Analogy: A library can stop accepting new books while it audits its existing collection. It tem-
porarily halts updates but doesn’t lose correctness about what’s already catalogued.
| 12.2 Eventual |     | Anchoring |     |     |     |     |     |
| ------------- | --- | --------- | --- | --- | --- | --- | --- |
Claims created o(cid:31)ine can later be anchored once connectivity returns. Soundness is preserved
| because | unanchored | claims |     | are never | labeled | VERIFIED. |     |
| ------- | ---------- | ------ | --- | --------- | ------- | --------- | --- |
Duringo(cid:31)ineormissing-dataperiods,thecorrectresponseremainsREFUSED.Onceproofsbecome
| available, | those | same | claims | can transition |     | to VERIFIED. |     |
| ---------- | ----- | ---- | ------ | -------------- | --- | ------------ | --- |

This pattern resembles asynchronous messaging systems: a message sent while o(cid:31)ine queues locally
and delivers once the connection is restored, but until acknowledged, its status remains unveri(cid:28)ed.
Thus, synchronization becomes a convenience, not a prerequisite for truth. Systems built this way
are naturally resilient to disconnection, censorship, and unreliable networks.
Part VI: Application Shape Under Veri(cid:28)cation-First Architecture
| 13. Why     | Global State | Fails                       |     |
| ----------- | ------------ | --------------------------- | --- |
| 13.1 Global | Mutable      | State Is Unveri(cid:28)able |     |
In execution-(cid:28)rst systems (like traditional blockchains or databases), applications often rely on a
single global state(cid:22)a shared source of truth that everyone reads and writes to. However, under
bounded veri(cid:28)cation, maintaining such a universal state becomes mathematically and physically
impossible.
Each veri(cid:28)er has (cid:28)nite resources (R ), meaning it cannot con(cid:28)rm every change across the entire
V
network. Trying to verify arbitrary global state would require unbounded computation, storage,
| and bandwidth, | forcing | most veri(cid:28)ers | to return REFUSED. |
| -------------- | ------- | -------------------- | ------------------ |
Therefore, global mutable state is not only ine(cid:30)cient(cid:22)it’s structurally unveri(cid:28)able. The network
cannot safely guarantee that every participant sees the same data because each veri(cid:28)er’s window of
| truth is | bounded by its own | capacity. |     |
| -------- | ------------------ | --------- | --- |
Analogy: Imagine trying to keep a single, live spreadsheet updated across millions of users where
each user’s computer can only process a fraction of the data. Some rows will inevitably go out of
sync. The only safe solution is for each participant to keep a personal copy of relevant rows and
| reconcile | di(cid:27)erences when | possible. |     |
| --------- | ---------------------- | --------- | --- |
This is exactly what the Zenon model enforces: localized, veri(cid:28)able state replaces a single global
ledger.
| 13.2 Localized | State Machines |     |     |
| -------------- | -------------- | --- | --- |
The sustainable application pattern in a veri(cid:28)cation-(cid:28)rst world looks very di(cid:27)erent. Instead of
global mutable state, systems adopt localized state machines(cid:22)each maintaining its own append-
only history.
| Typical | architecture: |     |     |
| ------- | ------------- | --- | --- |
(cid:136) Local append-only logs (e.g., account-chains or app-speci(cid:28)c histories),

(cid:136)
| Periodic                | anchoring | into         | the global | Momentum | chain,  |     |
| ----------------------- | --------- | ------------ | ---------- | -------- | ------- | --- |
| (cid:136) Proof-carried |           | interactions | between    | local    | states. |     |
Eachparticipant’sstateevolvesindependentlybutremainsveri(cid:28)ablethroughsharedanchors. When
two participants interact, they exchange proofs of state rather than synchronized records.
Example: In a decentralized game, each player’s actions update their personal log. When two
players interact (e.g., a duel or trade), they exchange proofs of their respective game states. The
outcome becomes veri(cid:28)able once both logs are anchored into Momentum. No global game server is
| needed(cid:22)only | proof | exchange | and delayed |     | anchoring. |     |
| ------------------ | ----- | -------- | ----------- | --- | ---------- | --- |
This design mirrors the structure of asynchronous communication in distributed systems: messages
carryembeddedevidence(proofs)insteadofrelyingonacentraltruthsource. Con(cid:29)icts(cid:22)likedouble
spends or contradictory actions(cid:22)are resolved at anchoring time, when proofs are compared.
The result is an ecosystem where each application behaves like a self-contained cell that connects to
othersthroughveri(cid:28)ablemembranesofproofs. Thisarchitectureenablesmassivescalabilitywithout
| sacri(cid:28)cing | correctness. |                  |     |     |           |      |
| ----------------- | ------------ | ---------------- | --- | --- | --------- | ---- |
| Part              | VII:         | The Self-Driving |     | P2P | Expansion | Loop |
| 14. The           | Loop         | De(cid:28)ned    |     |     |           |      |
Bounded veri(cid:28)cation creates scarcity. Scarcity creates markets for proofs. Markets for proofs
incentivize caching and relaying. Caching and relaying expand veri(cid:28)ability coverage. Expanded
| coverage   | reduces | scarcity(cid:22)until | new          | demand | emerges again. |     |
| ---------- | ------- | --------------------- | ------------ | ------ | -------------- | --- |
| This forms | Zenon’s | self-driving          | peer-to-peer |        | loop:          |     |
Scarcity ⇒ Markets ⇒ Relay Incentives ⇒ Expanded Access ⇒ Renewed Demand
Eachstagereinforcesthenext, creatinganautonomiceconomicfeedbacksystem. Whenveri(cid:28)ability
lags, relays and caching nodes gain pro(cid:28)t motives to (cid:28)ll the gap. When proof coverage grows,
| veri(cid:28)cation | costs | fall, allowing | more | users | to join. |     |
| ------------------ | ----- | -------------- | ---- | ----- | -------- | --- |
This is similar to how bandwidth markets developed in the early internet: as users demanded faster
access, content delivery networks (CDNs) emerged to pro(cid:28)t from caching and distributing high-
demand data. Over time, these incentives built a more resilient, self-balancing network without
| centralized | planning. |     |     |     |     |     |
| ----------- | --------- | --- | --- | --- | --- | --- |
In the same way, Zenon’s refusal-driven economics ensure that the network adapts to scarcity
automatically. No governance vote or hard fork is needed(cid:22)supply and demand for veri(cid:28)ability

| regulate   | themselves. |     |     |     |
| ---------- | ----------- | --- | --- | --- |
| 15. Relay  | Economics   |     |     |     |
| 15.1 Relay | Incentives  |     |     |     |
Every REFUSED_DATA_UNAVAILABLE message signals unmet veri(cid:28)cation demand(cid:22)someone
tried to verify a proof, but the data was missing or out of scope. This (cid:16)refusal pressure(cid:17) creates
natural business opportunities for relays, peers who store and distribute proofs more e(cid:30)ciently than
others.
| Relays earn       | value by:   |         |     |     |
| ----------------- | ----------- | ------- | --- | --- |
| (cid:136) Caching | high-demand | proofs, |     |     |
(cid:136)
| Delivering            | them | faster or more | cheaply, |     |
| --------------------- | ---- | -------------- | -------- | --- |
| (cid:136) Compressing | and  | aggregating    | bundles, | and |
(cid:136)
| Staying | untrusted | (clients | always | re-verify proofs). |
| ------- | --------- | -------- | ------ | ------------------ |
They do not need protocol privileges like miners or validators; their incentive is purely economic.
The more refusals exist in an area of the network, the more pro(cid:28)table it becomes to (cid:28)ll that
| veri(cid:28)cation | gap. |     |     |     |
| ------------------ | ---- | --- | --- | --- |
This is similar to how content delivery networks (CDNs) emerged on the internet: when users
experienced slow downloads, companies began caching popular (cid:28)les closer to users. Each cache
node was paid indirectly through performance demand (cid:22) not by central coordination.
Likewise, in Zenon, relays pro(cid:28)t by being the fastest or most available suppliers of scarce proofs.
Formally, relay pro(cid:28)tability correlates with refusal density (cid:22) the number of refusals in a given
veri(cid:28)cation neighborhood. The higher the density, the greater the incentive to provide that missing
data.
| 15.2 Emergent | Strati(cid:28)cation |     |     |     |
| ------------- | -------------------- | --- | --- | --- |
Over time, economic specialization naturally arises within the network. Di(cid:27)erent nodes evolve
| toward roles | based | on their resources | and | local economics: |
| ------------ | ----- | ------------------ | --- | ---------------- |
(cid:136)
Light peers: Operate on low power or mobile devices, verifying only small, frequent claims
| (e.g., | payments). |     |     |     |
| ------ | ---------- | --- | --- | --- |
(cid:136)
Heavy peers: Maintain extended historical windows and handle larger proof bundles.

(cid:136)
Relays: Specializeinbandwidthandlatencyarbitrage(cid:22)fetchingandservingproofse(cid:30)ciently.
(cid:136) Archivists: Store rare or historical proofs and sell retrieval access when old data becomes
valuable.
No central authority assigns these roles; the system self-organizes. The economy of refusals acts as
a balancing force: where veri(cid:28)ability is scarce, new supply appears; where it’s abundant, prices fall,
| and resources | shift | elsewhere. |     |     |     |     |
| ------------- | ----- | ---------- | --- | --- | --- | --- |
Analogy: This is the same mechanism that underlies free-market logistics: delivery companies
emerge where goods are hard to obtain, while overserved regions naturally lose providers. The
| Zenon network  | behaves |           | like a living | economy | of veri(cid:28)ability. |     |
| -------------- | ------- | --------- | ------------- | ------- | ----------------------- | --- |
| 16. Autonomic  |         | Expansion |               |         |                         |     |
| 16.1 Incentive |         | Gradient  |               |         |                         |     |
Each refusal e(cid:27)ectively generates a gradient of incentive (cid:22) a directional (cid:16)pull(cid:17) encouraging some
| node to | satisfy that | unmet | veri(cid:28)cation |     | request. |     |
| ------- | ------------ | ----- | ------------------ | --- | -------- | --- |
Nodes that respond to these gradients by caching, serving, or reproducing proofs gain both reputa-
tion and potential fees. As refusals accumulate, the network (cid:16)learns(cid:17) where coverage is insu(cid:30)cient
| and expands | there | automatically. |     |     |     |     |
| ----------- | ----- | -------------- | --- | --- | --- | --- |
This property is known as autonomic expansion: the network grows its own veri(cid:28)cation coverage in
| response | to scarcity, | without | coordination, |     | voting, or protocol | change. |
| -------- | ------------ | ------- | ------------- | --- | ------------------- | ------- |
Analogy: This is similar to how biological ecosystems adapt: plants grow where nutrients are
available, and species proliferate in underpopulated niches. In Zenon, data (cid:29)ows and economic
signals take the place of ecological feedback (cid:22) refusals are the soil conditions, and relays are the
| adaptive        | species | (cid:28)lling the | gap.      |           |     |     |
| --------------- | ------- | ----------------- | --------- | --------- | --- | --- |
| 16.2 Comparison |         | to                | Consensus | Expansion |     |     |
Traditional blockchain scaling relies on explicit consensus-driven expansion (cid:22) e.g., adding val-
idators, sharding, or governance proposals. These mechanisms require coordination, voting, and
| updates | to the base | protocol. |     |     |     |     |
| ------- | ----------- | --------- | --- | --- | --- | --- |
In contrast, veri(cid:28)cation-(cid:28)rst systems expand through local economics: each node reacts indepen-
| dently to | local scarcity |     | signals (refusals) |     | and (cid:28)lls gaps accordingly. |     |
| --------- | -------------- | --- | ------------------ | --- | --------------------------------- | --- |

Thus, growth follows economic gradients, not committee decisions. This makes Zenon’s scaling
| model organic | and continuous | (cid:22) | not | episodic or | bureaucratic. |
| ------------- | -------------- | -------- | --- | ----------- | ------------- |
Just as decentralized (cid:28)le-sharing networks automatically replicate popular (cid:28)les where demand is
highest, Zenon relays naturally propagate the most valuable proofs across the network.
| 17. Stability | Under   | Scarcity |     |     |     |
| ------------- | ------- | -------- | --- | --- | --- |
| 17.1 Refusal  | Dampens | Shock    |     |     |     |
In most systems, when demand exceeds capacity, the network experiences overload (cid:22) queues grow,
errors multiply, or data becomes inconsistent. In a veri(cid:28)cation-(cid:28)rst system, overload is handled
| gracefully | through refusal. |     |     |     |     |
| ---------- | ---------------- | --- | --- | --- | --- |
When veri(cid:28)ers reach their capacity, they stop verifying new claims and simply return REFUSED.
| This preserves | correctness | and prevents |     | cascades | of failure. |
| -------------- | ----------- | ------------ | --- | -------- | ----------- |
Instead of crashing, the system pauses. Rather than lying, it says (cid:16)I don’t know.(cid:17)
Example: During high network load, some users’ wallets might refuse to verify new transactions
until more bandwidth or proofs are available. Those transactions remain pending, not lost or falsely
con(cid:28)rmed.
This behavior acts as an automatic safety valve, absorbing stress without breaking integrity (cid:22) a
| property many | real-world | (cid:28)nancial | systems | lack. |     |
| ------------- | ---------- | --------------- | ------- | ----- | --- |
17.2 Anti-Fragility
Because refusal is both safe and informative, Zenon becomes anti-fragile (cid:22) it grows stronger un-
der pressure. When a stress event occurs (such as a regional network outage or sudden surge in
veri(cid:28)cation requests), local refusals mark exactly where coverage failed.
These refusals create pro(cid:28)t signals for relays and proof distributors, who then (cid:28)ll those gaps. Over
| time, the         | areas that once | experienced |         | scarcity become | the best served. |
| ----------------- | --------------- | ----------- | ------- | --------------- | ---------------- |
| In this sense,    | the network     | learns      | through | stress:         |                  |
| (cid:136) Failure | zones become    | incentive   | zones.  |                 |                  |
(cid:136)
| Refusals             | drive resource | reallocation. |     |           |                              |
| -------------------- | -------------- | ------------- | --- | --------- | ---------------------------- |
| (cid:136) The system | self-heals     | by rewarding  |     | those who | restore veri(cid:28)ability. |

Analogy: It’s like how power grids adapt after blackouts (cid:22) outages signal where infrastructure
investment is needed most. In Zenon, refusals are the outage reports, and relay nodes are the
| responders | who | earn by | restoring | service. |     |     |
| ---------- | --- | ------- | --------- | -------- | --- | --- |
Thus, scarcity does not destabilize the system; it teaches the system how to grow. Refusal is not a
| bug (cid:22)            | it is the          | immune    | system     | of veri(cid:28)cation-(cid:28)rst |               | architecture. |
| ----------------------- | ------------------ | --------- | ---------- | --------------------------------- | ------------- | ------------- |
| Part                    | VIII:              | Synthesis |            | and                               | Inevitability |               |
| 18. From                | Veri(cid:28)cation |           |            | to Civilization                   |               |               |
| 18.1 Veri(cid:28)cation |                    | as        | a Societal | Primitive                         |               |               |
For most of computing history, systems have operated under an execution-(cid:28)rst mindset (cid:22) we run
processes, store results, and only later check if they were correct. The veri(cid:28)cation-(cid:28)rst approach
| reverses | this order: | correctness |     | is proven | before | action is accepted. |
| -------- | ----------- | ----------- | --- | --------- | ------ | ------------------- |
This shift has consequences far beyond blockchain architecture. When veri(cid:28)cation precedes execu-
tion, trust transitions from being a social assumption to a technical artifact.
Over time, this reordering begins to mirror how civilizations themselves evolve:
(cid:136) Proofs replace trust. People no longer rely on institutional authority but on veri(cid:28)able evidence
| (cid:22) | like digitally | notarized |     | contracts | instead | of promises. |
| -------- | -------------- | --------- | --- | --------- | ------- | ------------ |
(cid:136)
Absence replaces uncertainty. A missing proof is not suspicious; it simply de(cid:28)nes where knowl-
| edge | ends. |     |     |     |     |     |
| ---- | ----- | --- | --- | --- | --- | --- |
(cid:136)
Scarcity drives order. Finite veri(cid:28)cation capacity forces prioritization and economic value
| around | truth. |     |     |     |     |     |
| ------ | ------ | --- | --- | --- | --- | --- |
Example: Consider how digital signatures have already replaced handwritten ones in modern
contracts. Veri(cid:28)cation-(cid:28)rst systems extend this logic (cid:22) not only the signature, but the entire
| transaction, | identity, | and | context | become | veri(cid:28)able | artifacts. |
| ------------ | --------- | --- | ------- | ------ | ---------------- | ---------- |
Veri(cid:28)cation ceases to be a background process. It becomes a civic function, woven into how com-
munities record, trade, and coordinate. Much as accounting, law, and currency shaped earlier
civilizations, veri(cid:28)cation bandwidth becomes the organizing principle of the digital economy.

18.2 The Economic Arrow
Boundedveri(cid:28)cationmakestruthameasurable, quanti(cid:28)ableresource. Oncetruthcanbemeasured,
it can also be allocated (cid:22) and anything scarce and allocatable naturally forms a market.
Veri(cid:28)cation-(cid:28)rst systems therefore evolve into economies of proof:
(cid:136) Proofs have cost (bandwidth, computation).
(cid:136) Proofs have value (trust they establish).
(cid:136) Proofs have lifespan (limited by scope).
As a result, entire markets form around proof creation, distribution, caching, and reputation.
Analogy: Just as early societies developed currency to allocate scarce resources, veri(cid:28)cation-(cid:28)rst
systems develop proof markets to allocate scarce correctness bandwidth. Those who can provide
e(cid:30)cient, reusable proofs gain the same economic advantage as early merchants who mastered logis-
tics.
Thus, the evolution from (cid:16)verifying(cid:17) to (cid:16)trading veri(cid:28)cation(cid:17) is not a policy choice (cid:22) it is a physical
inevitability.
18.3 The Inevitability Claim
If the following hold true:
1. Veri(cid:28)cation is bounded by physical resources.
2. Refusal preserves correctness.
3. Validity is independent of proof source.
Then the outcomes below are not speculative(cid:22)they are inevitable:
(cid:136) Proofs become commodities. Their utility, size, and freshness de(cid:28)ne their market value.
(cid:136) Veri(cid:28)cationbecomesaneconomy. Participantstradeveri(cid:28)abilitybandwidththewaytraditional
systems trade energy or compute power.
(cid:136) Coordination emerges from absence, not centralization. The network organizes itself through
refusal signals, not governance decrees.
In this world, veri(cid:28)cation-(cid:28)rst systems cease to be purely technical constructs. They evolve into
economic organisms (cid:22) networks that expand where refusal density is highest, where the demand
for veri(cid:28)able truth outstrips supply.

Analogy: Just as water (cid:29)ows downhill along gradients of scarcity, veri(cid:28)cation-(cid:28)rst networks grow
along gradients of unmet proof demand. The result is not chaos but an emergent equilibrium: a
civilization of veri(cid:28)ers balancing truth and cost through incentives alone.
19. The Purplepaper Thesis
TheZenonGreenpaperdemonstratedthatboundedveri(cid:28)cationcouldbeachieved(cid:22)thatanetwork
could separate veri(cid:28)cation from execution while remaining consistent. The Purplepaper argues
the next step: once bounded veri(cid:28)cation exists, it inevitably reshapes behavior, economics, and
coordination.
Key theses:
(cid:136) Refusal is not an edge case. It is the foundation of correctness and the beginning of economic
order.
(cid:136) Proofsarenotjustvalidationtools. Theyarethefundamentalcommoditiesofdigitaleconomies.
(cid:136) Absence is not a failure state. It is an informative signal (cid:22) a map of where trust has yet to be
earned.
When systems adopt veri(cid:28)cation-(cid:28)rst principles, they no longer assume that the network is a seam-
less (cid:16)truth (cid:28)eld.(cid:17) Instead, they begin to live within local, veri(cid:28)able realities that gradually cohere
into global order through markets and incentives.
This transformation (cid:22) from assumed truth to earned truth (cid:22) de(cid:28)nes what the Zenon model
calls a veri(cid:28)cation-(cid:28)rst civilization. It represents a shift as profound as the invention of money
or the printing press: the point at which correctness itself becomes measurable, tradeable, and
self-organizing.

Appendix X (cid:22) Provenance and Anchor Mapping to the Zenon Green-
paper
| Purpose | of This | Appendix |     |     |     |     |     |
| ------- | ------- | -------- | --- | --- | --- | --- | --- |
This appendix maps each major claim, principle, and consequence discussed in the Zenon Purplepa-
per to the speci(cid:28)c sections of the Zenon Greenpaper from which it is derived.
The Purplepaper introduces no new protocol mechanisms, no new consensus assumptions, and no
new economic primitives. All conclusions follow logically from architectural properties de(cid:28)ned in
the Greenpaper.
| This appendix | exists | to: |     |     |     |     |     |
| ------------- | ------ | --- | --- | --- | --- | --- | --- |
(cid:136)
| make              | those derivations |     | explicit, |           |     |     |     |
| ----------------- | ----------------- | --- | --------- | --------- | --- | --- | --- |
| (cid:136) prevent | misinterpretation |     |           | of scope, |     |     |     |
(cid:136)
and allow critical readers to verify that no claims exceed the Greenpaper’s commitments.
Methodology
| For each       | Purplepaper    | section, |           | we provide:     |            |          |                 |
| -------------- | -------------- | -------- | --------- | --------------- | ---------- | -------- | --------------- |
| 1. Purplepaper | Section        |          | Reference |                 |            |          |                 |
| 2. Relevant    | Greenpaper     |          | Anchor(s) | (section        |            | numbers) |                 |
| 3. Quoted      | or Paraphrased |          | Principle |                 | (as stated | in       | the Greenpaper) |
| 4. Derived     | Consequence    |          | (how      | the Purplepaper |            | extends  | it)             |
Where the Purplepaper discusses economic, coordination, or application-level behavior, these are
| framed strictly        | as                 | inevitable     | consequences, |              | not       | protocol                   | guarantees. |
| ---------------------- | ------------------ | -------------- | ------------- | ------------ | --------- | -------------------------- | ----------- |
| A.1 Bounded            | Veri(cid:28)cation |                |               | and          | Refusal   | Semantics                  |             |
| Purplepaper            | Sections           |                |               |              |           |                            |             |
| (cid:136) (cid:159)1.2 | From (cid:16)Can   | Verify(cid:17) | to            | (cid:16)Must | Live With | Veri(cid:28)cation(cid:17) |             |
(cid:136)
| (cid:159)2.1 | Veri(cid:28)cation | Bounds |     |     |     |     |     |
| ------------ | ------------------ | ------ | --- | --- | --- | --- | --- |

(cid:136)
| (cid:159)2.3           | Refusal            | Semantics  |            |     |     |
| ---------------------- | ------------------ | ---------- | ---------- | --- | --- |
| (cid:136) (cid:159)3.3 | From               | Failure    | to Refusal |     |     |
| Greenpaper             | Anchors            |            |            |     |     |
| (cid:136)              |                    |            |            | (R  |     |
| (cid:159)2.5           | Resource           | Bound      | Tuple      | V ) |     |
| (cid:136) (cid:159)2.6 | Veri(cid:28)cation | Predicates |            |     |     |
(cid:136)
| (cid:159)2.7 | Refusal   | Semantics |     |     |     |
| ------------ | --------- | --------- | --- | --- | --- |
| Greenpaper   | Principle |           |     |     |     |
Veri(cid:28)cation is constrained by explicit bounds on storage, bandwidth, and computation. If veri(cid:28)ca-
tion cannot complete within these bounds, the veri(cid:28)er must refuse rather than assume correctness.
| Derived | Consequence |     |     |     |     |
| ------- | ----------- | --- | --- | --- | --- |
(cid:136) Refusal must be treated as a (cid:28)rst-class, correctness-preserving outcome.
(cid:136)
Applications cannot rely on retries, fallback trust, or implicit availability.
(cid:136) UX, coordination, and economics must explicitly account for unveri(cid:28)able states.
| A.2 Proof   | Objects |          | as Independent |     | Artifacts |
| ----------- | ------- | -------- | -------------- | --- | --------- |
| Purplepaper |         | Sections |                |     |           |
(cid:136)
| (cid:159)2.2         | Proof     | Objects  |         |     |     |
| -------------------- | --------- | -------- | ------- | --- | --- |
| (cid:136) (cid:159)6 | Proofs as | Economic | Objects |     |     |
(cid:136)
| (cid:159)6.2 | Proof   | Markets |     |     |     |
| ------------ | ------- | ------- | --- | --- | --- |
| Greenpaper   | Anchors |         |     |     |     |
(cid:136)
| (cid:159)2.6         | Veri(cid:28)cation | Predicates   |     |         |     |
| -------------------- | ------------------ | ------------ | --- | ------- | --- |
| (cid:136) (cid:159)3 | Proof-Native       | Applications |     | (zApps) |     |
(cid:136)
| (cid:159)4 | Composable | External | Veri(cid:28)cation |     | (CEV) |
| ---------- | ---------- | -------- | ------------------ | --- | ----- |
| Greenpaper | Principle  |          |                    |     |       |
Proofs are veri(cid:28)ed deterministically based on cryptographic content, independent of their source.
| Execution        | and         | veri(cid:28)cation | are | decoupled. |                      |
| ---------------- | ----------- | ------------------ | --- | ---------- | -------------------- |
| Derived          | Consequence |                    |     |            |                      |
| (cid:136) Proofs | are         | source-agnostic,   |     | cacheable, | and redistributable. |

(cid:136)
Proof distribution becomes an economic problem, not a correctness problem.
| (cid:136) Markets |     | for proof availability |     | can         | arise | without  | protocol | changes. |
| ----------------- | --- | ---------------------- | --- | ----------- | ----- | -------- | -------- | -------- |
| A.3 Availability  |     | Is Not                 | a   | Correctness |       | Property |          |          |
| Purplepaper       |     | Sections               |     |             |       |          |          |          |
(cid:136)
| (cid:159)2.4           | Availability | Non-Guarantee    |          |       |     |     |     |     |
| ---------------------- | ------------ | ---------------- | -------- | ----- | --- | --- | --- | --- |
| (cid:136) (cid:159)7   | Absence      | as a First-Class |          | State |     |     |     |     |
| (cid:136) (cid:159)8   | Markets      | Replace          | Services |       |     |     |     |     |
| Greenpaper             |              | Anchors          |          |       |     |     |     |     |
| (cid:136) (cid:159)2.3 | Network      | Model            |          |       |     |     |     |     |
(cid:136)
| (cid:159)2.7         | Refusal  | Semantics          |       |     |     |     |     |     |
| -------------------- | -------- | ------------------ | ----- | --- | --- | --- | --- | --- |
| (cid:136) (cid:159)4 | External | Veri(cid:28)cation | (CEV) |     |     |     |     |     |
| Greenpaper           |          | Principle          |       |     |     |     |     |     |
Consensusguaranteesorderingofcommitments,notavailabilityofproofsorhistoricaldata. Missing
| data must | result      | in refusal, | not | assumption. |     |     |     |     |
| --------- | ----------- | ----------- | --- | ----------- | --- | --- | --- | --- |
| Derived   | Consequence |             |     |             |     |     |     |     |
(cid:136)
| Absence |     | is a valid and | informative |     | system | state. |     |     |
| ------- | --- | -------------- | ----------- | --- | ------ | ------ | --- | --- |
(cid:136) (cid:16)Always-on services(cid:17) are incoherent under veri(cid:28)cation-(cid:28)rst assumptions.
(cid:136)
| Coordination           |              | shifts              | from service |       | reliability | to        | artifact | availability. |
| ---------------------- | ------------ | ------------------- | ------------ | ----- | ----------- | --------- | -------- | ------------- |
| A.4 O(cid:31)ine       |              | Veri(cid:28)cation  | and          | Delay |             | Tolerance |          |               |
| Purplepaper            |              | Sections            |              |       |             |           |          |               |
| (cid:136) (cid:159)2.5 | O(cid:31)ine | Veri(cid:28)ability |              |       |             |           |          |               |
(cid:136)
| (cid:159)11             | O(cid:31)ine   | as Default |          |     |     |     |     |     |
| ----------------------- | -------------- | ---------- | -------- | --- | --- | --- | --- | --- |
| (cid:136) (cid:159)11.2 | Delay-Tolerant |            | Payments |     |     |     |     |     |
(cid:136)
| (cid:159)6.2 | Messaging | Without | Servers |     | (where | applicable) |     |     |
| ------------ | --------- | ------- | ------- | --- | ------ | ----------- | --- | --- |
| Greenpaper   |           | Anchors |         |     |        |             |     |     |

(cid:136)
| (cid:159)2.3           | Network  | Model              |     |     |     |     |     |     |
| ---------------------- | -------- | ------------------ | --- | --- | --- | --- | --- | --- |
| (cid:136) (cid:159)2.8 | Adaptive | Retention          |     |     |     |     |     |     |
| (cid:136) (cid:159)4   | External | Veri(cid:28)cation |     |     |     |     |     |     |
| Greenpaper             |          | Principle          |     |     |     |     |     |     |
Veri(cid:28)ers may operate o(cid:31)ine using cached headers and proofs. When data is unavailable or out of
| scope, refusal         |             | preserves correctness. |          |        |     |               |     |     |
| ---------------------- | ----------- | ---------------------- | -------- | ------ | --- | ------------- | --- | --- |
| Derived                | Consequence |                        |          |        |     |               |     |     |
| (cid:136) O(cid:31)ine | operation   | is                     | a normal | state, | not | an exception. |     |     |
(cid:136)
| Systems |     | must support | portable | proof | bundles |     | and deferred | anchoring. |
| ------- | --- | ------------ | -------- | ----- | ------- | --- | ------------ | ---------- |
(cid:136)
Delay-tolerant interactions (payments, messaging, identity) become feasible without trusted
infrastructure.
| A.5 Bounded            |        | Composition |     | and   | Local | Truth | Zones |     |
| ---------------------- | ------ | ----------- | --- | ----- | ----- | ----- | ----- | --- |
| Purplepaper            |        | Sections    |     |       |       |       |       |     |
| (cid:136) (cid:159)5.1 | Global | State Does  | Not | Scale |       |       |       |     |
(cid:136)
| (cid:159)9             | Local      | Truth Zones  |     |     |     |     |     |     |
| ---------------------- | ---------- | ------------ | --- | --- | --- | --- | --- | --- |
| (cid:136) (cid:159)9.2 | Composable | Micro-Truths |     |     |     |     |     |     |
| Greenpaper             |            | Anchors      |     |     |     |     |     |     |
(cid:136) (cid:159)2.4 Formal Impossibility: Unbounded Composition vs Bounded Veri(cid:28)cation
(cid:136)
| (cid:159)2.6 | Predicate | Composition |     |     |     |     |     |     |
| ------------ | --------- | ----------- | --- | --- | --- | --- | --- | --- |
| Greenpaper   |           | Principle   |     |     |     |     |     |     |
Unbounded compositional veri(cid:28)cation cannot be achieved within (cid:28)xed resource bounds. Refusal
| propagates       | through     | composed |                 | predicates. |                    |     |             |          |
| ---------------- | ----------- | -------- | --------------- | ----------- | ------------------ | --- | ----------- | -------- |
| Derived          | Consequence |          |                 |             |                    |     |             |          |
| (cid:136) Global | mutable     | state    | is structurally |             | unveri(cid:28)able |     | for bounded | clients. |
(cid:136)
| Truth | becomes | local | and | scoped | to each | veri(cid:28)er’s | R . |     |
| ----- | ------- | ----- | --- | ------ | ------- | ---------------- | --- | --- |
V
| (cid:136) Applications |     | must fragment |     | into | locally | veri(cid:28)able | components. |     |
| ---------------------- | --- | ------------- | --- | ---- | ------- | ---------------- | ----------- | --- |

| A.6 Economic                            |          | Scarcity | of       | Veri(cid:28)cation |     |     |
| --------------------------------------- | -------- | -------- | -------- | ------------------ | --- | --- |
| Purplepaper                             | Sections |          |          |                    |     |     |
| (cid:136) (cid:159)4 Veri(cid:28)cation |          | as an    | Economic | Primitive          |     |     |
(cid:136)
| (cid:159)5 Scarcity         |           | Without | Supply | Caps |     |     |
| --------------------------- | --------- | ------- | ------ | ---- | --- | --- |
| (cid:136) (cid:159)15 Relay | Economics |         |        |      |     |     |
(cid:136)
| (cid:159)16 Autonomic |         | Expansion |     |     |     |     |
| --------------------- | ------- | --------- | --- | --- | --- | --- |
| Greenpaper            | Anchors |           |     |     |     |     |
(cid:136)
| (cid:159)2.5 Resource |     | Bound | Tuple |     |     |     |
| --------------------- | --- | ----- | ----- | --- | --- | --- |
(cid:136)
| (cid:159)2.7 Refusal |           | Semantics |     |     |     |     |
| -------------------- | --------- | --------- | --- | --- | --- | --- |
| Greenpaper           | Principle |           |     |     |     |     |
Veri(cid:28)cation consumes (cid:28)nite physical resources and cannot be assumed free or universal.
| Derived | Consequence |     |     |     |     |     |
| ------- | ----------- | --- | --- | --- | --- | --- |
(cid:136)
| Veri(cid:28)cation |     | capacity | becomes | scarce. |     |     |
| ------------------ | --- | -------- | ------- | ------- | --- | --- |
(cid:136) Scarcity generates pricing signals around proof size, latency, and scope.
(cid:136)
| Relay                          | networks     | and              | caching   | incentives |           | emerge organically. |
| ------------------------------ | ------------ | ---------------- | --------- | ---------- | --------- | ------------------- |
| A.7 Self-Driving               |              | P2P              | Expansion |            | Loop      |                     |
| Purplepaper                    | Sections     |                  |           |            |           |                     |
| (cid:136) Part                 | VII (cid:22) | The Self-Driving |           | P2P        | Expansion | Loop                |
| Greenpaper                     | Anchors      |                  |           |            |           |                     |
| (cid:136) (cid:159)2.7 Refusal |              | Semantics        |           |            |           |                     |
(cid:136)
| (cid:159)2.8 Adaptive         |           | Retention          |     |     |     |     |
| ----------------------------- | --------- | ------------------ | --- | --- | --- | --- |
| (cid:136) (cid:159)4 External |           | Veri(cid:28)cation |     |     |     |     |
| Greenpaper                    | Principle |                    |     |     |     |     |
Refusal is deterministic, reproducible, and safe. Veri(cid:28)cation demand is observable through refusal
outcomes.
| Derived | Consequence |     |     |     |     |     |
| ------- | ----------- | --- | --- | --- | --- | --- |
(cid:136)
| Refusal | density | reveals | unmet | veri(cid:28)cation |     | demand. |
| ------- | ------- | ------- | ----- | ------------------ | --- | ------- |

(cid:136)
| Nodes | responding | to that | demand | gain economic | advantage. |
| ----- | ---------- | ------- | ------ | ------------- | ---------- |
(cid:136) Network capacity expands autonomically without governance or coordination.
| A.8 No New    | Protocol      |     | Claims |     |     |
| ------------- | ------------- | --- | ------ | --- | --- |
| This appendix | a(cid:30)rms: |     |        |     |     |
(cid:136)
| The Purplepaper |                | does         | not propose: |     |     |
| --------------- | -------------- | ------------ | ------------ | --- | --- |
| (cid:21) new    | consensus      | mechanisms,  |              |     |     |
| (cid:21) new    | token          | economics,   |              |     |     |
| (cid:21) new    | protocol-level |              | incentives,  |     |     |
| (cid:21) or     | new trust      | assumptions. |              |     |     |
(cid:136)
| All behavior          | described           |             | arises from: |     |     |
| --------------------- | ------------------- | ----------- | ------------ | --- | --- |
| (cid:21) bounded      | veri(cid:28)cation, |             |              |     |     |
| (cid:21) refusal      | semantics,          |             |              |     |     |
| (cid:21) proof-native |                     | execution,  |              |     |     |
| (cid:21) and          | source-agnostic     |             | validity,    |     |     |
| as de(cid:28)ned      | in the              | Greenpaper. |              |     |     |
| Closing Note          | to                  | the Reader  |              |     |     |
The Purplepaper is not an extension of the protocol. It is an explanation of what must happen
| once the Greenpaper’s |     | axioms | are accepted. |     |     |
| --------------------- | --- | ------ | ------------- | --- | --- |
If any conclusion in this document is disputed, the appropriate critique is not (cid:16)this is speculative,(cid:17)
but:
| (cid:16)Which Greenpaper |                  | assumption | is false?(cid:17) |                                |     |
| ------------------------ | ---------------- | ---------- | ----------------- | ------------------------------ | --- |
| That question            | is intentionally |            | left open         | (cid:22) and veri(cid:28)able. |     |
