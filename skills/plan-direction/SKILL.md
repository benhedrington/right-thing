---
name: plan-direction
description: "Weigh 2-4 competing product directions and recommend one: frozen weighted criteria, reasoning-trap audit, reversibility and sequencing, kill criteria. Use when the debate is which bet to make next."
metadata:
  version: "0.3.4"
  inspired-by: "RefoundAI/lenny-skills :: evaluating-trade-offs (cost of inaction, named biases, flip question); RefoundAI/lenny-skills :: defining-product-strategy (diagnose the crux, clarity over certainty); pratikshadake/claude-product-management-skills :: tradeoff-articulator (gain/lose/why-now contract); pratikshadake/claude-product-management-skills :: user-segment-prioritizer (criteria-first rubric, rejected options stay visible); kazdenc/builder-skills :: lean-canvas (every box a bet, riskiest assumption first)"
---

# plan-direction — weigh competing bets, recommend one

## Inputs

- Required: 2-4 competing directions plus the context that makes the choice live — the goal,
  capacity, and constraints.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the metrics, estimates and prior decision docs behind each option itself.
  Fetched data counts as evidence only when it carries a cited path or query; uncited fetched
  data is an assumption; data that exists nowhere is a named data pull, never a finding.
- Persistence: save the output to `<dir>/plan-direction-<slug>.md` (`<dir>` = the session's
  working-artifacts directory; ask once if not obvious); before starting, look in `<dir>` for
  learn-retro's next-cycle handoffs (`learn-retro-*.md`).

## Stance

Direction debates are won by reasoning quality, not by the loudest narrator. This play freezes the
criteria before looking at the options, audits the reasoning for named traps, and treats every
direction as a bet with a price, a reversal cost, and a kill switch.

## Procedure

### 1. Diagnose the crux

One or two sentences: the actual high-stakes obstacle this decision serves (e.g., "weekly
listening time per subscriber flat at 18 minutes while ad revenue depends on it"). The crux picks
the criteria. If the crux cannot be stated, the decision is not ripe — say so and stop.

### 2. Freeze the criteria BEFORE scoring options

3-5 weighted criteria, each tied to the crux (e.g., listening-time impact 45, time-to-signal 25,
team fit 15, reversibility 15 — weights sum to 100). Write them down before any option is examined. Any later
weight change is a logged revision event with a stated reason — never a silent drift.

### 3. Score every option

Scale: score each criterion 1-5; weighted = weight x score / 5 (each column maxes at its weight; totals max 100). State the scale in the memo. All options x all criteria x all scores, visible in one table; rejected options keep their numbers visible. Include deliberate inaction as a row whenever deferring is a live stance in the debate — a bet on hold is an option and is scored like one.

### 4. Run the trap audit

Four probes. Each answered with what was found, or "checked, clean":

- sunk-cost — is prior spend on any option being used as a reason for (or against) it? Prior spend
  is neither.
- loud-small-sample — which "demand" is a vocal minority? A few big customers asking is not market
  signal; name the sample size.
- authority-as-evidence — whose position appears in the argument as data? A CTO's preference is a
  stake, not evidence.
- do-both-cost — what does hedging both directions actually cost (split capacity, lost focus,
  heroics)?

### 5. Reversibility and sequencing

Tag each option: cheap-to-reverse | hard-to-reverse | foreclosing (kills the other paths for the
planning horizon). If the winner forecloses, raise the evidence bar or carve a cheap first
increment that preserves optionality. Weighted totals within 10 points (on the 100 scale): favor the option whose compounding cheap wins land earliest.

### 6. Write the memo

- Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (the recommended direction
  or sequence); confidence (high/medium/low) with its basis — which evidence dominates; the top 3
  actions, each with an owner. This header is the memo's verdict; it is not repeated elsewhere.
- The frozen-criteria score table
- Gain / Lose / Why-now for the recommended option
- Reversibility tags + execution sequence (what runs first, what it unblocks)
- Kill criteria: metric-triggered and dated ("if pilot listening-time lift < X min by <date>, stop and reassess")
- Predictions: 2-4 dated, checkable predictions the recommendation implies (metric + threshold + date), for learn-retro to score.
- Evidence that would flip this call
- Trap audit appendix (all four probes, findings)
- The riskiest assumption behind the recommendation, stated as a testable bet
- Document order: the decision header opens; crux and frozen criteria follow it (the freeze must be auditable); the rest of the list above is the memo’s contents, not its section order

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

## Norm

Clarity over certainty: state the path so it can be corrected fast. "We may be wrong, but we are
clear" beats a hedge.

## Micro-example (decision header)

    Verdict: Sequence B then A — ship offline downloads first (~16 weeks, one squad), then open
    the family-plan beta on the steadier app. Confidence: medium — the offline diagnosis rests on
    session and crash logs, not a controlled test.
    Top actions: (1) staff the offline squad — eng lead; (2) arm the kill criterion (listening-time
    lift < X min by <date>) — PM; (3) draft the family-plan beta brief for the handoff — PM.
