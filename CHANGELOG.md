# Changelog

## 2026-09-27 — all skills at 0.3.4 (first public release)

Length stopped being a line count. The hard 120-word cap on the decision header is retired, along
with the strict ~1,500-word body limit: the header now runs as long as the verdict, its confidence
and the top actions need, and the body as long as the work needs, with padding and dropped substance
as the failures instead of a number. The overflow rule is unchanged — supporting detail moves to an
appendix, material is relocated and never dropped.

Why: the cap and the provenance lines the headers also require were in direct conflict, which is what
pushed headers over in testing. A rule an agent has to break to do the other half of its instruction
is a defect in the rule, not in the prose.

Scope: prose only. No output format, install path or file layout changed, so the install verification
on the 0.3.3 text still holds; 0.3.4 is the version the next test pass exercises.

Each skill has its own version, set by the `version:` field under `metadata:` in its SKILL.md
frontmatter.
Versions stay below 1.0.0 while a skill is still settling. **1.0.0 will mark the first stable
release**, once a skill has been through an independent test pass. Nothing has reached 1.0.0 yet.

## 2026-09-27 — all skills at 0.3.3

Every skill moves from 0.3.2 to 0.3.3. Only the frontmatter changes. No skill's instructions
change, so this is not a behavioural change.

- **Credits.** `inspired-by:` under `metadata:` is now a single quoted string, not a YAML list.
  When a skill credits more than one source, the credits are joined with "; " inside that string.
  There were two problems with the list. First, the ` :: ` inside each credit line made YAML read
  the line as a one-key map rather than as text, so the credit came out garbled when read back.
  Second, the Agent Skills spec types every `metadata` value as a string. The wording of each
  credit is unchanged.

## 2026-09-27 — all skills at 0.3.2

Every skill moves from 0.3.1 to 0.3.2. Only the frontmatter changes. No skill's instructions
change, so this is not a behavioural change.

- **Frontmatter.** `version:` and `inspired-by:` now sit under a `metadata:` map, so each
  SKILL.md follows the Agent Skills spec. The spec allows only `name`, `description`, `license`,
  `compatibility`, `allowed-tools` and `metadata` at the top level, and some platforms reject a
  skill that has other keys there. `name` and `description` stay at the top level. Credit lines
  and their wording are unchanged.

## 2026-09-27 — all skills at 0.3.1

Every skill moves from 0.3.0 to 0.3.1. Two rules are added to each skill's output section, and one
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

## 2026-09-27 — all skills at 0.3.0

| Skill | Phase | Version |
|---|---|---|
| plan-direction | Plan | 0.3.0 |
| plan-prd | Plan | 0.3.0 |
| plan-improve | Plan | 0.3.0 |
| plan-split | Plan | 0.3.0 |
| launch-read | Launch | 0.3.0 |
| learn-retro | Learn | 0.3.0 |
| learn-experiment | Learn | 0.3.0 |
| learn-triage | Learn | 0.3.0 |

What 0.3.0 adds to every skill:

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

Earlier versions (0.1.x–0.2.x) were internal and are not published. 0.3.0 to 0.3.2 were not
released publicly either; 0.3.3 is the first public release.
