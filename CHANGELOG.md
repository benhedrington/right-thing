# Changelog

Each skill has its own version, set by the `version:` field under `metadata:` in its SKILL.md
frontmatter. Versions stay below 1.0.0 while a skill is still settling. **1.0.0 will mark the first
stable release**, once a skill has been through an independent test pass. Nothing has reached 1.0.0
yet.

## 2026-10-05 — plan-improve 0.5.1 (plainer description)

- `plan-improve`'s description now says "Review an existing PRD and fix it" instead of "Red-pen",
  which is an editor's term many PMs don't use. The description is how Claude decides when to use
  the skill, so it should match how people ask: "review my PRD", "check this draft". It also names
  draft PRDs, in line with the README's which-skill table. No rule changed.

## 2026-10-05 — all skills at 0.5.0 (field test by two simulated PMs)

Two agents played product managers, one at a direct-to-consumer retailer and one on a
subscription mobile app. Each ran five skills on a product idea of their own and reported where
the skills helped and where they got in the way. Every change below answers a finding that quotes
the skill line and the output line it caused (testbench/logs/run-032-field-test.md). These are
rule changes, so the version moves to 0.5.0.

- **Handoffs that went nowhere now land.** `plan-prd` reads learn-retro's handoffs addressed to
  it. `learn-experiment` reads plan-direction's riskiest assumption and plan-prd's outcomes and
  open questions. `launch-read` reads learn-experiment's cards, so a ramp that carries a test
  checks that assignment is logged from the first exposure.
- **The ship threshold is not the MDE.** `learn-experiment` now says a test ships on a
  significant result in the right direction. Demanding an observed effect at least as large as
  the effect the test was sized for ships a real winner only about half the time.
- **Read dates for slow metrics.** For week-4 retention, day-8 trial conversion and similar
  metrics, `learn-experiment` names the earliest read date (enrollment plus the metric's window),
  and `plan-prd`'s timeframe says when the metric can first be read.
- **Counter-metrics.** `plan-prd` names at least one metric the change could hurt, such as margin
  per order or notification opt-outs, with a must-not-cross bar. `launch-read` audits it.
  `learn-experiment` says whether its sample can detect each guardrail, and calls one it cannot
  a tripwire.
- **One reading of "named source".** A number relayed in the input with a checkable source
  ("2,100 a month, per the support dashboard") is evidence. The old sentence could be read either
  way, and the stricter reading sent a PRD to a discovery note.
- **Triage and PRD agree.** `plan-prd` now states how it reads a `to-plan (pending pull)`
  cluster, which `learn-triage` already promised. `learn-triage` asks how the dump was selected
  (a keyword search is not a sample), adds a 5-reporter floor to its flagged routes, and says
  what to do when some verifying data exists and some does not.
- **App and store releases.** `plan-prd`'s rollout and `learn-experiment`'s method cover the
  release train per platform, store review, minimum app version, and what needs a new binary
  versus a flag change. `learn-retro` adds unscored sub-rows when platforms move in opposite
  directions, and scores against a holdout's lift when there is one.
- **Smaller fixes.** `plan-direction`'s tie-break no longer favours a hard-to-reverse option.
  `plan-split` lets internal operators such as support agents own an epic, and sizes QA as well
  as engineering. `launch-read` gives the next ship window in a no-go, says what counts as a
  security boundary, and judges risk content in any form rather than demanding a formal register.
  `plan-improve` has a 14th class (missing-rollout), records contradictory goals, lists clean
  classes instead of stretching a quote to fill them, and surfaces "exposed" nits in the header
  without changing the severity rule. Every skill's closing message now offers the shareable
  version.
- **Found by the confirmation run** (fresh agents on the same inputs, plus two earlier test
  briefs; testbench/logs/run-033-confirm.md). `learn-experiment` now gives the sample-size formula
  for unequal arms (a 25/75 ramp), computes runtime from the sum of the arms' sizes (the old
  "arms x n" was wrong for unequal arms), and gives a sample-ratio check that works for any
  planned split. Its worked example now rounds up as the formula says: 25,552 per group, not
  25,551. When plan-improve's rewrite is the newer PRD, launch-read, learn-retro and
  learn-experiment read it instead of plan-prd's, and each of the two PRD skills names the
  document it supersedes. `launch-read` fails check 1 when a ramp's experiment card is missing,
  won't let an open question be re-dated while a default answer ships live, and asks for support
  to be briefed before a large flagged ramp opens. `plan-improve` says plainly that a date the
  PRD's own durations cannot meet is a must-fix.

## 2026-09-29 — all skills at 0.4.0 (first public release)

This release changes rules, not only wording, so the version moves from 0.3 to 0.4. All eight
skills and the README now state the same version, 0.4.0.

- **Shorter, plainer skills.** The instructions every skill shares (save the output to a file, open
  it with the decision header, move long detail to an appendix, recompute every derived number) are
  now stated once per skill instead of up to three times, and the overflow rule takes two sentences
  where it took nine. Wording that read like a patch for one past mistake has been rewritten as a
  plain rule. No shared rule was dropped.
- **A path for thin data.** When the organization simply does not have a second data source, a
  dashboard or clean instrumentation — not when nobody looked — three skills now give a usable
  answer instead of stopping. `plan-prd` writes a narrowed PRD that opens by naming the thin
  evidence. `learn-triage` can route a severe, widely reported problem to planning with a
  "provisional" flag. `launch-read` can return go-with-conditions when the main metric can be read
  on day one by a named stopgap method. Each path says what is missing and what would settle it,
  with an owner and a date. Where the data exists but was not checked, the old rule still applies.
- **Experiment arithmetic.** `learn-experiment` now gives the standard sample-size formula for
  comparing two rates, states its assumptions, and shows a worked example: a 4% baseline and a
  0.5-point lift, at the usual 5% significance and 80% power, need 25,551 users per group. It tells
  the agent to compute the number with a short script when it can, and to show every step.
- **Tests without random assignment.** `learn-experiment` has a new branch for fake-door,
  concierge and five-user usability tests, with its own pass/fail threshold and a plain list of what
  such a test can and cannot show. "Don't run the test" is no longer the only answer at low volume.
- **A refusal is still a deliverable.** Every skill now writes its file under the same decision
  header when its answer is "stop", "not ready", "don't run" or "not enough evidence". When you
  explicitly ask a quick question, the reply may be just the decision header, but the file is still
  written.
- **Clearer thresholds.** `launch-read` now says when conditions add up to a no-go: one or two
  ordinary failed checks are conditions, three or more make the verdict no-go. `plan-direction` now
  says that a few points' difference in its weighted scores is noise, and that the recommendation
  rests on the evidence, not the total alone.
- **A short example in every skill.** `launch-read`, `learn-triage`, `learn-retro` and `plan-split`
  gained one, and the example in `plan-direction` now uses concrete numbers and dates instead of
  placeholders.
- **Launch tiers and a kill switch.** `launch-read` first names the launch tier (a flagged ramp to
  a small share of users, a beta, or general availability), and the tier decides which checks apply
  in full. A feature-flag kill switch now counts as a rollback plan, once it has been tested. Widening a ramp to
  everyone is a new audit.
- **Sturdier experiments.** `learn-experiment` checks for a sample-ratio mismatch (the groups came
  out a different size than planned) before any result is read, gives guidance for tests with more
  than one variant and for average metrics such as revenue per user, and runs every test for whole
  weeks so weekday and weekend fall evenly in each group.
- **One rule for owners, in all eight skills.** Every owner is a role or a person you named; the
  skills never guess a name, and an owner they cannot know is marked "unnamed — must be named".
- **More of the loop is automatic.** `plan-prd` now reads the chosen direction from
  `plan-direction` and ship results from `learn-experiment`; `learn-retro` reads the experiment's
  decision rules and guardrails; `learn-triage` reads the questions `launch-read` predicted
  customers would ask.
- **A shareable version.** Ask for one and you get the same document without the working ledger
  and appendices, sources kept as footnotes, still opening with the decision header.
- **A fuller PRD review.** `plan-improve` now checks every PRD against 13 kinds of defect, including
  missing non-functional requirements.
- **A default weight scale for triage.** `learn-triage` weights clusters on a stated default scale
  unless an earlier run's scale or yours applies, so weights compare across runs.
- **A fuller PRD.** `plan-prd`'s PRD now names its target users, lists non-functional requirements
  (security, privacy, accessibility, performance) and says how the build rolls out.
- **A glossary in the README** for the terms the skills rely on: fragment, evidence, assumption,
  unknown, named data pull, decision clock, kill criteria, ITT and per-protocol.

- **A verdict between perfect and needs-revision.** `plan-improve` now separates a defect where two
  competent engineers would build different things (must-fix) from a term or a wording that a
  practitioner reads the same way (a nit or an open question), groups repeated instances of one root
  cause into a single record, and adds **build-ready-with-fixes** for a PRD whose fixes are local —
  each one fixable without rethinking the problem, the users or the scope. The header carries the few
  must-fixes that matter and the rest move to an appendix. On a deliberately strong PRD this took the
  count from 25 must-fixes to 9, and the output from 4,300 words to 3,200.
- **A route that says "plan this, pending a one-day pull".** `learn-triage` adds
  **to-plan (pending pull)** for a severe, widely reported problem whose verifying data exists but
  was never checked. The named data pull, its owner and its date stay the gate, exactly as for the
  provisional route; only the label a reader sees changed. The rules also now say plainly whether one
  account repeating itself counts toward a cluster's weight, so a loud account cannot inflate it.
- **Files find each other predictably.** Every skill now says which upstream file it uses (the most
  recent one matching the topic, named in the output, asking if two plausibly match), never
  overwrites an earlier run (the date goes in the filename, or a `-2` suffix with a note), and writes
  to the working directory unless the user or the harness names another.
- **Smaller fixes.** `plan-direction`'s ten-point tiebreak now reads as a consideration rather than a
  rule, next to the sentence saying a few points' difference is noise. `plan-split` accepts the
  team's own story format — points, or "As a…" stories — as long as the acceptance criteria and the
  dependency edges stay. `learn-experiment` says the minimum detectable effect is set from the
  business case before volume is known and is never back-solved from the sample at hand, and says
  what to do when there is no shell: name it as a data pull for an analyst, with the inputs it needs.

## Before the first public release

The revisions below were made before anything was published. They are kept as a record. Where a
later entry changes a rule, the later entry wins.

### 2026-09-27 — artifact made non-optional, exact header spelling

The artifact became non-optional, and the format contract became exact. Three changes, all of them
found by running the skills on realistic requests rather than by reading them:

- **Output is a file, always.** It is now the first line of every skill body. Sent a request phrased
  as a question, four of five runs invoked the right skill, reasoned well, and returned a chat reply
  with no artifact — the rule existed but sat far enough down that the conversational reading won.
  The skill now states that the file is the deliverable, that a chat summary never replaces it, and
  that its absence is an incomplete run. Verified: eleven runs across consumer web and mobile, all
  eleven produced the artifact.
- **The decision header has an exact spelling.** `## Decision header`, with **Verdict:**,
  **Confidence:** and **Top 3 actions**. Observed drift (`## Decision` in one artifact) is invisible
  in a single run and fatal to a stable format, so it is now prescribed verbatim.
- **Artifacts never go in the inputs directory.** One run saved its memo into `bundle/` alongside the
  files it was given; the skills now say where the file goes.

Also in this revision: **length is a judgement, not a line count** — the hard 120-word header cap and
the strict ~1,500-word body limit are retired, with padding and dropped substance as the failures
instead of a number (the cap was in direct conflict with the provenance lines the headers also
require). And the skills now name the exact path in their closing message.

### 2026-09-27 — length is a judgement, not a line count

Length stopped being a line count. The hard 120-word cap on the decision header is retired, along
with the strict ~1,500-word body limit: the header now runs as long as the verdict, its confidence
and the top actions need, and the body as long as the work needs, with padding and dropped substance
as the failures instead of a number. The overflow rule is unchanged — supporting detail moves to an
appendix, material is relocated and never dropped.

Why: the cap and the provenance lines the headers also require were in direct conflict, which is what
pushed headers over in testing. A rule an agent has to break to do the other half of its instruction
is a defect in the rule, not in the prose.

Scope: prose only. No output format, install path or file layout changed.

### 2026-09-27 — credits frontmatter as a single string

Only the frontmatter changes. No skill's instructions
change, so this is not a behavioural change.

- **Credits.** `inspired-by:` under `metadata:` is now a single quoted string, not a YAML list.
  When a skill credits more than one source, the credits are joined with "; " inside that string.
  There were two problems with the list. First, the ` :: ` inside each credit line made YAML read
  the line as a one-key map rather than as text, so the credit came out garbled when read back.
  Second, the Agent Skills spec types every `metadata` value as a string. The wording of each
  credit is unchanged.

### 2026-09-27 — frontmatter follows the Agent Skills spec

Only the frontmatter changes. No skill's instructions
change, so this is not a behavioural change.

- **Frontmatter.** `version:` and `inspired-by:` now sit under a `metadata:` map, so each
  SKILL.md follows the Agent Skills spec. The spec allows only `name`, `description`, `license`,
  `compatibility`, `allowed-tools` and `metadata` at the top level, and some platforms reject a
  skill that has other keys there. `name` and `description` stay at the top level. Credit lines
  and their wording are unchanged.

### 2026-09-27 — overflow and derived-number rules

Two rules are added to each skill's output section, and one
credit line is corrected.

- **Budget and overflow.** The decision header stays at or under 120 words. Before it would go
  over, each action is shortened to a single clause and side notes move to the body. The body
  (everything after the header, not counting appendices) stays under about 1,500 words unless
  the user asks for more depth. If it would run longer, the extra material moves to an appendix
  at the end and the body stays inside the budget. Required sections are still completed, never
  cut to fit, and nothing is padded. A long section keeps its conclusion in the body and moves
  its supporting detail to the appendix. Material is moved, not dropped.
- **Derived numbers.** Any figure computed from the input (a count, sum, share, percentage,
  delta or rate) is recomputed once from its source before it is published, with the arithmetic
  shown beside it (numerator and denominator, or the formula). A claim that rests on the figure,
  such as "meets the target", says no more than the arithmetic shows. Stating a real calculation
  wrongly is a different mistake from inventing data, and both are forbidden.
- **Credits.** launch-read, learn-retro, learn-experiment and learn-triage credit an earlier
  skill in this set. Those `inspired-by:` lines now use the project's current name
  (`right-thing :: <skill>`). Third-party credits are unchanged.

### 2026-09-27 — shared structure for all eight skills

What this revision adds to every skill:

- An **Inputs** section: what the skill needs, how many questions it may ask before it proceeds,
  what the agent may fetch for itself, and when fetched data counts as evidence (only with a
  cited path or query).
- A **decision header** as the first output element. It is at most 120 words: verdict,
  confidence, and the top three actions with owners.
- A soft length cap of about 1,500 words unless the user asks for more depth. Required
  sections are never cut to fit.
- **Persistence**: output is saved to a file, and each skill looks for upstream outputs so the
  skills chain.
- Examples that are generic and shorter, plus `inspired-by:` credits trimmed to sources that
  were actually read.

Earlier internal versions were not published. 0.4.0 is the first public release.
