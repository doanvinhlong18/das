# Execution Transcript

**DECISION**  
Do not add `DISTINCT` yet. Continue investigation of join cardinality and temporal selection.

**EVIDENCE CLASSIFICATION**  
- Fact: The address join returns two rows per invoice.
- Fact: An invoice may have two historical addresses.
- Requirement: Exactly one address effective on the invoice date should join.
- Hypothesis: The join lacks or misapplies the effective-date predicate.
- Unproven proposal: `DISTINCT` would fix the underlying defect; it may only hide invalid fan-out and can still return conflicting address values.

**STATE EFFECT**  
Remain in `investigation`; duplicate origin and root cause are unconfirmed.

**IMPLEMENTATION SCOPE**  
None authorized. Inspect the query, keys, sample rows, effective-from/effective-to boundaries, null end dates, overlaps, and tie-breaking rules.

**VERIFICATION**  
Use representative invoices at date boundaries and confirm one correct address row per invoice—not merely a reduced row count.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
What are the intended interval semantics, such as `effective_from <= invoice_date AND invoice_date < effective_to`, and what rule applies if effective periods overlap?
