---
name: learn-experiment
description: "Design a validation experiment: falsifiable hypothesis, decision rule set before data, sample-size arithmetic, guardrails, stop conditions. Use when a belief needs testing before it becomes a build."
metadata:
  version: "0.3.4"
  inspired-by: "right-thing :: plan-direction (kill-criteria discipline -> pre-registration)"
---

# learn-experiment — belief to tested decision

## Inputs

- Required: the belief to test, plus the baseline rate and available volume for the metric it
  claims to move.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch baseline rates, volume counts, and the calendar of concurrent launches and
  campaigns itself. Fetched data counts as evidence only when it carries a cited path or query;
  uncited fetched data is an assumption; data that exists nowhere is a named data pull, never a
  finding.
- Persistence: save the output to `<dir>/learn-experiment-<slug>.md` (`<dir>` = the session's
  working-artifacts directory; ask once if not obvious); before starting, look in `<dir>` for
  learn-triage's to-experiment clusters (`learn-triage-*.md`).

## Stance

An experiment is a decision tool, not a feature demo. The decision rule is written before the data
exists; the arithmetic must be able to detect the effect claimed; and winning is not winning if a
guardrail broke. Write it all down before launch — the experiment card IS the pre-registration;
edits after data starts are logged as revisions.

## Procedure

1. **Hypothesis, falsifiable:** "We believe [change] will move [metric] by [size] because
   [mechanism]." No mechanism, no hypothesis — return to the drawing board.
2. **Decision rule FIRST:** what result ships it, kills it, or iterates — numeric thresholds set
   before any data. A test with no decision rule is a demo with extra steps.
3. **Method:** control vs variant; assignment (randomized? cohort? geo?); exposure definition —
   who is in, when they enter, when they count. State ITT or per-protocol. An ITT denominator
   keeps undelivered and unopened units in the count.
4. **Arithmetic.** Baseline rate, minimum detectable effect, available volume, runtime: the test
   must be ABLE to detect the claimed effect within the window. If the numbers say it cannot,
   redesign — bigger effect, longer window, more volume, or don't run the test. Show the math,
   including the conventions (power, alpha, baseline) — numbers without conventions are not arithmetic.
5. **Guardrails.** Metrics that must not degrade, with thresholds — success on the target metric
   while a guardrail breaks is a kill, not a win. Include the adjacent surfaces the change touches.
6. **Attribution honesty.** What else changes in the window (seasonality, campaigns, other
   launches); how confounds are handled; what would make the read untrustworthy.
7. **Stop conditions.** Early-stop rules and their triggers, dated — anchored to a stated Day 0
   (the first randomized exposure) when no calendar date is given; a peek without a pre-set stop
   rule is an unregistered test.

## Output format — the experiment card

Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (run, redesign, or don't run —
can the arithmetic detect the claimed effect?); confidence (high/medium/low) with its basis; the
top 3 actions, each with an owner.

Then the card: hypothesis | decision rule | method | arithmetic (shown) | guardrails | stop conditions |
runtime | owner | analysis plan (metrics, cuts, what each result means).

Budget and overflow: length is a judgement, not a line count. The header runs as long as the
verdict, its confidence and the top actions need, and then stops — no padding, no restating the
verdict, no qualifier that changes nothing. If it would grow past that, each action compresses to a
single clause and any rider (note, caveat, aside) moves to the body. The body carries the argument
and the evidence; if it is running well past what the work needs, the excess moves to an appendix
after the header, at the end of the artifact (the old ~1,500-word guide is a useful smell test, not
a limit to hit). This is how completeness and length coexist: every mandated section is still
completed — never cut to fit, nothing padded — by keeping its conclusion in the body and moving its
supporting detail (full tables, ledgers, workings) to the appendix. Material is relocated, never
dropped.

Derived numbers: every number derived from the input — a count, sum, share, percentage, delta or
rate — is recomputed once from its source before it is published, with the arithmetic shown beside
it (numerator and denominator, or the formula), and any claim resting on it (meets a target, a
majority, the largest) asserts no more than that arithmetic shows. In the header, where words are
capped, the arithmetic may sit at the figure's first statement in the body. Stating a real
derivation wrongly is a different failure from inventing a datum; both are forbidden.

## Anti-patterns

- "Let's A/B it" with no decision rule; peeking without stop rules
- Testing effects the arithmetic cannot detect at available volume
- Declaring victory without reading guardrails; post-hoc metric shopping
