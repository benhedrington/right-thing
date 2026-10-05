---
name: learn-triage
description: "Convert a raw dump of tickets, feedback, and requests into prioritized signal and routing decisions. Use when feedback volume arrives (support export, reviews, sales notes) and the next plan cycle needs to know what it means."
metadata:
  version: "0.5.1"
  inspired-by: "see CREDITS.md"
---

# learn-triage — feedback dump to routed signal

Turns a raw feedback dump into weighted, verified clusters, each routed: fix-now, to-plan, to-experiment, to-relationship or dismiss.

**Output is always a file:** `<dir>/learn-triage-<slug>-YYYY-MM-DD.md`, opening `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

## Inputs

- Required: the raw dump — tickets, reviews, survey answers, sales notes — with each item's
  source, and how the dump was selected (full export, date range, search terms, sample). When
  the selection is not exhaustive, the memo says so beside the weight scale, and weights rank
  clusters within this dump only, never how common a pain is overall. When it is not stated,
  it is the first question.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch support tags, usage, and churn data itself. Fetched data counts as evidence
  only when it carries a cited path or query; uncited fetched data is an assumption; data that
  exists nowhere is a named data pull, never a finding.
- Persistence: the input is raw dumps. Before starting, look in `<dir>` for earlier
  `learn-triage-*.md` (their weight scale is reused, step 3) and, optionally, launch-read's
  predicted top-5 inbound questions (`launch-read-*.md`), which after a launch are what this
  dump should be checked against (step 2).

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
   If a launch-read artifact was found, match each predicted inbound question to the clusters:
   predicted and seen, predicted and absent, or seen but unpredicted. An unpredicted cluster of
   weight is a support-readiness gap for the next launch-read.
3. **Weight clusters:** frequency x source diversity x severity (revenue/retention impact).
   Default scale: frequency = distinct reporters (one account's or person's repeats count once;
   where identity cannot be matched across channels, such as anonymous app-store reviews,
   frequency is an upper bound and says so; if the route would differ at the lowest count the
   items allow, route on that lower count);
   diversity = distinct source channels; severity 1-3
   (1 = annoyance, 2 = blocks a task or costs time or money, 3 = cancellation or churn named).
   Reuse the scale of any earlier `learn-triage-*.md` in `<dir>` so weights compare across runs;
   the user may override it, and an override is stated beside the scale it replaces.
   State the scale and units used and show the arithmetic per cluster, so the number is auditable
   — not authoritative. One loud account repeating itself is a stake, not a signal — repetition by
   one source adds no diversity and no frequency: its repeats ride in the cluster and count once,
   so a loud account cannot inflate a cluster's weight. Cranky members ride IN a cluster but add
   nothing to frequency, diversity, or severity — the cluster must stand on its other sources.
4. **Verify top clusters against data** before routing: support tags, usage, churn data.
   Verification uses only data furnished in the input or fetched with a cited path or query;
   anything else is a named data pull, never a verification result. Inventing a verification
   datum is the cardinal sin. A cluster that cannot be checked against any data is marked UNVERIFIED, routes
   to-experiment (or a named data pull), and carries an explicit promotion rule: to-plan stays
   reserved for verified problems, save the two flagged routes below — frequency alone never
   promotes.
   **The flag bar** for the two flagged routes below: 3 or more distinct source channels,
   top-band severity, and at least 5 distinct reporters (a default the user may override). The
   reporter floor matters because one churn survey can make top-band severity cheap.
   **Data that exists but was not checked:** a cluster that clears the flag bar, whose verifying data exists in the org but was not checked, routes
   `to-plan (pending pull)`, not to-experiment: plan it, pending the pull. The gate is the same as
   for provisional — the named data pull, its owner and its date; the pull's result upgrades it
   to to-plan or sends it back to to-experiment; until then plan-prd reads it as it reads
   provisional (below). Below that bar, an unchecked cluster is UNVERIFIED as above. When some
   of the verifying data exists and some does not (the outcome is tracked, the behavior's event
   is not), route on the data that exists — pending pull — and hand the missing data to
   plan-prd as an instrumentation item.
   **Working with thin data:** when the verifying data does not exist in the org at all (no
   support tags, no usage instrumentation, no churn records; not merely unfetched), a cluster
   that clears the flag bar routes to-plan with an explicit
   "provisional" flag, not to-experiment. The flag states plainly what is missing and names what
   would settle it: the data pull or instrument that upgrades it to to-plan or sends it back to
   to-experiment, with an owner and a date. plan-prd takes the reports as evidence that people
   report the pain; its size stays an assumption. The two flags split on one question — does the
   data exist? Not in the org: provisional. Exists, unchecked: pending pull.
5. **Route each cluster:**
   - fix-now (bug — severity + owner). A bug routes fix-now regardless of which cluster its pain
     rides in; split it out with a one-line rationale.
   - to-plan (verified problem — names the team that owns the plan; feeds plan-prd's evidence ledger; "to-plan (provisional)" only
     under the thin-data rule in step 4, "to-plan (pending pull)" only under its unchecked-data
     rule)
   - to-experiment (uncertain — feeds learn-experiment; an unverified cluster below the
     flag bar starts here with a named data pull, not in to-plan)
   - to-relationship (account-specific — an account owner, or support in a consumer product;
     not a roadmap)
   - dismiss (with reason)
6. **Trap sweep:** solution-wishes recorded as demands; praise treated as build guidance; a
   churn-threat from n=1 conflated with product signal (that is account management until the
   evidence widens — cf. plan-direction's loud-small-sample probe).

## Output format

Decision header, first: a one-sentence verdict (the cluster that matters most
and where it routes); confidence (high/medium/low) with its basis; the top 3 actions, each with an
owner.

Then the signal memo: the weight scale and where it came from (default, reused from a named
earlier run, or user override) -> top clusters (members, weight, verification result, route,
owner) -> predicted-question check (when a launch-read artifact was found) -> trap findings ->
the full ledger.

## Anti-patterns

- Feature-vote theater: transcribe, count, obey
- Averaging severity across sources; the crank's 10/10 swamping nine 3/10s
- Silence read as satisfaction
- A fresh scale every run, so "this cluster grew" cannot be said

## Micro-example (one cluster, weighted)

    C-1 "Can't listen without signal" — T-03, T-07, T-11, T-12, T-19, T-24
    Scale: frequency = distinct reporters; diversity = distinct source channels; severity 1-3 (3 = cancellation named)
    Frequency 4 — T-03, T-07, T-11, T-19; T-12 repeats T-07's account and counts once;
      T-24 is noise (crank): it rides in the cluster and adds nothing
    Diversity 3 — support tickets (T-03, T-11, two accounts), one account's sales notes
      (T-07, T-12), app-store review (T-19); T-12 adds no diversity either
    Severity 3 — T-19: "cancelling before my next flight"
    Weight = 4 x 3 x 3 = 36
    Verified: 38% of sessions opened offline end within a minute — 4,902 / 12,900
      (session-log export, saved query offline-sessions-aug). Route: to-plan.

## Rules that always apply

Output file: `<dir>` is the working directory, unless the user or harness names another; never the folder the input file sits in unless the user or harness named that folder. Name the file in the closing message; where files do not persist between sessions (a chat app), add one line telling the user to save it where the next skill can find it, such as the project's files. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Files between skills: another run's file may be in `<dir>`, attached by the user, or in the project's files; look in all that exist. When this skill's inputs say to read an upstream file and none is found, ask the user once whether one exists to attach — it counts toward the question budget — then proceed without it and say so. When reading another run's file, use the most recent one whose topic matches the input and name the file used in the body; if more than one plausibly matches, ask — it counts toward the question budget. Never overwrite: the filename carries the date (`<skill>-<slug>-YYYY-MM-DD.md`); if today's file already exists, add `-2` (then `-3`) and say so in the body. Never silently replace an earlier run's file.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it. The closing message offers it in one line, since most users will not know to ask.
