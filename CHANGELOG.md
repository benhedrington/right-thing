# Changelog

Each skill has its own version, set by the `version:` field under `metadata:` in its SKILL.md
frontmatter. Versions stay below 1.0.0 while a skill is still settling. **1.0.0 will mark the first
stable release**, once a skill has been through an independent test pass. Nothing has reached 1.0.0
yet.

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
- **A glossary in the README** for the terms the skills rely on: fragment, evidence, assumption,
  unknown, named data pull, decision clock, kill criteria, ITT and per-protocol.

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
require). And the plays now name the exact path in their closing message.

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
  plays chain.
- Examples that are generic and shorter, plus `inspired-by:` credits trimmed to sources that
  were actually read.

Earlier internal versions were not published. 0.4.0 is the first public release.
