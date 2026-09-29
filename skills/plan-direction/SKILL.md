---
name: plan-direction
description: "Weigh 2-4 competing product directions and recommend one: frozen weighted criteria, reasoning-trap audit, reversibility and sequencing, kill criteria. Use when the debate is which bet to make next."
metadata:
  version: "0.4.0"
  inspired-by: "RefoundAI/lenny-skills :: evaluating-trade-offs (cost of inaction, named biases, flip question); RefoundAI/lenny-skills :: defining-product-strategy (diagnose the crux, clarity over certainty); pratikshadake/claude-product-management-skills :: tradeoff-articulator (gain/lose/why-now contract); pratikshadake/claude-product-management-skills :: user-segment-prioritizer (criteria-first rubric, rejected options stay visible); kazdenc/builder-skills :: lean-canvas (every box a bet, riskiest assumption first)"
---

# plan-direction — weigh competing bets, recommend one

**Output is always a file:** `<dir>/plan-direction-<slug>.md` (artifacts directory, else working directory; never the input's), path named in the closing message. Refusals write it too; chat alone is an incomplete run. It opens `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**), which alone may answer a quick question, file still written.

## Inputs

- Required: 2-4 competing directions plus the context that makes the choice live — the goal,
  capacity, and constraints.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the metrics, estimates and prior decision docs behind each option itself.
  Fetched data counts as evidence only when it carries a cited path or query; uncited fetched
  data is an assumption; data that exists nowhere is a named data pull, never a finding.
- Persistence: before starting, look in `<dir>` for learn-retro's next-cycle handoffs
  (`learn-retro-*.md`).

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

The weighted table structures the debate; it does not settle it. Each 1-5 score is a judgement
written as a number, so a few points' difference in the totals is noise, and the recommendation
rests on the evidence and the trap audit, never on the total alone.

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

- Decision header, first: a one-sentence verdict (the recommended direction
  or sequence); confidence (high/medium/low) with its basis — which evidence dominates; the top 3
  actions, each with an owner. This header is the memo's verdict; it is not repeated elsewhere.
- The frozen-criteria score table
- Gain / Lose / Why-now for the recommended option
- Reversibility tags + execution sequence (what runs first, what it unblocks)
- Kill criteria: metric-triggered and dated ("if pilot listening-time lift is under 2 min/week over the 18-minute baseline by 2027-03-16, stop and reassess")
- Predictions: 2-4 dated, checkable predictions the recommendation implies (metric + threshold + date), for learn-retro to score.
- Evidence that would flip this call
- Trap audit appendix (all four probes, findings)
- The riskiest assumption behind the recommendation, stated as a testable bet
- Document order: the decision header opens, then the crux and the frozen criteria (so the freeze is auditable); the other items above may follow in any order

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

## Norm

Clarity over certainty: state the path so it can be corrected fast. "We may be wrong, but we are
clear" beats a hedge.

## Micro-example (decision header)

    Verdict: Sequence B then A — ship offline downloads first (~16 weeks, one squad), then open
    the family-plan beta on the steadier app. Confidence: medium — the offline diagnosis rests on
    session and crash logs, not a controlled test.
    Top actions: (1) staff the offline squad — eng lead; (2) arm the kill criterion (pilot
    listening-time lift < 2 min/week over the 18-minute baseline by 2027-03-16, eight weeks after
    the ~16-week ship) — PM; (3) draft the family-plan beta brief for the handoff — PM.
