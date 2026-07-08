# careerhub

# Assignment 1.1
## Question 1
| Field | Decision | Domain Justification |
|---|---|---|
| `title` | Non-nullable | A job posting without a title isn't a job posting — it's nothing to display. |
| `company` | Non-nullable | CareerHub identifies listings by employer, so a listing must always be attributable to a company. |
| `location` | Non-nullable (uses `"Remote"` as a value) | Every job has *some* work arrangement to communicate to a JobSeeker; remote jobs use the string `"Remote"` rather than an absent value, so the field is never meaningless. |
| `salary` | Nullable | Many companies don't disclose salary publicly. |
| `closingDate` | Nullable | Some listings are open-ended ("until filled") and have no fixed closing date. |
| `description` | Nullable | A draft job may be created before a full description has been written. |
| `employmentType` | Non-nullable | Full-time/part-time/contract is normally a required dropdown at creation, so a listing always has a defined type. |
| `isOpen` | Non-nullable | A job always has some status — even "draft" is a status — so this can never be genuinely absent. |

### Most Dangerous Nullable Field

The most dangerous nullable field to render without an explicit null check is `closingDate`. If a job's
closing date is absent and this is forgotten in the UI, the most likely failure isn't a crash or a visibly
broken label — it's silence. A JobSeeker scanning the card simply won't see a "Closes: ..." line at all,
and because there's no error or blank placeholder to signal something is missing, they have no reason
to suspect anything is wrong. The danger is that an open-ended listing (no fixed closing date) and a
listing where the closing date failed to load or was forgotten by the employer look identical on screen.
Compare this to `salary`, where a missing value can safely fall back to a visible, honest label like
"Market-related" — there's no equivalent safe fallback for `closingDate`, since simply hiding it is
indistinguishable from "this job never closes." A JobSeeker could apply to a role assuming it's still
open, or skip applying to a role assuming it's about to close, based on incomplete information they
had no way of noticing.

## Question 2 — Salary Type

I chose `double?` for the salary field. Backend APIs rarely store salary as a single
formatted string — they typically store a numeric min/max range (e.g. `salaryMin: 30000,
salaryMax: 45000`) so it can be sorted and filtered server-side, formatted only on the
client. Since the Day 1 model only has one salary field to work with, `double?` is the
closest match to that shape: it preserves sortability and lets `displaySalary` handle all
formatting in one place, whereas a `String` can't be sorted or used in comparisons later.
When a company marks a job as confidential, `salary` is simply left as `null`, and
`displaySalary` returns `"Market-related"` instead of exposing a raw or placeholder value.

## Question 3 — Status Representation

I used a single `bool isOpen` field, since it's the simplest option that satisfies "open
vs. not open" with the Dart concepts covered on Day 1. Its main limitation is that a bool
can't distinguish *why* a job isn't open — Closed, Draft, and Expired are three distinct
business states that all collapse into `false`. The Week 2 Day 2 feature that solves this
is a Dart `enum`, because it can represent a fixed, named set of mutually exclusive states
instead of overloading a single boolean.

## Question 4 — Named Constructor Justification

- **`Job.closed(...)`** — represents an employer manually closing a listing early (e.g. the
  position was filled), a distinct business event from just flipping a bool, since it also
  stamps sensible defaults like `isOpen = false` and clears `closingDate` in one call.
- **`Job.remote(...)`** — represents a job posted with no fixed physical location by design,
  setting `location` to `"Remote"` automatically so any location-based filtering logic can
  treat remote jobs consistently.

## Scratch Output

```
Job(title: Flutter Developer, company: CareerHub, location: Pretoria, isOpen: true, salary: R35000 per month, closingDate: 2026-08-01 00:00:00.000)
  canApply: true, displaySalary: R35000 per month
Job(title: Backend Intern, company: DataCo, location: Johannesburg, isOpen: true, salary: Market-related, closingDate: none)
  canApply: true, displaySalary: Market-related
Job(title: Product Designer, company: PixelWorks, location: Cape Town, isOpen: false, salary: Market-related, closingDate: none)
  canApply: false, displaySalary: Market-related
Job(title: DevOps Engineer, company: CloudNine, location: Remote, isOpen: true, salary: R42000 per month, closingDate: none)
  canApply: true, displaySalary: R42000 per month
```

## Part 3 — JobCard Verification

Manually verified by running the app and inspecting each of the four hardcoded jobs:

- The job with no salary (Backend Intern) displays "Market-related" — not "null", not a blank line
- The job with no closing date (Backend Intern, Product Designer, DevOps Engineer) shows no
  closing date label at all — no "Closes: " with nothing after it, no visible gap
- The closed job's card (Product Designer) visually communicates its status via a red "Closed"
  chip, distinct from the green "Open" chip on the other three
- The remote job's card (DevOps Engineer) correctly displays "Remote" as its location
- Toggling `isOpen` on a job in the hardcoded list in `main.dart` and pressing hot reload updates
  the corresponding card's chip colour and label without restarting the app
- 
## Colour Decision Part 4
Teal
 - calmer/more trustworthy than a hard corporate blue, 
    without being alarming I'm avoiding red/orange as a 
    primary seed since I'm already using red/green for 
    status chips

## Stretch A — copyWith

`copyWith` solves the problem of updating one field on an immutable object without
retyping every other field manually — without it, changing just `isOpen` on an existing
`Job` would require reconstructing the entire object field-by-field. The package that
generates this automatically in Week 2 is `freezed`.

### Verification output

\`\`\`
Job(title: Flutter Developer, company: CareerHub, location: Pretoria, isOpen: false, salary: R35000 per month, closingDate: 2026-08-01 00:00:00.000)
Unchanged fields preserved: true
copyWith() with no args equals original: true
\`\`\`

## Stretch B — matches filter

Added `bool matches(String query)`, which checks `title`, `company`, and `location`
case-insensitively. Verified in `scratch/matches_test.dart` with five jobs and three
queries, each asserting the expected subset of jobs is returned. This is the filter
logic that will be wired to Riverpod state in Day 3.

### Verification output

\`\`\`
Query "flutter" -> [Flutter Developer]
Query "DATACO" -> [Backend Intern]
Query "cape town" -> [Product Designer]
All assertions passed.
\`\`\`

### Stretch C — JobStatusBadge

Extracted the status indicator into its own `JobStatusBadge` widget, taking `bool isOpen`.
This is worthwhile rather than keeping the status UI inline in `JobCard` because it
isolates the status-colour logic in one reusable place — search results and dashboards
in Week 3 can reuse the exact same badge without duplicating the colour/label logic.

# Assignment 1.2

## Question 1 — Constraint Explanation

`Scaffold.body` gives its child bounded width but unbounded height. A `Column` passes
that unbounded height down to its children unless told otherwise. `ListView.builder` is
a scrollable viewport that needs a bounded height to size itself — it cannot lay out
against infinity, so placing it directly inside a `Column` throws a
"vertical viewport was given unbounded height" error. The `SingleChildScrollView` chip
row above it doesn't cause the crash; the `ListView.builder` does. The fix is to wrap
`ListView.builder` in `Expanded`, which tells the `Column` to give it the remaining
bounded space after the chip row is laid out — converting the unbounded height constraint
into a bounded one the list can size against.

## Question 2 — Grid Reasoning

**Content inventory:**
- Required (always rendered): title, company, location, `displaySalary`, status badge
- Conditional: closing date, description

**Height estimates** (at ~390px width): minimal card (required fields only) ≈ 140dp.
Maximal card (all fields present) ≈ 194dp.

**childAspectRatio derivation:** At 2 columns with 8px spacing/padding, each cell is
roughly (390 − 24) / 2 ≈ 183dp wide. To avoid overflow, I sized the cell height for the
*maximal* card (~194dp) plus a small buffer, giving a target height of ~210dp.
`childAspectRatio = width / height = 183 / 210 ≈ 0.87`.

**What happens if sized for the minimal card instead:** a fully populated card would
overflow the fixed-height cell — Flutter clips the content or renders a yellow-and-black
overflow warning stripe. This is not acceptable, since it's a rendering bug the user would
see, not a design choice. Sizing for the maximal card avoids this; the tradeoff is that
minimal cards leave some empty space in their cell, which is preferable to a broken layout.

## Question 3 — Colour Audit

| Widget | Current Reference | Classification | Replacement Role | Justification |
|---|---|---|---|---|
| `JobStatusBadge` | `Colors.green.shade100` (open) | Hardcoded | `colorScheme.primaryContainer` | Represents a positive/active state — the primary container role is the M3-recommended surface for a confirming/active status. |
| `JobStatusBadge` | `Colors.red.shade100` (closed) | Hardcoded | `colorScheme.errorContainer` | A closed listing signals unavailability/a negative outcome for the user's goal (applying), which is exactly what the `error` role family represents semantically, not just visually. |
| `JobCard` | Any `Card` default background | Theme-referenced | `colorScheme.surface` (via `Card` default) | `Card` already pulls its colour from the theme's surface role, so no change needed here — confirm this is true in your code. |

## Question 4 — Extraction Justification

I extracted the title-and-status-badge header row into a `JobCardHeader` widget.

1. **Single responsibility (named in <5 words):** "Displays job title and status" — met.
2. **Rendered in more than one place:** Likely, since Week 3 introduces search results and
   dashboards that will each need a compact title+status header — met.
3. **Testable in isolation:** It only needs a `String title` and `bool isOpen`, no dependency
   on the rest of `JobCard`'s state — met.

All three criteria are satisfied. If I hadn't extracted it, the cost wouldn't show up in
line count — it would show up in clarity: `JobCard`'s build method would keep mixing
layout-row logic with badge-colour logic in one place, making it harder to reuse the
title+status pairing anywhere else without copy-pasting the Row and its styling.