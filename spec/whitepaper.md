<!-- QUALITY: The PDF cover page renders as a malformed table in this output (lines 1-5). Some body pages have lost inter-word spacing (e.g., "Thispaperintroducesanew"). For the canonical layout and equations, refer to the original PDF (2_ZENON_WHITEPAPER_(CORE_TEAM).pdf) in upstream zenon-developer-commons. -->
| Network |     |     | of Momentum |        |       |              | -          | leaderless |     |     | BFT |     | dual |
| ------- | --- | --- | ----------- | ------ | ----- | ------------ | ---------- | ---------- | --- | --- | --- | --- | ---- |
|         |     |     |             | ledger |       | architecture |            |            |     |     |     |     |      |
|         |     |     |             |        | DRAFT | v0.1,        | 31 March   | 2020       |     |     |     |     |      |
|         |     |     |             |        |       | The          | Zenon Team |            |     |     |     |     |      |
portal@zenon.network
Abstract—Thispaperintroducesanew,fastandscalable a rich landscape of thousands of cryptocurrencies. Con-
decentralized ledger system called Network of Momentum sequently, several consensus algorithms and new ledger
that achieves high throughput transactions and enables a data structures have emerged for decentralized systems,
| new form     | of distributed  |       | applications. |          | The paper      | begins   |            |           |                     |               |              |           |             |
| ------------ | --------------- | ----- | ------------- | -------- | -------------- | -------- | ---------- | --------- | ------------------- | ------------- | ------------ | --------- | ----------- |
|              |                 |       |               |          |                |          | each of    | which     | retains interesting |               | capabilities |           | and unique  |
| with a short | history         | about | distributed   |          | systems        | together |            |           |                     |               |              |           |             |
|              |                 |       |               |          |                |          | properties | as        | we will             | explore       | in the       | following | sections.   |
| with the     | core components |       | of the        | existing | architectures, |          |            |           |                     |               |              |           |             |
|              |                 |       |               |          |                |          | This paper | presenTts | a                   | decentralized |              | ledger    | system that |
alongsidewiththeirchallenges-theconsensusmechanism,
the underlying transactional data structure, the smart features a leaderless, fully-local and scalable consensus
contracts layer, then it presents the proposed architecture algorithm based on virtual voting coupled with proof of
| that is leaderless |        | in its      | nature | and is       | based    | on a dual  |          |            |           |            |                  |            |               |
| ------------------ | ------ | ----------- | ------ | ------------ | -------- | ---------- | -------- | ---------- | --------- | ---------- | ---------------- | ---------- | ------------- |
|                    |        |             |        |              |          |            | work     | and proof  | of stake  | anti-sybil | [6]              | mechanisms | that          |
| ledger system      | called | Network     | of     | Momentum     |          | that       | uses     |            |           |            |                  |            |               |
|                    |        |             |        |              |          |            | reacheFs | eventual   | consensus |            | with probability |            | one. The      |
| virtual voting     | for    | consensus.  | It     | also         | provides | a brief    |          |            |           |            |                  |            |               |
|                    |        |             |        |              |          |            | concept  | of virtual | voting    | was        | known            | long       | before in the |
| introduction       | into   | a framework |        | that employs |          | unikernels |          |            |           |            |                  |            |               |
to run distributed applications, but because it is beyond literature,startingwiththepioneeringpaper”Byzantine-
the scope of the paper, a more comprehensive study will Resistant Total Ordering Algorithms” [5] by Moser and
followasayellowpaper.Subsequently,thepaperdescriAbes
|                |                |           |          |          |            |         | Melliar-Smith |         | where          | they formulated |              | four  | algorithms  |
| -------------- | -------------- | --------- | -------- | -------- | ---------- | ------- | ------------- | ------- | -------------- | --------------- | ------------ | ----- | ----------- |
| some classical | attack         | scenarios | and      | how      | to surpass | them,   |               |         |                |                 |              |       |             |
|                |                |           |          |          |            |         | to establish  | a       | total ordering |                 | from network |       | events. The |
| analyzes       | the complexity |           | and key  | protocol | parameters |         |               |         |                |                 |              |       |             |
|                |                |           |          |          |            |         | peculiar      | concept | of virtual     | voting          | that         | later | reappeared  |
| and draws      | conclusions    |           | together | with     | discussing | related |               |         |                |                 |              |       |             |
potential research directions. in other papers such as Hashgraph [8], PARSEC [9] or
|           |                   |     |           |     | RBlockmania |            |     |     | [51], was | the ability | to  | execute | a virtual |
| --------- | ----------------- | --- | --------- | --- | ----------- | ---------- | --- | --- | --------- | ----------- | --- | ------- | --------- |
| Keywords: | decentralization, |     | byzantine |     | fault       | tolerance, |     |     |           |             |     |         |           |
agreementprotocol,asauthorsMoserandMelliar-Smith
| permissionless | consensus, |     | P2P network, |     | protocol | design |          |          |            |           |               |               |               |
| -------------- | ---------- | --- | ------------ | --- | -------- | ------ | -------- | -------- | ---------- | --------- | ------------- | ------------- | ------------- |
|                |            |     |              |     |          |        | cleverly | observed | long       | before    | and exploited |               | the fact that |
|                |            |     |              |     |          |        | votes    | weren’t  | explicitly | contained | in            | the messages, | but           |
I. INTRODUCTION
|     |     |     |     |     |     |     | were | deducted | from | the causal | relationships |     | between |
| --- | --- | --- | --- | --- | --- | --- | ---- | -------- | ---- | ---------- | ------------- | --- | ------- |
D
Interest in decentralized systems was reignited by them. The contributions of this paper are outlined as
| the rise  | of Bitcoin | [1]   | born in | the midst    | of  | the 2008 |          |            |                    |     |                  |      |               |
| --------- | ---------- | ----- | ------- | ------------ | --- | -------- | -------- | ---------- | ------------------ | --- | ---------------- | ---- | ------------- |
|           |            |       |         |              |     |          | follows: | the        | protocol comprises |     | of a             | dual | ledger archi- |
| financial | crisis and | paved | the way | to countless |     | research |          |            |                    |     |                  |      |               |
|           |            |       |         |              |     |          | tecture, | a meta-DAG | created            |     | by participating |      | consensus     |
initiatives and innovative technologies in the space of nodes, a projection of the meta-DAG that represents
| computer | science | and | beyond, | with focus | in  | areas | of                |     |         |                 |     |     |              |
| -------- | ------- | --- | ------- | ---------- | --- | ----- | ----------------- | --- | ------- | --------------- | --- | --- | ------------ |
|          |         |     |         |            |     |       | the transactional |     | ledger, | a proof-of-work |     |     | link between |
cryptography, distributed systems and game theory. A relayed transactions emitted by clients, together with
new concept, the blockchain, was popularized by emer- the following properties and functions: a vote-weighting
| gent cryptocurrencies |     |     | that exploited | the | nature | of  | de-      |       |          |          |     |               |      |
| --------------------- | --- | --- | -------------- | --- | ------ | --- | -------- | ----- | -------- | -------- | --- | ------------- | ---- |
|                       |     |     |                |     |        |     | function | based | on proof | of stake | for | participating | con- |
centralization to create complex economic systems that sensus nodes, an incentivization scheme based of proof
| culminated | with | the implementation |     | of  | the first | general- |          |              |        |     |                |     |           |
| ---------- | ---- | ------------------ | --- | --- | --------- | -------- | -------- | ------------ | ------ | --- | -------------- | --- | --------- |
|            |      |                    |     |     |           |          | of work, | a difficulty | oracle | and | a super-quorum |     | selector. |
purpose bytecode execution platform, Ethereum [2], and The remainder of the paper is organized as follows: in
enabled trusted computation among a group of mutually SectionIIwewilldiscussbasicnotionsabouttheBitcoin
distrustfulparticipantsandfurthermaterializedinamyr-
|     |     |     |     |     |     |     | protocol | and | smart contracts |     | and in | Section | III we will |
| --- | --- | --- | --- | --- | --- | --- | -------- | --- | --------------- | --- | ------ | ------- | ----------- |
iad of decentralized applications ranging from creating providesomeinsightsaboutvariousstate-of-theartcom-
| self-sovereign | identities, |     | peer-to-peer |     | energy | markets, |         |      |           |                 |     |        |         |
| -------------- | ----------- | --- | ------------ | --- | ------ | -------- | ------- | ---- | --------- | --------------- | --- | ------ | ------- |
|                |             |     |              |     |        |          | ponents | that | comprises | a decentralized |     | ledger | system. |
prediction markets, improving supply chain logistics to We build our system on a dual directed acyclic graph
complex financial instruments. A wave of innovation based architecture called Network of Momentum that
| was fueled | by  | their success | in  | the market | and | shaped |     |     |     |     |     |     |     |
| ---------- | --- | ------------- | --- | ---------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |

employsaconsensusalgorithmthatusesavirtualvoting Distributed ledgers can be further categorized, de-
technique in association with proof of work (PoW) [3] pending on the nature of the environment i.e. public
and proof of stake (PoS) [4] that we present in Section or private, into permissioned or permissionless: this
V. We then show in Section VI how the network can determines the participation eligibility of nodes or users
withstand different attacks and threat models. In section that can join the system.
VII we analyze the protocol parameters together with Inapermissionlessdistributedledger,suchasBitcoin,
the complexity and outline the cryptoeconomic system. anyonecanbecomeanodeandparticipateintheconsen-
InSectionVIIIweconcludewithasummaryanddiscuss susprocessfordeterminingtheledgerstateorcommitto
future research directions. thesharedstatebyinvokingtransactions.Apermissioned
distributedledgere.g.blockchainconsortium,incontrast
II. BACKGROUND
is operated by a set of entities that can identify and
In this section, we present the core concepts of dis- decide what nodes can join and update the shared state
tributed ledgers. We then explore a simplified specifica- and even can control the transaction issuance. We will
tion of the Bitcoin protocol and present a short review refer to permissionless distributed ledgers as decentral-
about smart contracts. ized ledgers to emphasize this distinction.
A. From distributed to decentralized ledgers B. Bitcoin T
A distributed ledger is a consensus of replicated The history of cryptocurrencies started in 2009 when
and synchronized digital data structure shared between an anonymous figure known by the pseudonym of
multiple nodes in a peer to peer network. Each node ”Satoshi Nakamoto” released the first Bitcoin client and
replicates and saves an identical copy of the ledger, minedFthe first block of the Bitcoin timechain, thus
updating it independently from the rest of the network. successfully managing to solve the decades old problem
The updating process is based on a consensus algorithm ofdouble-spendinginapermissionlessenvironment.The
where nodes vote which copy is correct; once the con- release of the first Bitcoin client marked the inception
A
sensushasbeenreached,alltheothernodesupdatetheir ofacompletelydecentralizedelectroniccashsystemthat
ledger accordingly. An important aspect of a distributed facilitates pseudonymous payments without any trusted
ledger system is that there is no central authority to third parties.
enforce rules and therefore no single point of failure, The problem of double-spending in a decentralized
so the integrity and security are accomRplished by using network was solved by Satoshi using a ”distributed
a consensus algorithm and cryptographic mechanisms. timestamp server” that consists of a proof of work
A consensus algorithm is at the core of a distributed mechanism and an incentivization scheme using an un-
ledger system - it ensures that the nodes agree on a structuredpeertopeernetworkwithanunknownnumber
uniqueorderinwhichentriesareappended.Anessential of participants susceptible of sybil identities together
D
aspect of a consensus algorithm is fault tolerance - the with a method of determining the ”legitimate” ledger
property that enables a system to continue operating by each participant independently.
normallyinthepresenceofoneormorefaults.Therefore Theconsensusprotocoliscommonlyknown,although
the consensus algorithm must be resistant to different informal, as Proof of Work, and is often encountered
typesoffaults,thatcanbeeitherunreliableormalicious in literature as the ”Nakamoto protocol” family, imple-
nodes attempting to hijack the system. mented in a wide array of cryptocurrency networks; it
There are two main categories of failures a node may virtually uses the longest chain of most accumulated
be subjected to: crash failures and Byzantine failures. proof of work selection rule to probabilistically de-
Crash failures occur when nodes suddenly stop and do termine the valid timechain. A de facto formalization
not resume operation. Byzantine failures are arbitrary of the Bitcoin protocol isn’t broadly accepted by the
faults presenting different symptoms to different ob- academic community given the difficulty in providing
servers - in a decentralized environment they may occur a good generalized definition - that ultimately depends
as a result of malicious activity. on the tight interaction between the various parts that
The problem of designing a system that can cope make up Bitcoin.
with byzantine faults was formulated and presented as A Bitcoin account consists of a public and private
the Byzantine Generals Problem [7], hence a consensus key pair; an address is the hash of the public key and
protocoltoleratingbyzantinefailuresmustberesilientto is used to receive coins, while the private key of the
any possible error that can appear. account is used to authorize the transfer of coins. A
2

transaction consists of three data fields - inputs, outputs of the blockchain network and the execution of instruc-
and metadata; the metadata holds generic information - tions is deterministic and verifiable by all participating
| thehashandsizeofthetransaction,thenumberofinputs |     |     |     |     |     |     | nodes. |     |     |     |     |     |     |
| ------------------------------------------------ | --- | --- | --- | --- | --- | --- | ------ | --- | --- | --- | --- | --- | --- |
and outputs and a lock time field. The transaction fee A desired property of smart contracts is their im-
represents the difference between the total value of the mutability: once a smart contract is deployed it cannot
inputsandthetotalvalueoftheoutputs.Ifthevalidation be modified by third parties. This can be a double
procedure passes, the transaction is broadcasted to the edge sword, amplifying both the strength of censorship
network; a correct node only broadcasts it once, in case resistance and the weakness of poorly written code.
it receives the same transaction multiple times. Finally, Fortunately, there are techniques to overcome bugs by
the transaction is included into the mempool and awaits upgrading the vulnerable smart contracts code with the
confirmationsi.e.becomeembeddedintotheblockchain. use of proxy contracts or by using a formal verification
|            |     |             |        |           |           |     | framework | [22]. |     |     |     |     |     |
| ---------- | --- | ----------- | ------ | --------- | --------- | --- | --------- | ----- | --- | --- | --- | --- | --- |
| Every node | can | participate | in the | consensus | protocol, |     | a         |       |     |     |     |     |     |
processknownasmining,bycomputingacryptographic Overall, smart contracts dramatically increase the
proof-of-work puzzle; if the node finds a solution, the specter of use-cases for DLTs, from allowing basic
newly created block containing transactions from the conditional payments to more complex business logic.
mempoolispropagatedthroughthepeertopeernetwork We will provide a deeper analysis of this topic and
and if valid, it is appended to the blockchain. We will describe our propTosed solution in Section V.
| discuss | different | Proof-of-X | algorithms | in  | Section | III. |     |     |     |     |     |     |     |
| ------- | --------- | ---------- | ---------- | --- | ------- | ---- | --- | --- | --- | --- | --- | --- | --- |
III. STATEOFTHEART
| Although | Bitcoin  | taken | as       | a whole          | is fulfilling | its    |           |       |     |     |     |     |     |
| -------- | -------- | ----- | -------- | ---------------- | ------------- | ------ | --------- | ----- | --- | --- | --- | --- | --- |
|          |          |       |          |                  |               |        | A. Ledger | types |     |     |     |     |     |
| purpose  | for more | than  | a decade | under real-world |               | condi- |           |       |     |     |     |     |     |
tions, there have been studies of individual components EvenFthough the terms distributed ledger and
|     |     |     |     |     |     |     | blockchain | are | often | used inter-changeably |     |     | in the |
| --- | --- | --- | --- | --- | --- | --- | ---------- | --- | ----- | --------------------- | --- | --- | ------ |
ofBitcointhatpointoutlimitsoreventheoreticaldesign
flaws of the protocol; for example, according to Eyal literature, there is a subtle distinction between them
and Sirer et al. Bitcoin is incentive incompatible due to which is worth headlining: a blockchain is just subset
A
|                |             |     |          |                   |     |      | of the       | larger superset |                 | of distributed | ledgers.  |     | One of |
| -------------- | ----------- | --- | -------- | ----------------- | --- | ---- | ------------ | --------------- | --------------- | -------------- | --------- | --- | ------ |
| selfish mining | [20].       |     |          |                   |     |      |              |                 |                 |                |           |     |        |
|                |             |     |          |                   |     |      | the most     | important       | aspects         | when           | designing |     | a new  |
|                |             |     |          |                   |     |      | architecture | is              | the distributed | ledger         | component |     | that   |
| C. Smart       | contracts   |     |          |                   |     |      |              |                 |                 |                |           |     |        |
|                |             |     |          |                   |     |      | describes    | how             | transactions    | are embedded.  |           |     |        |
| Another        | interesting |     | topic is | the progRrammable |     | com- |              |                 |                 |                |           |     |        |
ponent of a cryptocurrency, smart contracts and decen- Definition 1 A decentralized ledger is defined as a
| tralized | applications. | The | basic | idea is that | one | can run |             |      |           |              |      |     |         |
| -------- | ------------- | --- | ----- | ------------ | --- | ------- | ----------- | ---- | --------- | ------------ | ---- | --- | ------- |
|          |               |     |       |              |     |         | distributed | data | structure | with entries | that | are | digital |
arbitrary quasi-Turing complete code in a decentralized records of actions, in a permissionless environment.
| setting, | from simple  | smart | contracts       | for | automated | pay- |                |     |     |             |     |               |     |
| -------- | ------------ | ----- | --------------- | --- | --------- | ---- | -------------- | --- | --- | ----------- | --- | ------------- | --- |
| ments to | more complex |       | applications. D |     |           |      |                |     |     |             |     |               |     |
|          |              |       |                 |     |           |      | 1) Blockchain: |     | The | most common |     | decentralized |     |
EarlyblockchainnetworkssuchasBitcoinhaveasim- ledger is the blockchain. One definition for the
| ple, Turing-incomplete |     |     | stack-based | scripting | language |     |            |      |              |                |     |        |        |
| ---------------------- | --- | --- | ----------- | --------- | -------- | --- | ---------- | ---- | ------------ | -------------- | --- | ------ | ------ |
|                        |     |     |             |           |          |     | blockchain | is a | distributed, | decentralized, |     | public | ledger |
used as a locking mechanism for transaction outputs: in the form of a cryptographically secured linked list of
”The script is actually a predicate. It’s just an equation blocks holding transactions, without a central authority
that evaluates to true or false. Predicate is a long and or coordinator, managed by multiple entities partici-
unfamiliar word so I called it script.” [36]. pating in a peer to peer network, usually in a trust
| The smart | contract | concept |     | was pioneered | by  | Szabo |           |          |     |     |     |     |     |
| --------- | -------- | ------- | --- | ------------- | --- | ----- | --------- | -------- | --- | --- | --- | --- | --- |
|           |          |         |     |               |     |       | minimized | context. |     |     |     |     |     |
in [21]. With the expansion of the Internet it became The digitally signed transactions are hashed and en-
clear that cryptographic enforcement of agreements can codedintoacryptographicallytamper-evidentdatastruc-
becomeacornerstoneforhumancooperationinadigital ture known as a Merkle tree, forming a ”block”. Each
world. Ethereum was the first project to successfully block contains a cryptographic hash of the prior block,
implementthesmartcontractparadigm.Asmartcontract creating a linear list of blocks linked by tamper-evident
is a piece of code typically written in a higher level hash pointers, thus enabling a tamper-resistant way to
language, for example Solidity, and compiled down to confirmtheintegrityofpreviousblocks,allthewayback
| bytecodeinterpretedbyaspecializedvirtualmachine.In |     |     |     |     |     |     | to the genesis | block. |     |     |     |     |     |
| -------------------------------------------------- | --- | --- | --- | --- | --- | --- | -------------- | ------ | --- | --- | --- | --- | --- |
Ethereum’s case, the resulting bytecode is ran inside the Additional integrity measures are used to combat
Ethereum Virtual Machine that is present in every node potentially malicious, byzantine adversaries, such as the
3

requirement that a block hash is smaller than a given which is similar to IOTA, and Avalanche [10], which
target e.g. in Nakamoto protocol family, or a multi- has a more complex model. Another interesting DAG
signature or threshold signature over a block, by the ledgerapproachisrepresentedbyHashgraph,developed
nodes participating in the blockchain network. by the company Swirlds and used as the backbone of
For example, in order for a block to be added to the the Hedera cryptocurrency. The hashgraph is a special
Bitcoin ledger, the nodes have to participate in a lottery type of DAG where each record is a message that can
where their chances are proportional with the amount accommodate several transactions. Furthermore block-
of computational work invested to find a solution for less, nonlinear data structures are also adopted in many
a cryptographic hash puzzle that allows them to link it recent architecture designs for their potential to enhance
with the previous block. transaction throughput.
Once a valid block is appended by the miner, all 3) Holochain: Another decentralized ledger is the
the transactions from that block become finalized and
Holochain [26], a concept implemented in the Holo
immutable, however due to the independent Poisson
cryptocurrency presented as a scalable agent-centric
processes in the block proposal race, more than one
distributed computing platform. Holochain applies the
miner may propose to extend the blockchain using
”trustless” principle of decentralized ledgers by making
different blocks with corresponding valid proof of work
context specific ledgers where trust exists contextually
solutionsatroughlythesametime,leadingtoafork;this T
and locally, being interoperable with other ledgers that
results in one of the competing blocks to land on a fork
are similarly trustful. It is a combination of multiple
and subsequently be discarded given the longest chain
concepts: distributed hash tables, git and bittorent. In
selection rule employed by the Nakamoto protocol.
Holochain, each node runs its ”local source chain”, an
Forthisreason,in[19],Garayetal.presentsaframe- F
append-only log and operate autonomously.
work to capture the properties of liveness, validity and
Rather than storing a copy of the full ledger on every
agreement of the Nakamoto consensus protocol by three
nodeofthenetworkandenforcingauniversalconsensus
chain based properties: common-prefix, chain growth
Aprotocol, Holochain takes an agent-centric approach and
and chain quality. With these in mind, the proof of
divides the data to many different nodes and establishes
work based Nakamoto protocol can be modeled as a
access only to the data that is useful for a particular
probabilistic Byzantine agreement protocol.
node.Nodesvalidateeachotherbasedonjointlyrelevant
However, what we described earlier - the proof of
information and on context specific rules.
work Nakamoto consensus of Bitcoin,Ris not the only
4) Block-lattice: The last ledger data structure
consensus algorithm for blockchains. There are now
we analyze is the block-lattice. First used by Nano
many other consensus algorithms that can power a
cryptocurrency [27], it is designed for throughput
blockchain network. We will describe them in the fol-
and scalability: every user has its own autonomous
lowing section.
Daccount-chain, that can be updated independently from
Eveniftheblockchainparadigmhasmanyadvantages
the rest. The blocks from different account-chains
such as robustness and the fact that is well studied and
acknowledge each other and collectively form a
more understandable, it ultimately sacrifices scalability
mesh-like structure. Because the account-chains can
due to the limited number of transactions that fit in any
grow concurrently, the throughput can be quickly
given block.
scaled up. The blocklattice has many advantages -
2) Directed Acyclic Graph: Nonetheless, in order to
scalability, simplicity, and it can be secure provided
boostscalabilityandincreasetransactionprocessing,the
itisimplementedwithanadequateconsensusalgorithm.
linear data structure has been expanded into nonlinear
formssuchasblockgraphsandtrees[17],[18].ADAG,
as the name implies, is a finite directed graph with no Our architecture is based on a dual ledger approach:
directed cycles. For example, IOTA [23] proposed a a generic DAG, called the meta-DAG used for the
custom DAG called Tangle. The Tangle has a genesis consensus layer and a block-lattice data structure used
block, then all the transactions are linked to each other to store the transactional data.
forming a DAG. The Tangle is basically a DAG where We have separated the ledger architecture in order to
each new transaction is linked to two previous trans- achieve a better complexity and faster processing times
actions, an architecture that in theory would allow the when a user wants to query nodes for transactional
structure to be highly scalable. Other cryptocurrencies data. An overview presenting the advantages and
that implemented DAG structures are Byteball [25], disadvantages for different types of ledgers can be seen
4

in Table 1. the throughput of a system is directly affected by
scalability.
B. Consensus types • Fault tolerance threshold: Indicates an upper
bound of faulty nodes that directly impacts the
The key component of a distributed system that
performanceoftheconsensusalgorithm.Forexam-
enables all participants to agree on a state without a
ple, some consensus algorithms have an optimistic
central authority is the consensus algorithm.
regime that favors performance.
• Latency: Also known as finality in this context,
Definition 2 Consensus is the process of committing
it represents the time it takes for a transaction to
entries to the decentralized ledger that complies with
become settled in the ledger.
a set of well-defined rules that are enforced by all
We will review some of the most important
honest network participants after an entry containing
consensus protocol families that are at the core of
transactions is accepted.
countless decentralized systems.
Differentconsensusalgorithmshavedistinctivedesign
1) Proof-of-Work: Proof of work was initially de-
choices that have a considerable impact on the system’s
signed as a spam mitigation solution [14] and involves
performance, including its transaction throughput, scal- T
the asymmetry in terms of resource usage between two
ability and fault tolerance.
separate entities, the prover and the verifier. The prover
Therefore consensus algorithms have trade-offs be-
performs a resource-intensive task in order to obtain a
tween the level of security and performance. We will
result and presents it to the verifier for validation - the
listsecurityandperformancepropertiesthatareessential asymmFetrycomesfromthefactthatthevalidationofthe
for a permissionless consensus algorithm designed for a
proof requires only a fraction of the resources invested
decentralized ledger system.
into its generation.
• Adversary resistance: Indicates the threshold of The core concept of the Proof of Work consensus
byzantine nodes that can be tolerated by the cAon-
algorithmisthecompetitionofnodesinfindingsolutions
sensus algorithm.
for a cryptographic hash puzzle that satisfies a difficulty
• Sybil resistance: Specifies if the consensus al- requirement based on the measurement of the total hash
gorithm implements an anti-sybil mechanism. For
power in order to maintain a specified rate of puzzle
example, the consensus algorithmRshould have a
solutions per time interval; once a solution is found,
mechanism to prevent the generation of sybil iden-
nodes create and cryptographically link the block with
tities in a permissionless environment.
the tip of the blockchain and advertize it over the peer
• Accountability & non-repudiation: Indicates if to peer network.
the consensus protocol implements an identity sys-
For a cryptographically secure hash function H(·) like
D
tem and cryptographic signatures.
SHA-256 in the case of Bitcoin, and a given difficulty
• Denial of Service resistance: Specifies if the level D(h), each single query to H(·) is an independent
consensus algorithm implements a denial of ser-
and identically distributed Bernoulli trial with a success
vice defense mechanism. For instance, some leader
probability described by the following equation:
based consensus algorithms are susceptible to DoS
attacks. Pr(y :H(x(cid:107)y)≤D(h))=2−h
• Censorship resistance: Indicates if the consensus Different implementations of PoW algorithms require
algorithm is censorship resistant. For example, it different rates at which solutions are found in a given
precludes external entities from trying to censor time interval: in the case of Bitcoin this rate is one
transactions. solution for every 600 seconds, and for Ethereum every
From the perspective of quantifying the performance of 15 seconds. The corresponding time period is directly
a consensus algorithm, we will highlight the following correlated with the underlying data structure: for in-
performance indicators: stance, Ethereum implements GHOST [30] to optimally
• Throughput: Represents the number of TPS (i.e. determine the path that has the most computation work
transactions per second) a consensus algorithm can done upon to accommodate the short block times.
process. CryptocurrenciesthathaveaPoWbasedconsensusal-
• Scalability: Represents the ability for a system to gorithmemploydifferentclassesofPoW,(e.g.compute-
expand without degrading performance. Generally, boundPoW,memory-boundPoW,chainedPoWorother
5

|     |            |     |     |     | TABLE                        | I: Ledger types |     |     |                    |     |     |     |
| --- | ---------- | --- | --- | --- | ---------------------------- | --------------- | --- | --- | ------------------ | --- | --- | --- |
|     | Ledgertype |     |     |     | Advantages                   |                 |     |     | Disadvantages      |     |     |     |
|     | Blockchain |     |     |     | Wide-scaleadoptioninindustry |                 |     |     | Limitedscalability |     |     |     |
Robustandwellstudied
|     |     | DAG |     | Canscalebetterthanablockchain |     |     |     | Increasedattacksurface |     |     |     |     |
| --- | --- | --- | --- | ----------------------------- | --- | --- | --- | ---------------------- | --- | --- | --- | --- |
Block-lattice,Holochain Accountindependence Decentralizationtrade-offs
Asynchronoustransactionalmodel
HashGraph Theconsensusisderivedlocallyfromthegraph Potentialdelaysforreachingconsensus
Graphbloat
customimplementations)toobtainsomedesiredproper- static set of delegators, while others utilize a dynamic
ties like ASIC-resistance, such as to avoid some forms sizeofthesetofdelegators;asforthedPoSterminology,
of miner centralization. inablockchainnetworktheyarecalledblockproducers.
In a decentralized model, PoW consensus assumes For instance EOS [41] and Lisk [44] employ a fixed
that a majority of hashing power is controlled by honest number of 21 and 101 delegators respectively, while
parties. Tezos [42] takes a different approach with a technique
2) Proof-of-Stake: Proof of Stake was proposed as that allows anyone to amount delegated coins such that
T
|           |          |          |     |           |              | it meets | the threshold |     | to become | a   | baker, | in exchange |
| --------- | -------- | -------- | --- | --------- | ------------ | -------- | ------------- | --- | --------- | --- | ------ | ----------- |
| candidate | to solve | a number | of  | potential | shortcomings |          |               |     |           |     |        |             |
returningforthisserviceacertainproportionoftheblock
oftheproofofworkconsensussuchasenergyconsump-
tion, miner centralization and certain types of economic rewards back to the delegating party.
| attacks. |     |     |     |     |     | 4) Proof-of-X: |     | Proof-of-X |     | consensus | algorithms | are |
| -------- | --- | --- | --- | --- | --- | -------------- | --- | ---------- | --- | --------- | ---------- | --- |
F
One of the first cryptocurrencies to implement PoS extending the concept beyond work and stake to non-
|                                                  |     |           |          |            |         | interactively | prove | a   | commitment | of  | computational | re- |
| ------------------------------------------------ | --- | --------- | -------- | ---------- | ------- | ------------- | ----- | --- | ---------- | --- | ------------- | --- |
| as a consensus                                   |     | algorithm | in their | blockchain | network |               |       |     |            |     |               |     |
| wasPeercoin[47],releasedin2012;thesuccesssparked |     |           |          |            |         | sources.      |       |     |            |     |               |     |
a wave of innovation, culminating with the OuroboAros A PoX scheme should be resistant to puzzle grinding
protocol, a provably secure PoS algorithm [31] that is at (i.e. the puzzle must meet several criteria to satisfy
the core of the Cardano cryptocurrency [24]. completeness, soundness, non-invertibility, and fresh-
The core notion of the PoS consensus algorithm is ness), including aggregation or outsourcing [34] of the
the block creation process that requires a proof that computational resources and manipulation of the leader
R
|                   |     |           |     |         |                  | election | process. | This | leads | to hybridizations |     | such as |
| ----------------- | --- | --------- | --- | ------- | ---------------- | -------- | -------- | ---- | ----- | ----------------- | --- | ------- |
| the participating |     | node owns | a   | certain | number of coins. |          |          |      |       |                   |     |         |
Naive implementations of PoS may lead to unexpected Proof of Activity, a combination of PoW and PoS used
problems that naturally don’t occur in PoW based in Decred [39] or Proof of Importance, used in NEM
cryptocurrencies: the ”nothing at stake” problem [49], [40] that is based on PoS and an ”importance score”
short or long range attackDs, coin-age accumulation, pre- calculated from the net coin transfers from an account.
| computing | attacks, | stake-grinding |     | or  | cartel formation |               |     |         |      |             |     |             |
| --------- | -------- | -------------- | --- | --- | ---------------- | ------------- | --- | ------- | ---- | ----------- | --- | ----------- |
|           |          |                |     |     |                  | For instance, |     | PoX can | also | be designed | to  | incentivize |
attacks. distributedstorageprovisionlikeproofofcapacity,proof
Some of the problems can be avoided by a slashing ofstorage[16],proofofretrievabilityandproofsofspace
| mechanismwithintheprotocolduringtheblockcreation |     |     |     |     |     | and time. |     |     |     |     |     |     |
| ------------------------------------------------ | --- | --- | --- | --- | --- | --------- | --- | --- | --- | --- | --- | --- |
process. A node that wants to participate in the consen- InProofofElapsedTime,eachoftheblockproducers
sus algorithm first needs to lock a certain number of hastowaitarandomtimetocreateablock;anequivalent
coins; this stake represents a collateral. The node that for it would be a verifiable delay function [45], suitable
seals the stake is called a leader, forger, or minter in forthepermissionlessregime.PoETandsimilarvariants
PoS terminology and can lose this collateral through a use a trusted execution environment to enforce these
technique called slashing, in case it deviates from the random delays. One notable example is Hyperledger
protocol specification. [37], but a major drawback is that it is only suitable
3) Delegated Proof-of-Stake: A popular variant of for a permissioned environment given that the process
|                                                 |            |       |          |           |            | depends    | on a       | non-standard |     | secure    | hardware       | enclave |
| ----------------------------------------------- | ---------- | ----- | -------- | --------- | ---------- | ---------- | ---------- | ------------ | --- | --------- | -------------- | ------- |
| PoS is the                                      | delegated  | proof | of stake | consensus | algorithm  |            |            |              |     |           |                |         |
| (dPoS),whereeachusercanchoosetodelegateitscoins |            |       |          |           |            | within the | processor. |              |     |           |                |         |
| to a node                                       | that takes | part  | in the   | consensus | algorithm. |            |            |              |     |           |                |         |
|                                                 |            |       |          |           |            | 5) Hybrid  | BFT        | consensus:   |     | Byzantine | fault-tolerant |         |
Theideaissimilartothecommitteesfoundinclassical consensus protocols are a vast topic with a long history
consensus models; some cryptocurrencies have a fixed, ofresearchanddevelopment,andbecamecandidatesfor
6

hybridization with current blockchain consensus algo- processes and execute a consensus algorithm to derive a
rithms: for example, PoW-BFT and PoS-BFT are most totalorderingofevents.Anexampleofacryptocurrency
widespread. network that uses virtual voting to derive consensus
Due to the scalability constraints of the BFT pro- is Hedera. They implement a modified virtual voting
tocol in terms of communication overhead, the above consensus algorithm, called gossip about gossip, where
hybridization is intended to decouple the committee nodesgossipinformationnotonlyabouttransactionsbut
election from the actual consensus. alsoaboutthegossiptheyreceive.Inthiswaythenodes
The primary functionality of the PoX mechanism is will arrive at the same conclusion, knowing how votes
to simulate the leader election in the traditional BFT would be casted if a voting process would happen, so
protocols; thus it is utilized for managing a stable they only compute a local ”virtual” vote in order to
| consensus | committee | for | each | BFT protocol |     | instance. | achieve | consensus. |     |     |     |     |     |     |
| --------- | --------- | --- | ---- | ------------ | --- | --------- | ------- | ---------- | --- | --- | --- | --- | --- | --- |
AnexampleofPoW-BFThybridarchitectureisZiliqa
|     |     |     |     |     |     |     | Other | systems | that | use | virtual | voting | techniques |     |
| --- | --- | --- | --- | --- | --- | --- | ----- | ------- | ---- | --- | ------- | ------ | ---------- | --- |
[29] that uses PoW to allow identity establishment and are [51] and [35], where the communication DAG is
groupassignmentandmultipleroundsofPBFToverthe subsequently interpreted to derive consensus. We will
consensus committee. also present a customized implementation of virtual
| As for  | the PoS-BFT |            | hybrid   | architecture, |     | a prominent | voting | in section | VI. |     |     |     |     |     |
| ------- | ----------- | ---------- | -------- | ------------- | --- | ----------- | ------ | ---------- | --- | --- | --- | --- | --- | --- |
| example | is the      | Tendermint | protocol | [15];         | the | committee   |        |            | T   |     |     |     |     |     |
formation of the block validators is made using a PoS Our architecture will implement a virtual voting
process that involves a bond deposit. Moreover, the size scheme based on a hybridization between proof of stake
of the bond stake is proportional to the voting power and proof of work. A summary of the consensus types
| and the     | leader    | of the | committee | is designated |     | using | a can beFseen |     | in Table | 2.            |     |     |     |     |
| ----------- | --------- | ------ | --------- | ------------- | --- | ----- | ------------- | --- | -------- | ------------- | --- | --- | --- | --- |
| round-robin | strategy. |        |           |               |     |       |               |     |          |               |     |     |     |     |
|             |           |        |           |               |     |       |               |     | IV.      | PREREQUISITES |     |     |     |     |
AnotheralternativeisdelegatedBFT,wheretheinitial
| problem             | of the    | byzantine   | generals     | is            | slightly  | adapted    |                |           |           |             |              |        |       |        |
| ------------------- | --------- | ----------- | ------------ | ------------- | --------- | ---------- | -------------- | --------- | --------- | ----------- | ------------ | ------ | ----- | ------ |
|                     |           |             |              |               |           | A          | A. Definitions |           |           |             |              |        |       |        |
| with representative |           | leaders     | for          | the generals. |           | This, how- |                |           |           |             |              |        |       |        |
|                     |           |             |              |               |           |            | We             | will      | use a few | definitions |              | needed | for a | better |
| ever, centralizes   |           | the network |              | in a similar  | way       | to dPoS,   |                |           |           |             |              |        |       |        |
|                     |           |             |              |               |           |            | understanding  |           | of our    | ledger      | architecture |        | and   | the    |
| even if the         | delegates | can         | be replaced; |               | a notable | example    |                |           |           |             |              |        |       |        |
|                     |           |             |              |               |           |            | consensus      | protocol. |           |             |              |        |       |        |
| implementing        | dBFT      | is          | NEO          | [43].         |           |            |                |           |           |             |              |        |       |        |
Algorand[52]alsoreliesonacustomRizedhybridPoS-
BFT consensus protocol for committing transactions. Definition 3. A node is a software program running
|                |           |                 |            |              |            |             | on a     | device      | that participates |               | in             | the NoM       | network |        |
| -------------- | --------- | --------------- | ---------- | ------------ | ---------- | ----------- | -------- | ----------- | ----------------- | ------------- | -------------- | ------------- | ------- | ------ |
| The PoS        | mechanism |                 | is used    | to compute   |            | via crypto- |          |             |                   |               |                |               |         |        |
|                |           |                 |            |              |            |             | and      | complies    | to the            | protocol      | specification. |               |         | It can |
| graphic        | sortition | the probability |            | of a node    | to         | participate |          |             |                   |               |                |               |         |        |
|                |           |                 |            |              |            |             | directly | participate | in                | the consensus |                | algorithm,    | manage  |        |
| in a committee |           | proportional    |            | to its stake | and        | the total   |          |             |                   |               |                |               |         |        |
|                |           |                 | Daccounts, |              |            |             |          | observe     | traffic           | and           | relay          | transactions. |         |        |
| current        | stake in  | the network     |            | and a        | verifiable | random      |          |             |                   |               |                |               |         |        |
| function       | is used   | to generate     |            | a publicly   | verifiable | BFT-        |          |             |                   |               |                |               |         |        |
TherearethreekindsofnodesinNoM,dependingon
| committee       | of random | nodes. |           |         |          |              |             |               |         |     |        |        |          |     |
| --------------- | --------- | ------ | --------- | ------- | -------- | ------------ | ----------- | ------------- | ------- | --- | ------ | ------ | -------- | --- |
|                 |           |        |           |         |          |              | their       | contributions | towards | the | health | of the | network, | as  |
| Generally,      | hybrid    | BFT    | protocols | enhance |          | overall net- |             |               |         |     |        |        |          |     |
| work throughput |           | and    | provide   | faster  | finality | times        | in follows: |               |         |     |        |        |          |     |
contrast with Nakamoto inspired protocols. • TrustingnodescalledSentrynodes.Abasictypeof
6) Cellular Automata: New Kind of Network [50] node, lightweight in the sense that they only store
|          |       |           |           |     |      |             | the | transaction |     | ledger or | a pruned | version | of  | it. A |
| -------- | ----- | --------- | --------- | --- | ---- | ----------- | --- | ----------- | --- | --------- | -------- | ------- | --- | ----- |
| proposes | a new | consensus | algorithm |     | that | is based on |     |             |     |           |          |         |     |       |
cellular automata and a mathematical framework devel- lightnodeonlymonitorstrafficforspecificaccounts
oped for the Ising model. The nodes act as cells and allowing minimal network usage and resources.
together with a message-passing algorithm based only • Trustless nodes called Sentinel nodes. A trustless
on sparse local neighbors and a MVCA algorithm [48] node is similar to a Pillar node, but only acts as
(i.e. Majority Vote Cellular Automata, an algorithm that an observer, it doesn’t participate in the consensus
uses majority vote as updating rules for the cells) they algorithm. It carries out the creation of PoW links
reach consensus. for transactions and requires moderate resources to
| 7) Virtual | voting: | Virtual |     | voting is | a concept | intro- | operate. |     |     |     |     |     |     |     |
| ---------- | ------- | ------- | --- | --------- | --------- | ------ | -------- | --- | --- | --- | --- | --- | --- | --- |
duced by authors Moser and Melliar-Smith in 1999, • Consensus nodes called Pillar nodes. They
where the main idea is to interpret messages as virtual participate in the consensus protocol and have
7

|     |               |     |     |     | TABLE      | II: | Consensus | types |               |     |     |     |     |
| --- | ------------- | --- | --- | --- | ---------- | --- | --------- | ----- | ------------- | --- | --- | --- | --- |
|     | Consensustype |     |     |     | Advantages |     |           |       | Disadvantages |     |     |     |     |
PoW Enableslargescaledecentralization Doesn’tscalewellwithatraditionalapproach
PoS PowerefficientincomparisonwithPoW Moreattackvectorsnon-existentinPoW
|     |     | DPoS |     | MorescalablethanPoS |     |     |     | Moresusceptibletocentralization |     |     |     |     |     |
| --- | --- | ---- | --- | ------------------- | --- | --- | --- | ------------------------------- | --- | --- | --- | --- | --- |
PoET Powerefficient,suitableforpermissioned Susceptibletothirdpartyinterferencese.g.inthecase
|     |     |     |     |     | environments |     |     |     | ofhardwareenclaves |     |     |     |     |
| --- | --- | --- | --- | --- | ------------ | --- | --- | --- | ------------------ | --- | --- | --- | --- |
BFTconsensus Wellstudiedandunderstood Needtobecoupledwithothermechanismsfor
|     |     |     |     | Basedonquorums |     |     |     |     | permissionlessnetworks |     |     |     |     |
| --- | --- | --- | --- | -------------- | --- | --- | --- | --- | ---------------------- | --- | --- | --- | --- |
Highcomplexity
|     | CellularAutomata |     |     |     | Goodscalability |     |     |     |     | Complex |     |     |     |
| --- | ---------------- | --- | --- | --- | --------------- | --- | --- | --- | --- | ------- | --- | --- | --- |
Requiresspecificnetworktopology
VirtualVoting Efficiencyofthevotingprocess Delayscanhappenuntilatransactionisaccepted
information about the transactions made in the Definition 8. Virtual voting - the concept that
network by users. A Pillar requires additional voting is not done with explicit messages. Instead, a
|     |           |              |     |         |         |            | node computes |     | the state | of  | the ledger | based | on the |
| --- | --------- | ------------ | --- | ------- | ------- | ---------- | ------------- | --- | --------- | --- | ---------- | ----- | ------ |
|     | resources | as it relays |     | network | traffic | from other |               |     |           |     |            |       |        |
Pillars and processes it. information received throughout many epochs from the
T
|     |     |     |     |     |     |     | network. | We will | show | that after | some | epochs, | if a node |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------- | ---- | ---------- | ---- | ------- | --------- |
Definition 4. Pillar nodes representing more than a can reach to a conclusion regarding a transaction, all
fraction of the locked stake in any given epoch (cid:15) are the honest nodes will reach the same conclusion.
| called | supermajority, |     | as follows: |     |     |     |     |     |     |     |     |     |     |
| ------ | -------------- | --- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
F
|     |     |     |     |     |     |     | Definition | 9.  | Broadcast | –   | the process |     | of sending |
| --- | --- | --- | --- | --- | --- | --- | ---------- | --- | --------- | --- | ----------- | --- | ---------- |
N ∗2
|     |     | ζ   | =   | +1  |     |     | the finishing | PoW | and | the transactions |     | for | undecided |
| --- | --- | --- | --- | --- | --- | --- | ------------- | --- | --- | ---------------- | --- | --- | --------- |
3
|     |     |     |     |     |     |     | epochs | to all Pillar | nodes. |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ------ | ------------- | ------ | --- | --- | --- | --- |
A
|            |     |                   |     |     |          |           | B. Network | Model |     |     |     |     |     |
| ---------- | --- | ----------------- | --- | --- | -------- | --------- | ---------- | ----- | --- | --- | --- | --- | --- |
| Definition |     | 5. Representative |     | – A | sentinel | node that |            |       |     |     |     |     |     |
knows about user transactions. We consider the execution of the protocol in an
open,dynamic,distributedsystemenabledbyamessage
Definition 6. Transaction – A Rtransaction can oriented transport protocol for data packets exchange,
| be  | of two | types: ordinary |     | send | transactions | with |       |           |      |          |         |       |           |
| --- | ------ | --------------- | --- | ---- | ------------ | ---- | ----- | --------- | ---- | -------- | ------- | ----- | --------- |
|     |        |                 |     |      |              |      | where | nodes can | join | or leave | freely. | Nodes | represent |
a corresponding receive transaction or special the core infrastructure of the network and clients are
transactions for different circumstances: to mark the external in the sense that they are issuing transactions
| entrance | in  | a new round | of  | consensus, | the | finishing |           |          |       |     |        |     |            |
| -------- | --- | ----------- | --- | ---------- | --- | --------- | --------- | -------- | ----- | --- | ------ | --- | ---------- |
|          |     |             |     |            |     |           | for nodes | to agree | upon. | We  | assume | an  | asymmetric |
D
PoWforaroundorsmarttransactionsregardingzApps. cryptographicsignatureschemethatenablesparticipants
| An     | ordinary | transaction  | contains    |     | the address      | of the |                 |     |           |              |     |              |        |
| ------ | -------- | ------------ | ----------- | --- | ---------------- | ------ | --------------- | --- | --------- | ------------ | --- | ------------ | ------ |
|        |          |              |             |     |                  |        | to authenticate |     | messages. | A node       | is  | considered   | honest |
| sender | and      | its balance, | the address |     | of the receiver, | and    |                 |     |           |              |     |              |        |
|        |          |              |             |     |                  |        | if it follows   | the | protocol  | as described |     | or byzantine | if     |
metadata containing hashes for PoW solutions. it deviates arbitrarily from the protocol specification. In
addition,thesystemisconsideredasynchronousi.e.there
Definition 6. zApp – A distributed application that is are no bounds on messages delivery.
| based | on an | unikernel | controlled | by  | a smart | contract. |          |     |             |     |     |     |     |
| ----- | ----- | --------- | ---------- | --- | ------- | --------- | -------- | --- | ----------- | --- | --- | --- | --- |
|       |       |           |            |     |         |           | C. Goals | and | assumptions |     |     |     |     |
Definition 7. Epoch - The transactions are grouped NoM allows Pillar nodes to agree on an ordered log
inconsensusroundscalledepochs.Ineveryepoch,each oftransactionsandattainsthreegoalswithrespecttothe
log:
| of the | nodes | that participate |     | in the consensus |     | algorithm |     |     |     |     |     |     |     |
| ------ | ----- | ---------------- | --- | ---------------- | --- | --------- | --- | --- | --- | --- | --- | --- | --- |
must compute a PoW with adjustable difficulty. The • Liveness goal–Evenifthereisanumberofactive
finish of a PoW is marked by a special transaction, byzantine nodes and under additional assumptions
which is then sent through the network via broadcast. about network conditions, the system will eventu-
After receiving the finishing PoW transaction from ζ, ally make progress i.e. continue appending transac-
| the | node enters | in the | next epoch | and | marks | this with | a tions | to the | log. |     |     |     |     |
| --- | ----------- | ------ | ---------- | --- | ----- | --------- | ------- | ------ | ---- | --- | --- | --- | --- |
particular transaction. • Safety goal – With high probability all the honest
|     |     |     |     |     |     |     | nodes | will | reach | to the same | conclusion |     | regarding |
| --- | --- | --- | --- | --- | --- | --- | ----- | ---- | ----- | ----------- | ---------- | --- | --------- |
8

the order of the transactions; specifically, if an E. Theorems
honestnodeacceptstransactionT(i.e.itisincluded
• T1. Availability. If a user will emit a transaction
inthelog),thenanyfuturetransactionsacceptedby
to an honest node, in the absence of attacks (e.g.
other honestnodes will appearin a logthat already
denial of service), all honest nodes will receive
contains T.
that transaction.
• Finality goal – Once a transaction is included into
the log and confirmed by honest nodes, it will
• T2. Validity. A double spend is not possible
remain confirmed in the log, despite any actions
assuming a supermajority of honest nodes.
from byzantine nodes.
• Scalability goal – The network will keep optimal • T3. Safety. If there is a supermajority of honest
confirmation times for non-conflicting transactions,
nodes, once a node reaches to a conclusion
even if the number of nodes is constantly increas-
regarding a transaction, all the honest nodes will
ing.
reach the same conclusion.
Starting with these assumptions, the byzantine agree-
ment consensus algorithm has to simultaneously meet • T4. Liveness. If the number of byzantine nodes
the following three properties: is bounded i.e. f < 1, the system will come
T3
to an agreement about the total ordering of the
• Validity: If all correct processes propose the same
value ϑ, then any correct process that decides, transactions.
decides ϑ.
• Agreement: No two correct processes decide dif- • T F 5. Scalability. Transaction times processing will
grow linearly with the number of pillar nodes.
ferently.
• Termination: Every correct process eventually de-
cides. • T6. Finality. If a transaction is confirmed (i.e. is
Apart of the ledger), it will remain forever in the
The first two properties are safety properties, i.e.,
ledger.
propertiesthatstatethat”badthings”cannothappenand
the last one is a liveness property, i.e. a property that
Proofs for the theorems are available in Appendix A.
states that ”good things” must happen.
R
V. NOMLEDGERANDCONSENSUS
D. Important attributes
A. NoM Ledger
When designing a distributed system, there are some
OurproposedNoMledgerarchitectureconsistsoftwo
attributes any distributed system exhibits and we want
separate ledgers – the actual ledger consisting of settled
to obtain a good balanceDbetween them:
transactions structured as a block-lattice where there are
• Consistency: when a node requests the state of the storedindependentindividualuseraccountchains,anda
system – in our case the distributed ledger, the DAGcalledthemeta-DAGthatcontainsthetransactions
consistency means that we will obtain the most required by the virtual voting algorithm.
recent state of the system. The block-lattice consists of actual transactions ap-
• Availability:Forarequestforthestateoftheledger, pearing in the network that are settled - send, receive
there must be an answer, even if the answer does and zApp related transactions.
not reflect the latest state of the ledger.
Every user has an account chain that is independently
• Partition tolerance: The system continues to be updated from other account chains as the virtual voting
functional even if there are message failures in the
progresses.
system.
The flow of issuing a transaction is as follows: a user
The CAP theorem [46] states that it is impossible to will have assigned some representative nodes, sentinel
achieveallthreepropertiessimultaneously.However,we nodesthatwillprocesstheirtransactionsandthatcanbe
design the network to have partition tolerance, availabil- queried in order to pull new information regarding the
ity and eventual consistency – after a number of retries, account chain or the state of the ledger.
anodewilleventuallyfindthestateofthenetworkatthe However,inordertopreventdenialofserviceattacks,
timeoftherequest.Theeventualconsistencyispreferred the queries can require a fee that needs to be applied in
over availability in many other distributed systems. order to return a valid response: for example, a user can
9

usethesentinelnodesforqueryingthestateoftheledger ofthreehopsisrequiredbyamin relay dimensioncon-
or sentry nodes to get updates regarding its account stant, and an upper bound will be dynamically imposed
| chain. |     |     |     |     |     |     |     | by a difficulty | parameter. |     | The proof | of work | will be |
| ------ | --- | --- | --- | --- | --- | --- | --- | --------------- | ---------- | --- | --------- | ------- | ------- |
As we highlighted earlier in the Definitions subsec- calculatedwithrespecttothetransactionfeepaidbythe
tion, not all network participants are also consensus user to issue the transaction. The sentinels will continue
nodes; only full nodes (i.e. pillar and sentinel nodes) to forward the transactions to other sentinels until the
keep both the transactional ledger and consensus ledger proof of work meets a specific weight threshold; when
usedforthevirtualvotingprocess.Theconsensusledger the PoW link is complete, the transaction will be sent
is organized in virtual epochs, and the consensus is to a pseudorandomly chosen consensus node (i.e. pillar
achieved per epoch. node). Finally, the PoW link will serve an additional
|     |     |     |     |     |     |     |     | objective | in the | consensus | algorithm, | representing | an  |
| --- | --- | --- | --- | --- | --- | --- | --- | --------- | ------ | --------- | ---------- | ------------ | --- |
B. PoW Links
|           |             |     |           |           |       |       |       | eliminatory  | criteria      | to  | select between  | two | conflicting |
| --------- | ----------- | --- | --------- | --------- | ----- | ----- | ----- | ------------ | ------------- | --- | --------------- | --- | ----------- |
|           |             |     |           |           |       |       |       | transactions | in case       | of  | a double spend. | An  | overview    |
| In this   | subsection, |     | we will   | introduce | a     | novel | anti- |              |               |     |                 |     |             |
|           |             |     |           |           |       |       |       | about the    | dissemination |     | and composition | of  | a PoW link  |
| sybil and | anti-spam   |     | mechanism | called    | proof | of    | work  |              |               |     |                 |     |             |
links that will enhance connectivity within the network can be seen in Algorithm 1.
| and limit        | certain | attacks   | by  | sharing | their | commitment |      |           |            |      |           |     |     |
| ---------------- | ------- | --------- | --- | ------- | ----- | ---------- | ---- | --------- | ---------- | ---- | --------- | --- | --- |
|                  |         |           |     |         |       |            |      | Algorithm | 1 PoWTLink |      | Algorithm |     |     |
| and contributing |         | resources | for | routing | and   | efficient  | data |           |            |      |           |     |     |
| delivery.        |         |           |     |         |       |            |      | procedure | POW        | LINK |           |     |     |
1:
| There | are two | goals | this mechanism |     | aims | to achieve: |     | 2:  | while True | do  |     |     |     |
| ----- | ------- | ----- | -------------- | --- | ---- | ----------- | --- | --- | ---------- | --- | --- | --- | --- |
thefirstoneistostrengthentheledgerbyaddingweight 3: t←ReceiveTransaction();
F
intoit(i.e.recordingtheresultingworkofthePoWlink) 4: if t.Sender() in Users then
andthesecondistofurtherincentivizethesentinelnodes 5: t.weight+=ComputePoW(t,t.fee);
t.links++;
| to safeguard | the | network | against | different |     | attacks | such | 6:  |     |     |     |     |     |
| ------------ | --- | ------- | ------- | --------- | --- | ------- | ---- | --- | --- | --- | --- | --- | --- |
as spam or distributed denial of service. A7: s←ChooseRandom(Sentinels);
A PoWlink needsto satisfy thefollowing conditions: 8: SendToSentinel(t,s);
else
| Only | Sentinel | nodes | can | participate | in  | the creation |     | 9:  |     |     |     |     |     |
| ---- | -------- | ----- | --- | ----------- | --- | ------------ | --- | --- | --- | --- | --- | --- | --- |
•
|      |       |         |       |     |     |     |     | 10: | t.weight+=ComputePoW(t,t.fee); |     |     |     |     |
| ---- | ----- | ------- | ----- | --- | --- | --- | --- | --- | ------------------------------ | --- | --- | --- | --- |
| of a | proof | of work | link. |     |     |     |     |     |                                |     |     |     |     |
t.links++;
| Only | the private |     | key owner | of a | S entinel | node | can | 11: |     |     |     |     |     |
| ---- | ----------- | --- | --------- | ---- | --------- | ---- | --- | --- | --- | --- | --- | --- | --- |
| •    |             |     |           |      | R         |      |     |     |     |     |     |     |     |
producevalidsignaturestobeusedthecomposition 12: if t.weight≥min target weight then
|         |         |     |      |       |     |     |     | 13: |     | p←ChooseRandom(Pillars); |     |     |     |
| ------- | ------- | --- | ---- | ----- | --- | --- | --- | --- | --- | ------------------------ | --- | --- | --- |
| process | a proof | of  | work | link. |     |     |     |     |     |                          |     |     |     |
SendToPillar(t,p);
| The | signature | attached | to  | any transaction |     | should | be  | 14: |     |     |     |     |     |
| --- | --------- | -------- | --- | --------------- | --- | ------ | --- | --- | --- | --- | --- | --- | --- |
•
|        |       |      |               |     |         |            |     | 15: | else |     |     |     |     |
| ------ | ----- | ---- | ------------- | --- | ------- | ---------- | --- | --- | ---- | --- | --- | --- | --- |
| unique | (i.e. | only | one signature |     | will be | considered |     |     |      |     |     |     |     |
s←ChooseRandom(Sentinels);
| for | any key | pair). | D16: |     |     |     |     |     |     |     |     |     |     |
| --- | ------- | ------ | ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
A minimum overall weight for the proof of work 17: SendToSentinel(t,s);
•
|            |             |        |             |                  |            |           |     | 18: | end       | if  |     |     |     |
| ---------- | ----------- | ------ | ----------- | ---------------- | ---------- | --------- | --- | --- | --------- | --- | --- | --- | --- |
| link       | is required |        | in order    | to be            | considered | valid;    | a   |     |           |     |     |     |     |
|            |             |        |             |                  |            |           |     |     | end if    |     |     |     |     |
| difficulty | parameter   |        | is computed |                  | in order   | to obtain |     | 19: |           |     |     |     |     |
|            |             |        |             |                  |            |           |     | 20: | end while |     |     |     |     |
| a min      | target      | weight | for         | the transaction. |            |           |     |     |           |     |     |     |     |
|            |             |        |             |                  |            |           |     | end | procedure |     |     |     |     |
21:
| Users    | constantly | issue | transactions |       | that      | are dissemi- |       |     |     |     |     |     |     |
| -------- | ---------- | ----- | ------------ | ----- | --------- | ------------ | ----- | --- | --- | --- | --- | --- | --- |
| nated to | a number   | of    | sentinels    | equal | with logσ | ,            | where |     |     |     |     |     |     |
n
σ is the total number of the sentinels that a user is A visual representation of this algorithm can also be
n
|     |     |     |     |     |     |     |     | seen in | Figure 1. |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | --------- | --- | --- | --- | --- |
aware of.
| Sentinel | nodes | prove | the receipt | of  | the transaction |            | by  |        |           |           |     |     |     |
| -------- | ----- | ----- | ----------- | --- | --------------- | ---------- | --- | ------ | --------- | --------- | --- | --- | --- |
|          |       |       |             |     |                 |            |     | C. The | consensus | explained |     |     |     |
| adding a | small | PoW   | computation | and | other           | additional |     |        |           |           |     |     |     |
data (e.g. digital signature, metadata), then they will Inthisparagraph,wewilldescribehowtheconsensus
| relay that | transaction |     | to another | sentinel | node | in  | a ran- | is achieved | in NoM. |     |     |     |     |
| ---------- | ----------- | --- | ---------- | -------- | ---- | --- | ------ | ----------- | ------- | --- | --- | --- | --- |
dommanner.Basically,foreachtransaction,thesentinels Clients can connect to specific nodes called represen-
will attach a small PoW computation to it, then they tatives and submit transactions for processing. For this
will randomly relay the transaction to other sentinels, consensus algorithm description we will also suppose
which will continue to add PoW and further relay that that there are no malicious actors and there are no
transaction,constructingaPoWlink;aminimumnumber ongoing attacks (e.g. denial of service, eclipse attacks,
10

epoch;wewillcallthisthe”finishingPoW”transaction.
|     |     |     |     |     |     |     | After receiving |     | the finishing |      | PoW    | from       | ζ pillar | nodes, |
| --- | --- | --- | --- | --- | --- | --- | --------------- | --- | ------------- | ---- | ------ | ---------- | -------- | ------ |
|     |     |     |     |     |     |     | it will proceed |     | to the        | next | epoch, | (cid:15) . |          |        |
1
|     |     |     |     |     |     |     | Note        | that the      | pillar       | could         | receive   | a            | finishing | PoW   |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ------------- | ------------ | ------------- | --------- | ------------ | --------- | ----- |
|     |     |     |     |     |     |     | transaction | before        | it           | finished      | computing |              | its own   | PoW   |
|     |     |     |     |     |     |     | transaction | and           | other        | transactions. |           | If it hasn’t | completed |       |
|     |     |     |     |     |     |     | the PoW     | yet, it       | will abandon |               | it and    | broadcast    | a message |       |
|     |     |     |     |     |     |     | with its    | transactions, |              | then marks    | itself    | as           | being in  | epoch |
|     |     |     |     |     |     |     | (cid:15) .  |               |              |               |           |              |           |       |
1
|     | Fig. | 1: PoW | Link | messages |     |     |        |       |     |     |     |     |     |     |
| --- | ---- | ------ | ---- | -------- | --- | --- | ------ | ----- | --- | --- | --- | --- | --- | --- |
|     |      |        |      |          |     |     | Second | stage |     |     |     |     |     |     |
Theprocesscontinueswithothertransactionsfromusers,
|                                                     |          |                |     |        |       |           | but marked | now      | as           | belonging | to        | epoch | (cid:15) . Again, | the   |
| --------------------------------------------------- | -------- | -------------- | --- | ------ | ----- | --------- | ---------- | -------- | ------------ | --------- | --------- | ----- | ----------------- | ----- |
| etc.);wereservefortreatingthoseparticularcasesinthe |          |                |     |        |       |           |            |          |              |           |           |       | 1                 |       |
|                                                     |          |                |     |        |       |           | node will  | start    | working      | for       | the proof | of    | work in           | order |
| following                                           | section. |                |     |        |       |           |            |          |              |           |           |       |                   |       |
|                                                     |          |                |     |        |       |           | to enter   | in epoch | (cid:15) 2 ; | again,    | it will   | enter | after receiving   |       |
| In order                                            | to make  | a transaction, |     | a user | needs | to inform |            |          |              |           |           |       |                   |       |
|                                                     |          |                |     |        |       |           | ”finishing | PoW”     | transactions |           | from      | ζ and | so on.            |       |
therepresentatives,inthiscasesentinelnodes.Iftheuser Notice that if aTnode already received messages from
isrunningasentinelnode,itwillfurtherdisseminatethe
|             |          |           |     |          |            |         | a supermajority |         | of pillar | nodes       | informing |     | it that       | they |
| ----------- | -------- | --------- | --- | -------- | ---------- | ------- | --------------- | ------- | --------- | ----------- | --------- | --- | ------------- | ---- |
| transaction | to other | sentinels |     | in order | to prevent | eclipse |                 |         |           |             |           |     |               |      |
|             |          |           |     |          |            |         | finished        | the PoW | for       | the current | epoch,    |     | it will abort | the  |
attacks; the PoW link generation starts and develops as proof of work generation and enter automatically into
| described | bythe | algorithm | fromthe | previous |     | paragraph. |           |        |     |        |     |          |           |     |
| --------- | ----- | --------- | ------- | -------- | --- | ---------- | --------- | ------ | --- | ------ | --- | -------- | --------- | --- |
|           |       |           |         |          |     |            | the neFxt | epoch. | The | reason | for | aborting | the proof | of  |
Let’sshiftthefocustowhathappenswiththetransac- work is that there will be no reward for it, because at
| tions when  | they          | reach | a pillar     | node. As | time | progresses |               |       |           |            |         |       |       |         |
| ----------- | ------------- | ----- | ------------ | -------- | ---- | ---------- | ------------- | ----- | --------- | ---------- | ------- | ----- | ----- | ------- |
|             |               |       |              |          |      |            | a later       | epoch | the nodes | will       | compute | which | were  | the     |
| pillars are | incorporating |       | transactions | into     | the  | consensus  |               |       |           |            |         |       |       |         |
|             |               |       |              |          |      |            | fastest nodes | for   | that      | particular | epoch   | and   | issue | rewards |
TAhe
| ledger and | initially | mark   | them     | as       | not decided. |           | accordingly. |                |     |     |         |             |     |         |
| ---------- | --------- | ------ | -------- | -------- | ------------ | --------- | ------------ | -------------- | --- | --- | ------- | ----------- | --- | ------- |
| reason     | is that   | a user | can make | a double |              | spend and |              |                |     |     |         |             |     |         |
|            |           |        |          |          |              |           | Now,         | let’s consider |     | two | random, | independent |     | pillars |
disseminate it to two different representatives. After a from the network in a certain moment during the
| number           | of epochs, | all        | the pillar | nodes        | will | detect with |             |            |          |         |     |      |           |      |
| ---------------- | ---------- | ---------- | ---------- | ------------ | ---- | ----------- | ----------- | ---------- | -------- | ------- | --- | ---- | --------- | ---- |
|                  |            |            |            |              |      |             | consensus   | algorithm: |          | between |     | the  | finishing | PoW  |
| high probability |            | the double | spend      | tranRsaction |      | and they    |             |            |          |         |     |      |           |      |
|                  |            |            |            |              |      |             | transaction | and        | entering | into    | the | next | epoch.    | When |
will vote only one to remain in the ledger. After some a node sends a broadcast, it also includes all the
time,wewillpresumablyhavemanytransactions–send
|     |     |     |     |     |     |     | transactions | it  | knows | about | from | other | nodes, | so in |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ----- | ----- | ---- | ----- | ------ | ----- |
andreceivepairs,thatareindividuallyheldbyconsensus perfect network conditions after a broadcast all the
| nodes. |     |     |     |     |     |     | nodes will | know | about | the | transactions |     | between | the |
| ------ | --- | --- | --- | --- | --- | --- | ---------- | ---- | ----- | --- | ------------ | --- | ------- | --- |
D
Wewillfurtherdetailhowthenormaloperationofthe start of epoch and the finishing PoW directly from it.
consensus algorithm takes place, assuming only honest However, they will not know about the transactions
participants.
betweenthefinishingPoWandthenextepoch.Afterthe
First stage finishing PoW transaction from epoch (cid:15) , the node will
1
At the start of the algorithm, let’s suppose that all broadcast all its transactions, including those between
transactions are marked as being in epoch (cid:15) 0 . So when the finishing PoW from epoch (cid:15) and the start of epoch
0
| a user issues | a   | transaction, | the | pillar node | will | keep the | (cid:15) . |     |     |     |     |     |     |     |
| ------------- | --- | ------------ | --- | ----------- | ---- | -------- | ---------- | --- | --- | --- | --- | --- | --- | --- |
1
| transaction | received     | from | a     | sentinel      | node if  | valid, and |       |       |     |     |     |     |     |     |
| ----------- | ------------ | ---- | ----- | ------------- | -------- | ---------- | ----- | ----- | --- | --- | --- | --- | --- | --- |
| marks it    | as belonging | to   | epoch | (cid:15) . At | the same | time, all  | Third | stage |     |     |     |     |     |     |
0
the pillars will compute a proof of work with adjustable At the beginning of epoch (cid:15) , every node will know
2
difficulty, in order to keep the epoch duration within about all the transactions from epoch (cid:15) 0 – they will
some time bounds, for example 1 minute. After a pillar receive information about the transactions between the
nodefinishesitsproofofwork,itwillbroadcastaspecial startofepochandthefinishingPoWtransactionfromζ.
transaction to all other pillar nodes from the network, to This will happen because, in the meantime, all the
announcethemthatithasfinishedthePoWforepoch(cid:15) . pillars found out about those transactions at the end of
0
The special transaction includes additional information epoch(cid:15) 2 andtheyalsosendabroadcastatepoch(cid:15) 2 ,but
like the number of the current epoch and represents the they will have only one copy regarding the messages
fact that the pillar node is ready to enter into the next from the finishing PoW and the start of epoch (cid:15) –
1
11

only the transaction made by the pillar itself. However, network conditions, a pillar will show the new ledger
at epoch (cid:15) , all the nodes will make another broadcast. to a sentinel after three epochs – if a user have made a
2
Let’s suppose that all pillars will have a copy of those transaction at epoch (cid:15) , it will find about it at epoch (cid:15) .
0 3
messages between the finishing PoW in epoch (cid:15) and Inthenextsectionwewilldiscusssomeattackscenar-
0
the start of epoch (cid:15) . ios and also the complexity of the consensus algorithm.
2
Fourth stage
Atthestartofepoch(cid:15) ,pillarswillhavemessagesfrom
3
ζ regarding all the transactions between epoch (cid:15) and
0
epoch (cid:15) – the transactions between the start of epoch
1
(cid:15) and the finishing PoW transaction will be discovered
0
at the start of epoch (cid:15) , and the remaining transactions
2
will be found at the start of epoch (cid:15) , so any pillar will
3
apply the same ordering to them.
Later stages
Fig. 2: Consensus algorithm visualization
However, special cases can appear where not all mes- T
sages will arrive to all pillars, so even if the pillar will
The consensus mechanism can be better visualized
receive messages from ζ, not all the pillars will have all
in Figure 2. There are four pillars, A, B, C and D.
the transactions.
Each pillar computes a proof of work during an epoch,
Let’s assume that only a simple majority will have F
receivingtransactions suppliedby sentinelnodes.At the
them. In that situation, the pillar will have to wait for
beginning of epoch (cid:15) , A doesn’t know the transactions
the next epochs until all the transactions between epoch 1
thathappenbetweenthefinishingPoWtransactionforB
(cid:15) and epoch (cid:15) will be confirmed by a supermajority
o 0 f nodes. For th 1 eoretical reasons, if a conclusion ca A n’t and the starting of epoch (cid:15) 1 for B. At the start of epoch
(cid:15) , A has received those transactions, but only from B.
be reached after a certain number of epochs, a coin 2
At the beginning of epoch (cid:15) , A has received messages
roundwillbeneeded-everyhonestpillarwillrandomly 3
from all the pillars regarding the transactions at epoch
vote on transactions, in order to prevent an attacker
(cid:15) , including those between the finishing PoW and the
controlling the internet traffic from dedRucing the votes. 0
start of the epoch.
The node will further broadcast its vote in the next
The consensus is summarized in Algorithm 2.
epoch.
Now, regarding the previous theorems, if a node will D. Pillars PoW pools
know the transactions be D tween epoch (cid:15) 0 and epoch (cid:15) 1 Inorderforthepillarstobecompetitiveintheprocess
and it will apply a deterministic ordering algorithm and of producing the proof of work, they will have the
in case of double spends, a deterministic tie-breaker possibilitytooutsourceitusingtheminingpoolconcept.
algorithm,thusalltheremaininghonestnodeswillarrive This will create a market efficient ecosystem that will
at the same decision. After the node will have a super- further strengthen the network and clients committing
majority of messages with all the transactions between resourcesforPillarpoolswillberewardedproportionally
epoch(cid:15) 0 and(cid:15) 1 (asperdefinition4,thesupermajorityis to their contribution of processing power. We are also
weighted with a proof of stake mechanism), it will start investigating the use of a custom difficulty adjustment
to virtually vote on the ordering. mechanismthatwillbalancebetweenASIC-friendlyand
The vote is not actually a real one in the sense that
ASIC-resistant hashing algorithms in order to improve
it doesn’t involve sending additional network messages,
network security and obtain a higher degree of decen-
but a set of rules that define a deterministic way to
tralization. We will defer a detailed specification for a
order the transactions, such as: the PoW link weight,
later date.
the timestamp when they arrived at the pillar and, as
E. Unikernels and distributed applications
tiebreakers, the hash of the transaction. After a node
will order the transactions, it will know that the order The following subsection is describing the core com-
is the same for all the nodes so it will mark them in ponent of our future distributed apps system, called
the ledger and for every transaction it will put an id zApps, which will be integrated into the NoM archi-
to know the number of the transaction. So, in optimal tecture. We are introducing a novel design based on
12

| Algorithm    | 2 Consensus         | Algorithm |       |               |     |
| ------------ | ------------------- | --------- | ----- | ------------- | --- |
| 1: procedure | CONSENSUSALGORITHM  |           |       |               |     |
| Thread       | WaitForTransactions |           | = new | WaitThread(); |     |
2:
| 3: ComputePoW |     | = new ComputeThread(); |     |     |     |
| ------------- | --- | ---------------------- | --- | --- | --- |
WaitForTransactions.run();
4:
5: Epoch←0;
| 6: min | consensus | delay       | ←3; |     |     |
| ------ | --------- | ----------- | --- | --- | --- |
| min    | coin      | round delay | ←5; |     |     |
7:
8: LastConsensusEpoch←0;
| 9: while | True              | do         |     |     |     |
| -------- | ----------------- | ---------- | --- | --- | --- |
| 10:      | count←0;          |            |     |     |     |
| 11:      | zeta←2/3∗Nodes+1; |            |     |     |     |
|          | while             | count<zeta | do  |     |     |
12:
| 13: | count+=AcceptedBroadcast(); |     |     |     |     |
| --- | --------------------------- | --- | --- | --- | --- |
T
| 14: | if Epoch<CurrentEpoch() |     |     | then |     |
| --- | ----------------------- | --- | --- | ---- | --- |
Epoch←CurrentEpoch();
15:
| 16: | end                    | if  |      |     |     |
| --- | ---------------------- | --- | ---- | --- | --- |
|     | if ComputePow.finish() |     | then |     |     |
17:
F
| 18: |     | BroadcastPoWandTxs(); |     |     |     |
| --- | --- | --------------------- | --- | --- | --- |
| 19: | end | if                    |     |     |     |
end while
20:
| 21: | if !ComputePoW.ended() |     | then | A   |     |
| --- | ---------------------- | --- | ---- | --- | --- |
ComputePoW.abort();
22:
| 23: | BroadcastTxs(); |     |     |     |     |
| --- | --------------- | --- | --- | --- | --- |
| 24: | end if          |     |     |     |     |
Epoch←Epoch+1
25:
R
| 26: | if Epoch≥min | consensus                   |     | delay then |     |
| --- | ------------ | --------------------------- | --- | ---------- | --- |
|     | for          | t in UnresolvedTransactions |     | do         |     |
27:
| 28: |     | if t.Epoch()≤Epoch−min |     | consensus | delay then |
| --- | --- | ---------------------- | --- | --------- | ---------- |
| 29: |     | if countVotes(t)>zeta  |     | then      |            |
DTxEpochs[Epoch].add(t);
30:
| 31: |     | counter[Epoch]++; |     |     |     |
| --- | --- | ----------------- | --- | --- | --- |
| 32: |     | end if            |     |     |     |
| 33: |     | end if            |     |     |     |
34: if t.Epoch()≤Epoch−min consensus delay−min coin round delay then
|     |     | if t.HasConflict() | then |     |     |
| --- | --- | ------------------ | ---- | --- | --- |
35:
| 36: |     | tc←t.GetConflict(); |      |     |     |
| --- | --- | ------------------- | ---- | --- | --- |
| 37: |     | coin←random(0,1);   |      |     |     |
|     |     | if coin=0           | then |     |     |
38:
| 39: |     | remove(t); |     |     |     |
| --- | --- | ---------- | --- | --- | --- |
else
40:
| 41: |     | remove(tc); |     |     |     |
| --- | --- | ----------- | --- | --- | --- |
| 42: |     | end if      |     |     |     |
|     |     | end if      |     |     |     |
43:
| 44: |     | end if |     |     |     |
| --- | --- | ------ | --- | --- | --- |
end for
45:
13

| Algorithm | 2 Consensus |     | algorithm | (continued) |     |     |     |     |     |     |     |     |
| --------- | ----------- | --- | --------- | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
46: for i←Epoch−min consensus delay;i>=LastConsensusEpoch;i−=1 do
|     |     | HaveToOrder |     | = []; |     |     |     |     |     |     |     |     |
| --- | --- | ----------- | --- | ----- | --- | --- | --- | --- | --- | --- | --- | --- |
47:
| 48: |     | if counter[i]=TotalTransactions[i]            |                      |     |     |     | then |     |     |     |     |     |
| --- | --- | --------------------------------------------- | -------------------- | --- | --- | --- | ---- | --- | --- | --- | --- | --- |
| 49: |     | LastConsensusEpoch=min(LastConsensusEpoch,i); |                      |     |     |     |      |     |     |     |     |     |
|     |     | for                                           | t in TxEpochs[Epoch] |     |     | do  |      |     |     |     |     |     |
50:
| 51: |     |     | HaveToOrder.add(t); |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | ------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
UnresolvedTransactions.remove(t);
52:
| 53: |     | end    | for |     |     |     |     |     |     |     |     |     |
| --- | --- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 54: |     | end if |     |     |     |     |     |     |     |     |     |     |
end for
55:
| 56: |     | if HaveToOrder.size()>0 |             |     | then              |     |     |     |     |     |     |     |
| --- | --- | ----------------------- | ----------- | --- | ----------------- | --- | --- | --- | --- | --- | --- | --- |
| 57: |     | sort(HaveToOrder);      |             |     |                   |     |     |     |     |     |     |     |
| 58: |     | for t in                | HaveToOrder |     | do Ledger.add(t); |     |     |     |     |     |     |     |
| 59: |     | end for                 |             |     |                   |     |     |     |     |     |     |     |
end if
60:
T
| 61:     | end   | if  |     |     |     |     |     |     |     |     |     |     |
| ------- | ----- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 62: end | while |     |     |     |     |     |     |     |     |     |     |     |
end procedure
63:
F
unikernels [54] to expand the limits of smart contracts configuration and management are carried out by smart
and enable complex computational tasks. An ideal ver- contracts that handle certain aspects of the applications’
sion of a zApps platform should exhibit the following A life cycle such as compilation or deployment. By us-
characteristics: ing this approach, errors like accidental configuration
|           |     |                 |     |         |              |     | alterations | can be prevented | and | the | exploitation | can |
| --------- | --- | --------------- | --- | ------- | ------------ | --- | ----------- | ---------------- | --- | --- | ------------ | --- |
| Security: |     | The environment |     | for the | applications |     |             |                  |     |     |              |     |
•
|     |     |     |     |     |     |     | exclusively | be carried | only on | the end | application. | Per- |
| --- | --- | --- | --- | --- | --- | --- | ----------- | ---------- | ------- | ------- | ------------ | ---- |
shouldbesandboxedwithgranularpermissionpoli-
|     |     |     |     |     |     |     | formance | is another issue | for many | systems; |     | unikernels |
| --- | --- | --- | --- | --- | --- | --- | -------- | ---------------- | -------- | -------- | --- | ---------- |
cies.
R
Immutability: The zApps should be immutable in have several benefits such as fast booting times (e.g.
•
|     |       |                  |     |             |             |     | can boot           | several orders | of magnitude | faster    | than | normal    |
| --- | ----- | ---------------- | --- | ----------- | ----------- | --- | ------------------ | -------------- | ------------ | --------- | ---- | --------- |
| the | sense | that they cannot |     | be modified | or tampered |     |                    |                |              |           |      |           |
|     |       |                  |     |             |             |     | virtual machines), | avoiding       | context      | switching |      | and using |
with.RunningzAppsonuntrustedhardwareshould
| betrustlessanddeterministicandoneshouldexpect |     |     |     |     |     |     | minimum | system resources. |     |     |     |     |
| --------------------------------------------- | --- | --- | --- | --- | --- | --- | ------- | ----------------- | --- | --- | --- | --- |
consistent results. D TheinfrastructuretorunzAppswillconsistofspecial
Privacy: To provide means that protect the privacy nodesthatwillhavespecificrequirements(e.g.minimum
•
|     |               |      |          |         |      |     | resources | in terms of | connectivity, | hardware |     | specifi- |
| --- | ------------- | ---- | -------- | ------- | ---- | --- | --------- | ----------- | ------------- | -------- | --- | -------- |
| of  | participants, | both | internal | between | them | and |           |             |               |          |     |          |
external from third parties, based on secure multi- cations, collateral, etc.). The idea is similar to a de-
party computation protocols. centralizedinfrastructure-as-a-servicemodelwhereusers
|     |     |     |     |     |     |     | can have | access to an | instant computing |     | infrastructure, |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | ------------ | ----------------- | --- | --------------- | --- |
Withtheriseoftheunikernel(i.e.minimalstandalone
|                   |     |                  |     |        |          |       | managed | and provisioned | within | the NoM | network. |     |
| ----------------- | --- | ---------------- | --- | ------ | -------- | ----- | ------- | --------------- | ------ | ------- | -------- | --- |
| virtual machine), |     | these properties |     | can be | achieved | using |         |                 |        |         |          |     |
a smart contract layer to create a hybrid system suitable The unikernel design ensures both internal and ex-
|             |            |     |          |           |            |     | ternal protection | for | the underlying | infrastructure |     | that |
| ----------- | ---------- | --- | -------- | --------- | ---------- | --- | ----------------- | --- | -------------- | -------------- | --- | ---- |
| for complex | workloads. |     | The most | important | advantages |     |                   |     |                |                |     |      |
in using an unikernel based approach are in terms of performs the execution. Furthermore, we are analyzing
security - they are completely isolated from the host several economical models to implement in order to
|     |     |     |     |     |     |     | ensure | that an application | will | reach | the end | of an |
| --- | --- | --- | --- | --- | --- | --- | ------ | ------------------- | ---- | ----- | ------- | ----- |
andperformance-theyarelightweightandrunatnative
speeds. execution without issues, including providing a way for
|           |           |            |     |             |          |     | the user | to hire several | other | nodes | to verify | certain |
| --------- | --------- | ---------- | --- | ----------- | -------- | --- | -------- | --------------- | ----- | ----- | --------- | ------- |
| Regarding | security, | unikernels |     | are systems | designed |     |          |                 |       |       |           |         |
with a single process and a limited number of system checkpoints for example.
calls, further reducing the attack surface in terms of re- Periodically, the users will need to pay for the zApps
motecodeexecution,shellcodeattacks,etc.Theyfurther usage; this system will be designed in a similar way gas
limitpotentialattacksbylackingauserbasedsystem:the [53] is implemented for smart contracts as a fees mech-
14

anism that prevents abuse and circumvent the Turing will decide on the same transaction to be retained in
completeness property (e.g. infinite loops). This process the ledger as confirmed, using the predefined rules we
will be automatized through a series of smart contracts presented earlier and discarding the double spend.
that will be used to manage the zApps operation and If a pillar node gets corrupted and is acting mali-
the transfer of gas. The user will have the possibility to ciously, it can accept a double-spending transaction and
cancel at any time the execution of the app, by either send contradictory information to other pillars. This at-
explicitly sending an abort command or by not paying tack scenario is improbable but entirely possible; pillars
the corresponding gas to the node. unlike miners have no economic incentive to attack the
In Figure 3 we describe how unikernels can be network; nevertheless, it is an irrational attack because
integrated into the system. attempting to violate the ledger would be destructive to
|     |     |     |     |     | the network  | as a    | whole,            | which | in turn   | would | undermine   |
| --- | --- | --- | --- | --- | ------------ | ------- | ----------------- | ----- | --------- | ----- | ----------- |
|     |     |     |     |     | the validity | of      | their investment. |       | Byzantine |       | pillars are |
|     |     |     |     |     | accounted    | for and | as long           | as    | there is  | only  | a malicious |
minority,afteranumberofepochsallhonestpillarswill
eventuallydetectthedoublespendanddiscardit.Weare
|     |     |     |     |     | also considering |     | a penalizing |     | algorithm | to punish | such |
| --- | --- | --- | --- | --- | ---------------- | --- | ------------ | --- | --------- | --------- | ---- |
corruTpted
|     |     |     |     |     | behavior | for |     | pillars. |     |     |     |
| --- | --- | --- | --- | --- | -------- | --- | --- | -------- | --- | --- | --- |
B. Forking
|     |                    |     |       |     | A forking      | attack   | can        | happen     | at any | stage,          | including |
| --- | ------------------ | --- | ----- | --- | -------------- | -------- | ---------- | ---------- | ------ | --------------- | --------- |
|     |                    |     |       |     | from thFe      | start of | the ledger | - the      | attack | is also         | known as  |
|     |                    |     |       |     | ledger cloning | and      | all        | pure proof | of     | stake solutions | are       |
|     | Fig. 3: Unikernels | and | zApps |     |                |          |            |            |        |                 |           |
|     |                    |     |       |     | vulnerable     | to it.   |            |            |        |                 |           |
However,NoMisnotaffectedbecauseweemploytwo
A
|     |     |     |     |     | proof of | work | mechanisms: | virtuous |     | transactions | need |
| --- | --- | --- | --- | --- | -------- | ---- | ----------- | -------- | --- | ------------ | ---- |
VI. POSSIBLEATTACKS
|     |     |     |     |     | a PoW | threshold | satisfied | obtained | from | the | PoW link |
| --- | --- | --- | --- | --- | ----- | --------- | --------- | -------- | ---- | --- | -------- |
Since every distributed network is designed to with- algorithm to get into the ledger, together with the proof
| stand byzantine | activity, | it is necessary | to  | highlight the |         |           |      |        |          |     |     |
| --------------- | --------- | --------------- | --- | ------------- | ------- | --------- | ---- | ------ | -------- | --- | --- |
|                 |           |                 |     |               | of work | mechanism | used | by the | pillars. |     |     |
most important related attack vectors foRr a decentralized For each pillar, a proof of work translated into com-
ledger system. putationalpowerisrequiredtocompleteeachepochand
| [55] gives | us a detailed | list of | attacks targeted | at the |             |       |           |     |        |         |             |
| ---------- | ------------- | ------- | ---------------- | ------ | ----------- | ----- | --------- | --- | ------ | ------- | ----------- |
|            |               |         |                  |        | an attacker | needs | to outrun | all | honest | pillars | in order to |
Bitcoin network. We will analyze the most important obtain a heavier ledger in terms of accumulated PoW.
| problems | and how the network | confronts | them. |     |          |           |         |      |        |        |            |
| -------- | ------------------- | --------- | ----- | --- | -------- | --------- | ------- | ---- | ------ | ------ | ---------- |
|          |                     |           |       |     | Also, we | take into | account | that | a user | cannot | be tricked |
D
An in-depth analysis of these attack vectors and mit- to land on a forked ledger. A malicious adversary can
igation solutions are presented in the following subsec- only try to convince new nodes that his fork it the real
tions.
|     |     |     |     |     | ledger,      | but there | are certain | ways    | to     | deter this: | a node |
| --- | --- | --- | --- | --- | ------------ | --------- | ----------- | ------- | ------ | ----------- | ------ |
|     |     |     |     |     | will connect | to        | several     | pillars | to get | the ledger. | Upon   |
A. Double-spending
|     |     |     |     |     | successful | synchronization |     | it  | will observe | which | is the |
| --- | --- | --- | --- | --- | ---------- | --------------- | --- | --- | ------------ | ----- | ------ |
One of the first classes of attacks and one of the heaviestonebeforelegitimizingit.Thereforeforkingthe
most important problem when designing a decentralized ledger at any time is an irrational attack.
| ledger system | is the double-spending |     | problem. | Bitcoin |     |     |     |     |     |     |     |
| ------------- | ---------------------- | --- | -------- | ------- | --- | --- | --- | --- | --- | --- | --- |
C. DNS Attacks
| emerged as | the most influential | cryptocurrency |     | network |     |     |     |     |     |     |     |
| ---------- | -------------------- | -------------- | --- | ------- | --- | --- | --- | --- | --- | --- | --- |
because it was the first to solve the double-spending A DNS attack may occur when a new user wants to
problem in a decentralized environment. The integrity join the network and connects to a list of peers obtained
property of the consensus algorithm states that for any from a DNS query; this is a common network discovery
honest node, accepted transactions are consistent among mechanismusedbymanymajorblockchainnetworks.If
honest nodes (i.e. double-spending cannot occur). the attacker manages to inject his IP addresses instead
Any user can initiate a double spend if it distributes of the original ones, the new user can be compromised.
twotransactionswiththesameparenttodifferentpillars; This attack can be part of a chain of attacks; there
however, after a number of epochs all of the pillars is research regarding DNS attacks and there are some
will know about both transactions and all honest pillars solutions to this kind of attack [56] [57]. This attack
15

can’t be totally neglected and is still a valid attack for The worst case scenario is an attacker taking down
any type of distributed network, but there are many some pillar nodes, but it will have a limited impact on
viable solutions that are already implemented in real- the network that will continue to confirm transactions
world systems. with lag. There are some mechanisms to prevent this
like a detection of the consensus delay mechanism and
D. Eclipse attacks
a special coin round.
An eclipse attack means that an attacker manages to
isolate a user from the rest of the network. Even if H. Majority attack
an eclipse attack is not possible for a pillar, because This is one of the most destructive attacks that can
it has access to all the other ones and it is very unlikely occur in a decentralized network, however, it is highly
to replace pillar identities with fake ones, an eclipse improbable due to the incentive mechanisms of the
attack can occur for a single user which connects to a system.
percentage of the pillars, as discussed earlier. If an attacker can somehow obtain pillars that have
Afteraneclipseattack,theuserwillonlyseewhatthe a cumulated stake of 51%, it can add or alter new
attackerwants,andthiscanhavebadconsequences,like transactions. It can’t modify transactions that happened
adoublespend.However,thisattackiscommontoother inthepast,butnonetheless,thenetworkiscompromised
decentralized systems and there are some strategies, for in this case. In o T rder to avoid this attack, the honest
example random connection at the nodes in the begin- majority assumption should hold at all times:
ning,makingveryunlikelyforanattackertoaccomplish
this attack. Honest nodes>Malicious nodes
F
E. Sybil attacks Evenwithastakeof ζ+1theattackercanoverpowerthe
2
network-becausetherewillbenohonestsupermajority.
Sybil attacks are among the most destructive for a
This is worth mentioning as a hard limit for the net-
decentralized network because if an entity is able to
Awork. So,in order tofunction properly, avital condition
create a large number nodes on a machine in order to
for the network is:
gain control over the network. However, because the
voting is weighted based on the pillar’s stake, adding
Honest nodes >= 2∗Malicious nodes+1
more nodes will not gain the attacker extra power in the
consensus algorithm. Therefore there arRe no advantages VII. PARAMETERSANDCOMPLEXITY
to be attained with a sybil attack.
A. Complexity analysis
F. DoS attacks Wewillnowdiscussthecomplexityofthealgorithms.
The denial of service attack can occur if a malicious We can express the complexity regarding the number of
D
user sends a lot of transactions to the sentinels. We messages and time. As we have seen earlier, during an
made this attack harder by adding a transaction fee, epoch, users make transactions, that are first distributed
which means that the attacker will make the sentinels at a small number of sentinels and that are further
unavailable at the cost of investing resources in the forwarded to other sentinels – we can consider this
system, which is a positive aspect for the network and O(log(S)) in terms of messages, where S is the number
a negative one for the attacker, taking into account that of the sentinels.
the consensus is unaffected. The most consuming time happens in the consensus
algorithm, where all the pillar nodes send broadcasts
G. Consensus delay
to all other pillar nodes, so during an epoch the total
A consensus delay can happen if the attacker can number of messages is O(N2). However, if we assume
interfere with network traffic among pillar nodes. This good network conditions and if we consider the calcu-
attack is unlikely to cause damage if there is a sufficient lations per pillar, during an epoch, we will obtain that a
numberofactivepillarsinthenetwork;anattackercould pillar has to send a message to every other pillar node
interfere with messages between a certain number of and receive a message from every other pillar node. In
nodes – for example, by initiating a DDoS attack. In conclusion, we will obtain O(N) number of messages
this case, the consensus may be delayed resulting in un- per pillar, and O(N) time complexity. Due to the fact
confirmedtransactions;still,theprobabilityofreachinga thatweassumedgoodnetworkconditions,thetotaltime
supermajority is one as the number of epochs increases. spent for a broadcast is small enough in order for the
16

network to support thousands of messages per second attack, if a user connects to malicious nodes. This is
during the consensus epochs. the reason why each user has to send his transactions
Because the network has a representative system, if to log(S) , where S is the number of the sentinels.
thereareNuserswhichsendMmessagesperepocheach Because sentinel nodes are interested in maintaining a
and we have K number of pillars and we suppose a user healthynetworkbycomputingPoWlinksandconsuming
sends a transaction to log(K) pillars (log(K) sentinels fees, we can assume that most of them will be honest.
which further send to a pillar), that means we will have Coupledwitharandomselectionalgorithmforchoosing
τ messages, where the sentinels, even for 40 sentinels, if 12 are corrupt
sentinels(33%),theprobabilityofchoosingallsentinels
τ =log(K)∗M being malicious is under 0.1%. The same logic can be
appliedforpillars.Anotherproblemishowtochoosethe
| A pillar | will | support | θ messages |     | during | an epoch, | so  |     |     |     |     |     |     |     |
| -------- | ---- | ------- | ---------- | --- | ------ | --------- | --- | --- | --- | --- | --- | --- | --- | --- |
foreverylog(K)messagesapillarwillreceiveonlyone, initial bootstrapping nodes. The user will connect to a
numberofnodesandwillchooserandomlyamongthem,
with
|     |     |     |     |     |     |     | and they | will send | a list | of sentinels |     | from | the network |     |
| --- | --- | --- | --- | --- | --- | --- | -------- | --------- | ------ | ------------ | --- | ---- | ----------- | --- |
M ∗log(K) to it. This way, the chance for an attack is very small.
θ =
K
|        |         |         |             |     |      |        | C. CryptoeconomTic |     | system |     |     |     |     |     |
| ------ | ------- | ------- | ----------- | --- | ---- | ------ | ------------------ | --- | ------ | --- | --- | --- | --- | --- |
| During | optimal | network | conditions, |     | with | speeds | of                 |     |        |     |     |     |     |     |
100 Mb/s, and for a packet of 100 kb, a pillar can In order for the network to function properly, a
|         |      |          |     |         |     |          | cryptoeconomic |               | layer | will be      | put in | place | for  | all the |
| ------- | ---- | -------- | --- | ------- | --- | -------- | -------------- | ------------- | ----- | ------------ | ------ | ----- | ---- | ------- |
| support | 1000 | messages | per | second. | For | a number | of             |               |       |              |        |       |      |         |
|         |      |          |     |         |     |          | network        | participants. |       | The sentinel |        | nodes | will | benefit |
1024pillars,however,each10pillarswillhavethesame
messages,buttherewillbe 102groupsof10pillarswith fromthFefeesbyconsumingtheminordertocomputethe
|           |           |        |       |        |             |     | PoW links. | Also, | the sentinels |     | can enable | a   | separate | fee |
| --------- | --------- | ------ | ----- | ------ | ----------- | --- | ---------- | ----- | ------------- | --- | ---------- | --- | -------- | --- |
| different | messages, | so the | total | number | of messages |     | per        |       |               |     |            |     |          |     |
secondinthenetworkcantopat100000TPS.However, system for user queries that retrieve information about
|     |     |     |     |     |     |     | the state | of the | ledger. | The pillars | will | be  | incentivized |     |
| --- | --- | --- | --- | --- | --- | --- | --------- | ------ | ------- | ----------- | ---- | --- | ------------ | --- |
this is from a purely theoretical perspective, but it gives A
|             |       |     |                   |     |     |      | for computing |     | the proof | of work | for | the current |     | epoch. |
| ----------- | ----- | --- | ----------------- | --- | --- | ---- | ------------- | --- | --------- | ------- | --- | ----------- | --- | ------ |
| as an upper | bound | for | the calculations. |     | The | real | speed         |     |           |         |     |             |     |        |
will decrease due to the cost of the broadcasts. A pillar Ifapillarreceivesasupermajorityofmessagesfromthe
|          |            |        |     |          |     |       | next epoch | before | finishing | its | PoW, | it will | no  | longer |
| -------- | ---------- | ------ | --- | -------- | --- | ----- | ---------- | ------ | --------- | --- | ---- | ------- | --- | ------ |
| receives | θ messages | during |     | an epoch | and | sends | only       |        |           |     |      |         |     |        |
K messages, but those messages will be bigger and will be rewarded. This is designed to ensure a network wide
|     |     |     |     |     | Rcompetitiveness: |     |     |     | the pillars | can | outsource |     | the proof | of  |
| --- | --- | --- | --- | --- | ----------------- | --- | --- | --- | ----------- | --- | --------- | --- | --------- | --- |
takealargeramountoftimetobepropagatedthroughout
|     |     |     |     |     |     |     | work, acting | as  | mining | pools | to amass | resources |     | and |
| --- | --- | --- | --- | --- | --- | --- | ------------ | --- | ------ | ----- | -------- | --------- | --- | --- |
the network.
In the future, we plan to make some experiments rewarding accordingly the clients that supply them with
|             |     |           |        |     |                 |     | computational |     | power. The | last | type of | incentivization |     | is  |
| ----------- | --- | --------- | ------ | --- | --------------- | --- | ------------- | --- | ---------- | ---- | ------- | --------------- | --- | --- |
| to quantify | the | supported | number |     | of transactions |     | per           |     |            |      |         |                 |     |     |
second. Another researchDdirection that we will tackle for the zApp platform, where a gas like system will be
|           |     |                 |     |           |      |         | implemented | in  | order to | reward | nodes | that | support | this |
| --------- | --- | --------------- | --- | --------- | ---- | ------- | ----------- | --- | -------- | ------ | ----- | ---- | ------- | ---- |
| is to see | how | the traditional |     | broadcast | will | compare | to          |     |          |        |       |      |         |      |
feature.
| more scalable |         | alternatives. | In         | general, | there        | is a | trade-      |        |     |     |     |     |     |     |
| ------------- | ------- | ------------- | ---------- | -------- | ------------ | ---- | ----------- | ------ | --- | --- | --- | --- | --- | --- |
| off between   | latency | and           | the number |          | of messages. |      | If the      |        |     |     |     |     |     |     |
|               |         |               |            |          |              |      | D. Managing | epochs |     |     |     |     |     |     |
| bandwidth     | is good | enough        | and        | the      | number       | of   | pillars     |        |     |     |     |     |     |     |
Inorderforthetransactionstobeconfirmedasfastas
| is reasonable, |     | the traditional |     | broadcast | method | has | the |     |     |     |     |     |     |     |
| -------------- | --- | --------------- | --- | --------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
advantage of having O(1) latency. possible, there are two important factors that need to be
|            |               |                  |           |          |          |       | accounted   | for –   | the proof | of work   | should    | be        | completed  |        |
| ---------- | ------------- | ---------------- | --------- | -------- | -------- | ----- | ----------- | ------- | --------- | --------- | --------- | --------- | ---------- | ------ |
| A scalable |               | type of          | broadcast | can      | be made, | for   | ex-         |         |           |           |           |           |            |        |
|            |               |                  |           |          |          |       | in a decent | time    | frame,    | according | to        | a desired | difficulty |        |
| ample,     | by sending    | the              | broadcast | in       | rounds   | - the | user        |         |           |           |           |           |            |        |
|            |               |                  |           |          |          |       | for an      | epoch   | and the   | messages  | should    |           | have       | a high |
| will send  | a transaction |                  | to log(K) | pillars, | then     | they  | will        |         |           |           |           |           |            |        |
|            |               |                  |           |          |          |       | delivery    | success | rate. The | second    | condition |           | is harder  | to     |
| further    | transmit      | the information, |           | each     | of them  | to    | other       |         |           |           |           |           |            |        |
log(K) pillars and so on. accomplish, but in general, we can safely assume that
|            |                  |            |          |         |          |           | a negligible | amount       | of          | messages  | will     | be                 | lost      | due to |
| ---------- | ---------------- | ---------- | -------- | ------- | -------- | --------- | ------------ | ------------ | ----------- | --------- | -------- | ------------------ | --------- | ------ |
| The number |                  | of the     | messages | will    | be       | much      | lower,       |              |             |           |          |                    |           |        |
|            |                  |            |          |         |          |           | network      | connectivity | issues.     | Regarding |          | the                | the proof | of     |
| O(log K),  | but              | there will | be some  | latency | involved |           | - for        |              |             |           |          |                    |           |        |
|            |                  |            |          |         | O        | logK      | work, in     | order        | to maintain | an        | adequate | time               | frame     | we     |
| example,   | in [58]          | they have  | a        | latency | of       |           | .            |              |             |           |          |                    |           |        |
|            |                  |            |          |         |          | log(logK) | employ       | a difficulty | mechanism   |           | and      | an incentivization |           |        |
| B. Finding | a representative |            |          |         |          |           |              |              |             |           |          |                    |           |        |
|            |                  |            |          |         |          |           | scheme       | that was     | described   | earlier.  |          |                    |           |        |
The problem of finding a representative is important Thus, if non-competitive pillars that are overrun dur-
because there can be some attacks, like the eclipse ing an epoch by a supermajority of pillars will not
17

receive rewards for their work. This competition will ASIC-friendly hashing algorithm will be activated, and
ensurethattheepochswillhavesimilarperiodsandthat also if the difficulty is above a threshold, an ASIC-
transactionsareapprovedasfastaspossibleandincluded resistant will come into effect.
in the ledger. Also, after receiving ζ messages from the Thetimeofoneepochisresponsiblefortheminimum
network,anhonestpillarmustabandonitsproofofwork time after a transaction is confirmed – a transaction is
and automatically enter into the next epoch. If there is confirmedafterthreeorfourepochs,inthebestcase,so
not clear which are the winner nodes, each pillar will foraoneminuteepochitwillleastatleastthreeminutes
compute the faster winner, then the runner-up and so in order for the transaction to be confirmed.
on. Even if a pillar tries to cheat by saying it belongs to If we note with ∆t the difference between the times-
i
thelistandsendsitsproofofworklater,theotherhonest tamps for two consecutive finishing PoW transactions,
| pillars will | know     | that   | the faulty | pillar   | tried | to mislead, | the | mean | time will | be  |     |     |     |     |
| ------------ | -------- | ------ | ---------- | -------- | ----- | ----------- | --- | ---- | --------- | --- | --- | --- | --- | --- |
| as they      | will see | in the | ledger     | that the | other | ones have   |     |      |           |     |     |     |     |     |
| received     | its PoW  | later. |            |          |       |             |     |      | (cid:80)n |     |     |     |     |     |
δt i
Justfortheoreticalreasons,ifthereisanattackerwho Avg = i= 1 , ∆t ∈/ outliers
|             |           |             |         |        |             |              |     |                        |         | n       | i          |       |          |         |
| ----------- | --------- | ----------- | ------- | ------ | ----------- | ------------ | --- | ---------------------- | ------- | ------- | ---------- | ----- | -------- | ------- |
| can control | the       | internet    | traffic | and    | messages    | between      |     |                        |         |         |            |       |          |         |
|             |           |             |         |        |             |              | F.  | Replacing              | regular | quorums | with       | proof | of stake |         |
| pillars, we | have      | introduced  | a       | shared | coin epoch: | if there     |     |                        |         |         |            |       |          |         |
|             |           |             |         |        |             |              |     | The consensusTtimeline |         |         | is divided | into  | virtual  | epochs. |
| are more    | than four | consecutive |         | epochs | that        | don’t end up |     |                        |         |         |            |       |          |         |
with a conclusion (i.e. either it is a tie or the majority In a centralized, non-malicious environment classical
criteria isn’t met), all honest pillars will vote randomly. distributed consensus algorithms use a quorum for the
|           |     |          |      |           |      |         | voting | process: | every | node | has an | equally | 1, N | being |
| --------- | --- | -------- | ---- | --------- | ---- | ------- | ------ | -------- | ----- | ---- | ------ | ------- | ---- | ----- |
| This way, | the | attacker | will | have only | half | chances | to     |          |       |      |        |         |      |       |
N
guess what is the decision of honest pillars, and after a the totFal number of nodes. In our case, a decentralized,
number of epochs the probability of reaching consensus byzantine environment this approach is vulnerable to
will be 1. However, this technique is implemented only sybilattackswhereamaliciousentitycangainanunfair
for theoretical completeness, in a real-world system the advantageandmanipulatethevotingprocess.That’swhy
A
|             |     |        |       |                   |     |     | nodes | can | lock | a certain | amount | of stake | in order | to  |
| ----------- | --- | ------ | ----- | ----------------- | --- | --- | ----- | --- | ---- | --------- | ------ | -------- | -------- | --- |
| probability | for | a coin | round | is insignificant. |     |     |       |     |      |           |        |          |          |     |
The expected time to finish is O(1), given this round, obtain different roles in the network, e.g. to become
and the probability of finishing is sentinel and pillar nodes. At the start of each epoch, all
|     |     |     |          |     |                                                     |     | nodes | determine |          | the stake | weight | of all the | nodes | in the |
| --- | --- | --- | -------- | --- | --------------------------------------------------- | --- | ----- | --------- | -------- | --------- | ------ | ---------- | ----- | ------ |
|     |     |     |          | ∞ 1 |                                                     |     |       |           |          |           |        |            |       |        |
|     |     |     | (cid:89) |     | Rnetwork.Inthecaseofpillarnodes,networkparticipants |     |       |           |          |           |        |            |       |        |
|     |     | P   | =1−      | =1  |                                                     |     |       |           |          |           |        |            |       |        |
|     |     |     |          | 2   |                                                     |     | can   | directly  | delegate | stake.    |        |            |       |        |
r=1
|           |     |         |        |     |           |          |     | The virtual | voting | process | is determined |     | on the | basis |
| --------- | --- | ------- | ------ | --- | --------- | -------- | --- | ----------- | ------ | ------- | ------------- | --- | ------ | ----- |
| Regarding | the | minimum | number |     | of epochs | ν needed |     |             |        |         |               |     |        |       |
ofthetotalstakeduringavirtualepoch.Pillarnodeswith
for a transaction in order to be included in the ledger, stakemakethedecisionswithintheconsensusalgorithm
| we have      | the following |            | eqDuation: |              |            |            |                                                  |           |               |               |           |               |            |         |
| ------------ | ------------- | ---------- | ---------- | ------------ | ---------- | ---------- | ------------------------------------------------ | --------- | ------------- | ------------- | --------- | ------------- | ---------- | ------- |
|              |               |            |            |              |            |            | to                                               | finalize  | transactions. | Nodes         |           | can freely    | unlock     | the     |
|              |               |            |            |              |            |            | stake                                            | at any    | moment;       | however,      | consensus |               | nodes      | have to |
|              |               |            | 3<=ν       | <∞           |            |            |                                                  |           |               |               |           |               |            |         |
|              |               |            |            |              |            |            | wait                                             | for a     | period        | of time known |           | as ”unstaking | period”.   |         |
| .            |               |            |            |              |            |            | Upondecidingtransactionsduringthenextepoch,nodes |           |               |               |           |               |            |         |
|              |               |            |            |              |            |            | process                                          | all       | transactions  | relating      |           | to locking,   | delegating |         |
| E. Adjusting | the           | difficulty | of         | PoW          |            |            |                                                  |           |               |               |           |               |            |         |
|              |               |            |            |              |            |            | and                                              | unlocking | stake,        | and update    |           | the staking   | stats      | of the  |
| As we        | have          | previously | stated,    | the          | idea       | behind the | nodes                                            | for       | the next      | epoch.        |           |               |            |         |
| proof of     | work          | mechanism  |            | has multiple | advantages |            | –                                                |           |               |               |           |               |            |         |
|              |               |            |            |              |            |            |                                                  | These     | mechanisms    | aim           | to keep   | a healthy     | system,    | by      |
prevents ledger cloning, acts as an additional anti-sybil involving all network participants to collaborate towards
| layer and | provides | a             | fair incentivization |           | scheme   | for the   | a   | common | good.                    |     |     |     |     |     |
| --------- | -------- | ------------- | -------------------- | --------- | -------- | --------- | --- | ------ | ------------------------ | --- | --- | --- | --- | --- |
| consensus | nodes.   | The           | PoW                  | will be   | adjusted | in order  | to  |        |                          |     |     |     |     |     |
|           |          |               |                      |           |          |           |     | VIII.  | CONCLUSIONSANDFUTUREWORK |     |     |     |     |     |
| keep an   | epoch    | at a constant |                      | time, for | example  | 1 minute. |     |        |                          |     |     |     |     |     |
Thealgorithmwillcheckateveryepochthetimeneeded This work presents a new decentralized system
for every pillar to solve the proof of work, will remove architecture, namely a new decentralized ledger that
the outliers and then will compute a median time. We employs a virtual voting-based consensus. We first
plan to release a self-balancing difficulty algorithm that presented the most important works regarding ledger
will use both ASIC-friendly and ASIC-resistant hashing types, consensus algorithms, and smart contracts. We
algorithms; if the difficulty is below a threshold an continued by making some definitions and assumptions,
18

statingsomepropertiesandtheorems,thenwedescribed
|          |           |              |       |             |          | [17] Y.    | Sompolinsky, | Y.       | Lewenberg, | and            | A. Zohar,  | Spectre: |
| -------- | --------- | ------------ | ----- | ----------- | -------- | ---------- | ------------ | -------- | ---------- | -------------- | ---------- | -------- |
|          |           |              |       |             |          | A          | fast and     | scalable |            | cryptocurrency | protocol,  | IACR     |
| the core | of the    | architecture | - the | dual ledger | system   |            |              |          |            |                |            |          |
|          |           |              |       |             |          | Cryptology |              | ePrint   | Archive,   | Report         | 2016/1159, | 2016,    |
| and the  | consensus | algorithm.   |       | We analyzed | frequent |            |              |          |            |                |            |          |
https://eprint.iacr.org/2016/1159/
| attack scenarios, |     | the complexity |     | and how | to choose |         |         |        |               |     |               |          |
| ----------------- | --- | -------------- | --- | ------- | --------- | ------- | ------- | ------ | ------------- | --- | ------------- | -------- |
|                   |     |                |     |         |           | [18] A. | Kiayias | and G. | Panagiotakos, | On  | trees, chains | and fast |
different protocol parameters for optimal performance. transactionsintheblockchain,IACRCryptologyePrintArchive,
Report2016/545,2016,https://eprint.iacr.org/2016/545/
| The Network | of  | Momentum | has | a continuous | cycle |                |     |          |        |            |             |          |
| ----------- | --- | -------- | --- | ------------ | ----- | -------------- | --- | -------- | ------ | ---------- | ----------- | -------- |
|             |     |          |     |              |       | [19] J. Garay, | A.  | Kiayias, | and N. | Leonardos, | The bitcoin | backbone |
of research and is still under active research; as a protocol: Analysis and applications, in Advances in Cryptology
result, some parts will require further clarification or -EUROCRYPT2015:34thAnnualInternationalConferenceon
revision. We also plan to release a technical yellow the Theory and Applications of Cryptographic Techniques, Part
II,Sofia,Bulgaria,Apr.2015,pp.281–310.
paper dedicated to a detailed presentation of the zApps [20] I.EyalandE.G.Sirer,Majorityisnotenough:Bitcoinmining
component and other improvements. isvulnerable,inFinancialCryptographyandDataSecurity:18th
|     |     |     |     |     |     | International |     | Conference, | Christ | Church, | Barbados, | Mar. 2014, |
| --- | --- | --- | --- | --- | --- | ------------- | --- | ----------- | ------ | ------- | --------- | ---------- |
pp.436–454.
|         |          |                |     |                 |         | [21] Nick                  | Szabo.   | Formalizing | and         | securing | relationships | on public      |
| ------- | -------- | -------------- | --- | --------------- | ------- | -------------------------- | -------- | ----------- | ----------- | -------- | ------------- | -------------- |
|         |          | ACKNOWLEDGMENT |     |                 |         | networks.FirstMonday.1997. |          |             |             |          |               |                |
|         |          |                |     |                 |         | [22] Bruno                 | Bernardo | et al.      | Mi-Cho-Coq, | a        | framework     | for certifying |
| We want | to thank | Professor      | Z   | for his support | and for |                            |          |             |             |          |               |                |
TezosSmartContracts.arxiv:1909.08671[Online].2019
the continuous research and development program. [23] S.Popov,Thetangle,cit.on,p.131,2016.
|     |     |     |     |     |     | [24] Cardano |     | TPlatform. |     | [Online] |     | Available: |
| --- | --- | --- | --- | --- | --- | ------------ | --- | ---------- | --- | -------- | --- | ---------- |
https://www.cardanohub.org/en/home/
|     |     |     |     |     |     | [25] A. | Churyumov, | Byteball: |     | A decentralized |     | system for |
| --- | --- | --- | --- | --- | --- | ------- | ---------- | --------- | --- | --------------- | --- | ---------- |
REFERENCES storage and transfer of value. [Online]. Available:
https://byteball.org/Byteball.pdf.2016
[1] S. Nakamoto. Bitcoin: A Peer-to-Peer Electronic Cash System. [26] A.FBrock et al. Holo Green Paper. [Online]. Available:
[Online].Available:https://bitcoin.org/bitcoin.pdf.2008 https://files.holo.host/2018/03/Holo-Green-Paper.pdf.2018
[2] Ethereum Foundation, Ethereum wire protocol. [Online]. [27] Colin LeMahieu. 2018. Nano: A Feeless Dis-
Available: https://github.com/ethereum/wiki/wiki/Ethereum- tributed Cryptocurrency Network. [Online]. Available:
| Wire-Protocol |     |     |     |     |     | https://nano.org/en/whitepaper/ |     |     |     |     |     |     |
| ------------- | --- | --- | --- | --- | --- | ------------------------------- | --- | --- | --- | --- | --- | --- |
[3] Juels, Ari; Brainard, John. Client puzzles: A cryptographicAde- [28] M. Castro, B. Liskov. Practical Byzantine Fault Tolerance. 3rd
| fenseagainstconnectiondepletionattacks.NDSS.1999. |     |     |     |     |     | OSDI.1999. |     |     |     |     |     |     |
| ------------------------------------------------- | --- | --- | --- | --- | --- | ---------- | --- | --- | --- | --- | --- | --- |
[4] King, S., Nadal, S.: Ppcoin: Peer-to-peer crypto-currency with [29] The Ziliqa Team. The ziliqa technical whitepaper. [Online].
proof-of-stake(2012) Available:https://docs.zilliqa.com/whitepaper.pdf.2017
[5] Moser,L.E.andMelliar-Smith.Byzantine-resistanttotalorder- [30] Y.SompolinskyandA.Zohar.Securehigh-ratetransactionpro-
ingalgorithms.InformationandComputation.1999 cessing in bitcoin. Financial Cryptography and Data Security,
| [6] J.R.Douceur,Thesybilattack,inPeer-to-RPeerSystems,P.Dr- |     |     |     |     |     | 2015. |     |     |     |     |     |     |
| ----------------------------------------------------------- | --- | --- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- |
uschel,F.Kaashoek,andA.Rowstron,Eds.Berlin,Heidelberg: [31] Kiayias,A.,Russell,A.,David,B.,andOliynykov,R. Ouroboros: A
SpringerBerlinHeidelberg,2002,pp.251–260. provably secure proof-of-stake blockchain protocol. Annual In-
[7] TheByzantineGeneralsProblem,LESLIELAMPORT,ROBERT ternationalCryptologyConferencepp.357-388.August,2017.
SHOSTAK,andMARSHALLPEASE.SRIInternational.
|     |     |     |     |     |     | [32] Steemit |     | article. |     | [Online]. |     | Available: |
| --- | --- | --- | --- | --- | --- | ------------ | --- | -------- | --- | --------- | --- | ---------- |
[8] Dr.LeemonBaird,ManceHarmon,andPaulMadsen.[Online]. https://steemit.com/dpos/@dantheman/dpos-consensus-
Available:https://www.hedDera.com.2019 algorithm-this-missing-white-paper/
[9] Pierre Chevalier, Bart lomiej Kami´nski, Fraser Hutchi- [33] NXT Whitepaper. [Online]. Available:
son, Qi Ma, and Spandan Sharma. Protocol for asyn- www.nxtdocs.jelurida.com/Nxt Whitepaper
chronous, reliable, secure and efficient consensus (PAR- [34] A. Miller, A. Kosba, J. Katz, and E. Shi, Nonoutsourceable
SEC). [Online]. Available: http://docs.maidsafe.net/ Whitepa- scratch-off puzzles to discourage bitcoin mining coalitions, in
pers/pdf/PARSEC.pdf,Jun2018. Proceedingsofthe22ndACMSIGSACConferenceonComputer
[10] Team Rocket, Snowflake to Avalanche: A Novel Metastable andCommunicationsSecurity,ser.CCS’15.Denver,CO:ACM,
| ConsensusProtocolFamilyforCryptocurrencies,2018.[Online]. |     |     |     |     |     | Oct.2015,pp.680–691. |     |     |     |     |     |     |
| --------------------------------------------------------- | --- | --- | --- | --- | --- | -------------------- | --- | --- | --- | --- | --- | --- |
Available: https://ipfs.io/ipfs/QmUy4jh5mGNZvLkjies1RW- [35] Aleph: Efficient Atomic Broadcast in Asynchronous
M4YuvJh5o2FYopNPVYwrRVGV Networks with Byzantine Nodes. [Online]. Available:
[11] Driscoll,K.;Hall,B.;Paulitsch,M.;Zumsteg,P.;Sivencrona,H. https://arxiv.org/pdf/1908.05156.pdf
TheRealByzantineGenerals.The23rdDigitalAvionicsSystems [36] S. Nakamoto. Bitcoin Talk Forum. [Online]. Available:
Conference.2004 https://bitcointalk.org/index.php?topic=195.msg1611
[12] Lamportetal.L.Lamport,R.Shostak,M.Pease.TheByzantine [37] TamasBlummeretal.AnintroductiontoHyperledger.[Online].
generalsproblem.ACMTrans.onProgramming.1982 Available:AnIntroductiontoHyperledger.2018.
[13] L.Lamport.Thepart-timeparliament.ACMTOCS16,2(1998), [38] Chain whitepaper. [Online]. Available:
| 133–169. |     |     |     |     |     | https://crypto.com/images/chain |     |     |     | whitepaper.pdf.2019 |     |     |
| -------- | --- | --- | --- | --- | --- | ------------------------------- | --- | --- | --- | ------------------- | --- | --- |
[14] Dwork,CynthiaandNaor,Moni.Pricingviaprocessingorcom- [39] Decred (DCR) – Whitepaper. [Online]. Available:
batting junk mail Annual International Cryptology Conference. https://decred.org/research/buterin2014.pdf.2014
1992 [40] NEM - Whitepaper. [Online]. Available: https://nem.io/wp-
[15] J. Kwon, Tendermint: Consensus without mining (draft), content/themes/nem/files/NEM techRef.pdf.2018
Self-published Paper, fall 2014. [Online]. Available: [41] EOSPlatform.[Online]Available:https://eos.io/
https://tendermint.com/static/docs/tendermint.pdf/ [42] TezosPlatform.[Online]Available:https://tezos.com/
[16] Filecoin:Adecentralizedstoragenetwork,ProtocolLabs. [43] NEOPlatform.[Online]Available:https://neo.org/
19

| [44] Lisk | Whitepaper. | [Online] | Available: |     | https://github.com/ |     |
| --------- | ----------- | -------- | ---------- | --- | ------------------- | --- |
slasheks/lisk-whitepaper/blob/development/LiskWhitepaper.md
| [45] Verifiable | Delay | Functions. | Dan | Boneh,          | Joseph | Bonneau,   |
| --------------- | ----- | ---------- | --- | --------------- | ------ | ---------- |
| Benedikt        | Bunz, | and        | Ben | Fisch. [Online] |        | Available: |
https://eprint.iacr.org/2018/601.pdf
| [46] Perspectives |     | on the CAP | Theorem. | [Online]. |     | Available: |
| ----------------- | --- | ---------- | -------- | --------- | --- | ---------- |
https://groups.csail.mit.edu/tds/papers/Gilbert/Brewer2.pdf
[47] Peercoindiscussionforum,discussion2524.[Online].Available:
https://talk.peercoin.net/t/the-complete-guide-to-minting/
| [48] Majority-Vote |     | Cellular   | Automata, | Ising    | Dynamics, | and        |
| ------------------ | --- | ---------- | --------- | -------- | --------- | ---------- |
| P-Completeness     |     | Cristopher | Moore.    | [Online] |           | Available: |
https://arxiv.org/pdf/cond-mat/9701118.pdf
| [49] Proof                    | of Stake | versus | Proof of | Work. [Online].             |     | Available: |
| ----------------------------- | -------- | ------ | -------- | --------------------------- | --- | ---------- |
| http://bitfury.com/content/5- |          |        | white-   | papers-research/pos-vs-pow- |     |            |
1.0.2.pdf
| [50] NKN                    | Lab.     | NKN: a        | Scalable            | Self-Evolving |      | and Self-  |
| --------------------------- | -------- | ------------- | ------------------- | ------------- | ---- | ---------- |
| Incentivized                |          | Decentralized | Network.            | [Online].     |      | Available: |
| https://www.nkn.org/doc/NKN |          |               | Whitepaper.pdf.2018 |               |      |            |
| [51] George                 | Danezis, | David         | Hrycyszyn.          | Blockmania:   | from | Block      |
DAGstoConsensus.arXiv:1809.01620.2018
[52] JingChen,SilvioMicali.Alogrand.arxiv:1607.01341v9.2017
[53] Empirically Analyzing Ethereum’s Gas Mechanism. Renlord T
| Yang, | Toby | Murray, Paul | Rimba, | Udaya Parampalli. |     | [Online] |
| ----- | ---- | ------------ | ------ | ----------------- | --- | -------- |
Available:https://arxiv.org/pdf/1905.00553.pdf
| [54] Unikernels: |        | Library Operating | Systems  | for                | the Cloud, | Anil    |
| ---------------- | ------ | ----------------- | -------- | ------------------ | ---------- | ------- |
| Madhavapeddy,    |        | Richard           | Mortier, | Charalampos        |            | Rotsos, |
| David            | Scott, | Balraj Singh,     |          | Thomas Gazagnaire, |            | Steven  |
F
| Smith, | Steven | Hand and | Jon Crowcroft. | [Online] |     | Available: |
| ------ | ------ | -------- | -------------- | -------- | --- | ---------- |
http://mort.io/publications/pdf/asplos13-unikernels.pdf
| [55] Muhamaad |     | Saad et al. | Exploring | the Attack | Surface | of  |
| ------------- | --- | ----------- | --------- | ---------- | ------- | --- |
Blockchain:ASystematicOverview.arxiv:1904.03487.2019
[56] P.Silva.Dnssec:TheantidotetoDNScachepoisoningandoAther
dnsattacks,AF5Networks,Inc.TechnicalBrief.2009.
[57] T.Peng,C.Leckie,andK.Ramamohanarao.Surveyofnetwork-
baseddefensemechanismscounteringtheDoSandDDoSprob-
| lems,. | ACM | Computing | Surveys | (CSUR), vol. | 39, no. | 1, p. 3. |
| ------ | --- | --------- | ------- | ------------ | ------- | -------- |
2007.
| [58] Scalable | Byzantine | Reliable | Broadcast. | RaRchid       | Guerraoui,    | Petr |
| ------------- | --------- | -------- | ---------- | ------------- | ------------- | ---- |
| Kuznetsov,    | Matteo    | Monti,   | Matej      | Pavlovic, and | Dragos-Adrian |      |
Seredinschi
D
20

|     |     |     | APPENDIX |     |     |     |     | Proof of Theorem   | 6                |           |
| --- | --- | --- | -------- | --- | --- | --- | --- | ------------------ | ---------------- | --------- |
|     |     |     |          |     |     |     |     | Proof. Transaction | times processing | will grow |
A. Proof of theorems sublogarithmically with the number of pillar nodes.
| Proof                   | of Theorem      |              | 1                   |                |             |             |           |     |     |     |
| ----------------------- | --------------- | ------------ | ------------------- | -------------- | ----------- | ----------- | --------- | --- | --- | --- |
| Proof. If               | a node          | emits        | a transaction       |                | and         | it is       | received  |     |     |     |
| by its representatives, |                 |              | the representatives |                |             | will        | send the  |     |     |     |
| information             | about           | the          | transaction         |                | to the      | pillars     | that will |     |     |     |
| further                 | broadcast       | it,          | and every           | honest         | pillar      | node        | will      |     |     |     |
| know about              | the             | transaction. |                     | For maximizing |             | the         | chance    |     |     |     |
| of receiving            | the             | transaction, |                     | a node         | will        | have        | not just  |     |     |     |
| one representative,     |                 | but          | a logarithmic       |                | size        | of          | the total |     |     |     |
| number                  | of sentinel     |              | nodes.              | After          | three       | epochs,     | if the    |     |     |     |
| transaction             | is              | not seen     | throughout          |                | the network |             | upon      | a   |     |     |
| request,                | it means        | with         | high                | probability    |             | that the    | initial   |     |     |     |
| transaction             | wasn’t          | received.    |                     | However,       | in          | the absence | of        |     |     |     |
| a DoS,                  | the transaction |              | will                | eventually     |             | be seen     | by the    |     |     |     |
T
entire network.
| Proof          | of Theorem |      | 2       |     |        |       |        |     |     |     |
| -------------- | ---------- | ---- | ------- | --- | ------ | ----- | ------ | --- | --- | --- |
| Proof. Suppose |            | that | we have | a   | double | spend | and we |     |     |     |
F
| also assume      | that       | the       | rest of   | the pillars | are    | malicious     | i.e.     |     |     |     |
| ---------------- | ---------- | --------- | --------- | ----------- | ------ | ------------- | -------- | --- | --- | --- |
| K - ζ. After     | they       | all       | broadcast | them        | and    | all have      | them     |     |     |     |
| both, one        | will       | be chosen |           | based       | on the | rules         | and the  |     |     |     |
| other discarded. |            | If the    | majority  | vote        | for    | transactionAA |          |     |     |     |
| and the          | minority   | instead   | keep      | B,          | a fork | will be       | created, |     |     |     |
| but no double    |            | spend.    |           |             |        |               |          |     |     |     |
| Proof            | of Theorem |           | 3         |             |        |               |          |     |     |     |
R
| Proof. When |                  | pillars | are in | epoch | (cid:15) k , all | of them | have    |     |     |     |
| ----------- | ---------------- | ------- | ------ | ----- | ---------------- | ------- | ------- | --- | --- | --- |
| received    | all transactions |         | from   | epoch | (cid:15)         | . The   | pillars |     |     |     |
k−3
| from the           | majority  | will         | choose     | one      | transaction |            | based on   |     |     |     |
| ------------------ | --------- | ------------ | ---------- | -------- | ----------- | ---------- | ---------- | --- | --- | --- |
| the rules          | and       | the minority |            | will     | choose      | the other, | not        |     |     |     |
| reaching           | the total | number       | D          | of votes | required    | and        | it will    |     |     |     |
| not be integrated. |           | If           | they still | decide   | to accept   |            | it, a fork |     |     |     |
will be created.
| Proof        | of Theorem |             | 4         |              |              |               |          |     |     |     |
| ------------ | ---------- | ----------- | --------- | ------------ | ------------ | ------------- | -------- | --- | --- | --- |
| Proof. After | the        | first       | pillar    | finishes     | the          | proof         | of work  |     |     |     |
| and sends    | it along   | with        | the       | transaction, |              | the rest      | of the   |     |     |     |
| honest       | nodes      | will follow |           | and the      | vote         | count         | for this |     |     |     |
| transaction  | will       | reach       | majority, | so           | it will      | be integrated |          |     |     |     |
| into the     | ledger,    | even        | if the    | minority     | of malicious |               | pillars  |     |     |     |
| will decide  | not        | to relay    | it.       |              |              |               |          |     |     |     |
| Proof        | of Theorem |             | 5         |              |              |               |          |     |     |     |
| Proof. The   | complexity |             | of the    | messages     |              | is M *        | log(K)   |     |     |     |
perroundsowhenanewpillarjoinsthenetwork,itwill
| become     | M * log(K+1). |           | An  | increase | of          | the number | of  |     |     |     |
| ---------- | ------------- | --------- | --- | -------- | ----------- | ---------- | --- | --- | --- | --- |
| pillars is | almost        | unnoticed |     | in the   | complexity. |            |     |     |     |     |
21
