# V1 release delivery mode

## Status

Accepted — `2026-11-17`. The Product Owner delegated the v1.0 scope cut and
its delivery to the Technical Lead and authorized merges to `develop` on green
CI without prior physical validation.

Until v1.0 is on TestFlight, this document **takes precedence** over any
conflicting gate in
[issue-driven delivery](issue-driven-delivery.md), the
[agent delivery model](agent-delivery-model.md), milestone documents, and the
M9 Home contract. Everything it does not mention still applies, including the
[GitHub App identity](github-app-authentication.md) and
[repository verification](repository-verification.md).

## Why

PickOne stalled for six weeks on a per-PR physical-validation gate that only
one person could clear, while no distributable build existed. The process was
sized for a team; the project has one Product Owner and agents. The goal now
is a shipped v1.0, validated on real builds rather than PR by PR.

## V1.0 scope

**In:** iPhone; movies; Spain availability; English and Spanish; onboarding,
Home with three recommendations, Pick, per-card feedback, Movie Detail,
Watchlist, My movies, Settings; a "watch on <service>" handoff after a Pick;
release assets, privacy policy, Archive, and TestFlight.

**Out (deferred, not rejected):** iPad support and its M9 quality bar; the
Detail visual redesign; M9 Home PR4's acceptance matrix; the Discover tab and
standalone Search tab; TV series; any LLM, backend, account, or remote
analytics; further persistence hardening.

M9 Home closes at PR3 (#71). Issues #57, #64 and #65 are closed against this
decision instead of the original acceptance matrix.

## Ordered steps

1. Green baseline on the current Xcode: UI journeys, simulator names in
   `Makefile` and CI, the release-year inconsistency, UI smoke in the PR gate.
2. Scope cut: iPhone-only target, three tabs.
3. Complete English/Spanish localization.
4. "Watch on <service>" handoff after Pick.
5. Release readiness: icon, privacy policy, version `1.0.0`, Archive,
   TestFlight.
6. One to two weeks of real household use on the TestFlight build, then App
   Store submission.

## Merge gate

- One PR per step or coherent sub-step, from `develop`, as `Cesar-IA-Agent`.
- Merge when required CI is green on the final SHA **and** the Technical Lead
  has exercised the change in the simulator and recorded what was checked in
  the PR.
- No per-PR physical validation, versioned device guide, or separate issue is
  required. An issue is optional and used only when it helps track work.
- The Product Owner validates in batches on the TestFlight build. Findings
  become follow-up PRs; they do not reopen merged ones.
- A failing check is never bypassed, and hooks are never skipped.

## Documentation

Keep `PRODUCT.md` and `ENGINEERING.md` true. Write an ADR only for a decision
that is expensive to reverse. Do not add milestone specifications, validation
guides, or closure records for v1 steps; the PR description is the record.

## Still the Product Owner's

Apple Developer account, signing credentials and App Store Connect; the final
product name; anything that changes what PickOne is for. The Technical Lead
decides how and in what order v1.0 is reached.
