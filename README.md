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
