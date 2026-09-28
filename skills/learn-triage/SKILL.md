---
name: learn-triage
description: "Convert a raw dump of tickets, feedback, and requests into prioritized signal and routing decisions. Use when feedback volume arrives (support export, reviews, sales notes) and the next plan cycle needs to know what it means."
metadata:
  version: "0.3.5"
  inspired-by: "right-thing :: plan-prd (fragment-ledger discipline)"
---

# learn-triage — feedback dump to routed signal

**Output is a file, always.** The deliverable is a written artifact, not a chat reply: the request
is answered inside the artifact's decision header, the file is saved, and its path is named in the
closing message. A conversational answer alone is an incomplete run. Put the file in the working directory (or the artifacts directory if one exists) — never inside the inputs. The decision header is the artifact's first section, under the exact heading `## Decision header`, with **Verdict:**, **Confidence:** and **Top 3 actions** labelled as such.

## Inputs

- Required: the raw dump — tickets, reviews, survey answers, sales notes — with each item's
  source.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch support tags, usage, and churn data itself. Fetched data counts as evidence
  only when it carries a cited path or query; uncited fetched data is an assumption; data that
  exists nowhere is a named data pull, never a finding.
- Persistence: the artifact is the deliverable; its absence is an incomplete run. Never skip the file because the request reads as a conversation. Save the output to `<dir>/learn-triage-<slug>.md` (`<dir>` = the session's
  working-artifacts directory, or the working directory if none exists; never into the input directory itself); before starting, look in `<dir>` for
  upstream artifacts — none for this play: its input is raw dumps.

## Stance

Raw feedback is mostly noise: one-offs, solutions dressed as wishes, duplicates, cranks. The job
is cluster, verify, route — not transcribe and obey. Nothing is deleted; noise is TAGGED, so the
ledger stays auditable. Praise is signal about what to protect, never about what to build.

## Procedure

1. **Ledger every item** (plan-prd's discipline): [T-n] quote, one line | source | kind —
   problem-signal | solution-wish | bug | praise | churn-threat | noise. Noise is a kind with a
   reason (crank, one-off, unfalsifiable), not a discard.
2. **Cluster by underlying pain, not by feature word.** A handful of "I keep getting logged out"
   items from different sources are one cluster; "add dark mode" and "the screen is too bright at
   night" may be one wish wearing two costumes. A cluster lists its member IDs. Merging on costume
   is a flag, not a fusion. If the member pains differ (admin-side workflow pain vs end-user
   friction), the merged cluster carries separate promotion rules per pain.
3. **Weight clusters:** frequency x source diversity x severity (revenue/retention impact).
   State the scale and units used and show the arithmetic per cluster, so the number is auditable
   — not authoritative. One loud account repeating itself is a stake, not a signal — repetition by
   one source adds no diversity. Cranky members ride IN a cluster but add nothing to frequency,
   diversity, or severity — the cluster must stand on its other sources.
4. **Verify top clusters against data** before routing: support tags, usage, churn data.
   Verification uses only data furnished in the input or fetched with a cited path or query;
   anything else is a named data pull, never a verification result. Inventing a verification
   datum is the cardinal sin. A cluster that cannot be checked against any data is marked UNVERIFIED, routes
   to-experiment (or a named data pull), and carries an explicit promotion rule: to-plan stays
   reserved for verified problems — frequency alone never promotes.
5. **Route each cluster:**
   - fix-now (bug — severity + owner). A bug routes fix-now regardless of which cluster its pain
     rides in; split it out with a one-line rationale.
   - to-plan (verified problem — feeds plan-prd's evidence ledger)
   - to-experiment (uncertain — feeds learn-experiment; an unverified cluster starts here with a
     named data pull, not in to-plan)
   - to-relationship (account-specific — an owner, not a roadmap)
   - dismiss (with reason)
6. **Trap sweep:** solution-wishes recorded as demands; praise treated as build guidance; a
   churn-threat from n=1 conflated with product signal (that is account management until the
   evidence widens — cf. plan-direction's loud-small-sample probe).

## Output format

**The artifact is the deliverable, not a chat reply.** If the request reads as a question, the
decision header is the answer — and the full artifact is still produced and saved to the path below.
A message in the conversation may summarize it; a summary never replaces it.

Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (the cluster that matters most
and where it routes); confidence (high/medium/low) with its basis; the top 3 actions, each with an
owner.

Then the signal memo: top clusters (members, weight, verification result, route, owner) -> trap
findings -> the full ledger.

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

- Feature-vote theater: transcribe, count, obey
- Averaging severity across sources; the crank's 10/10 swamping nine 3/10s
- Silence read as satisfaction
