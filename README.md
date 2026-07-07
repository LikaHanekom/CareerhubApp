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

## Question 2: 
Real backend APIs almost never store salary as a single formatted string
— they store a min/max numeric range (so it can be sorted and filtered), and format it 
client-side. So your best prediction for Week 2 is that the API will send something 
like {"salaryMin": 30000, "salaryMax": 45000} or a nullable numeric field. 
For Day 1, since you only have one field to model, double? 
is the most defensible choice — it preserves sortability and lets you format it in displaySalary, 
whereas String can't be sorted or math'd on later. 
Write this up as your own paragraph, addressing what happens when salary is confidential 
(salary is null, and displaySalary returns "Market-related").

## Question 3 (status):
Use a single bool isOpen for now — it's the simplest thing that satisfies "open vs not open" 
for Day 1. Its limitation: a bool can't distinguish why a job isn't open (Closed vs Draft vs Expired) — 
those are three different business states collapsed into one false. 
The Week 2 Day 2 feature that fixes this is an enum (specifically a Dart enum, possibly with methods)
— because it can represent a fixed, named set of mutually exclusive states instead of overloading a boolean.

## Question 4 (named constructors):Good candidates:

- Job.closed(...) 
  - a scenario where an employer manually closes a listing early (position filled),which is a distinct business event from just setting a bool, because you can also stamp defaults like isOpen = false and clear closingDate in one call.
- Job.remote(...)  
    - a scenario where a job is posted with no physical location by design, so location is set to "Remote" and any location-based filtering logic can treat it consistently.
