# Execution Transcript

**DECISION**  
Do not add `DISTINCT` yet. Move to focused SQL investigation.

**EVIDENCE CLASSIFICATION**  
- **Fact:** Joining addresses returns two rows per invoice.
- **Fact:** An invoice may have two historical addresses, but only the address effective on the invoice date belongs in the result.
- **Unknown:** Whether the fan-out comes from a missing/incorrect effective-date predicate, overlapping address ranges, or another join.
- **Hypothesis:** The address join does not constrain validity using the invoice date.

**STATE EFFECT**  
Task understanding is sufficient; enter investigation. No implementation is authorized.

**IMPLEMENTATION SCOPE**  
Locked until the join cardinality and effective-date rules are confirmed. `DISTINCT` could hide the invalid join and may still return conflicting address values.

**VERIFICATION**  
Use the available keys and sample rows to trace the join. Check predicates equivalent to:

```sql
invoice.invoice_date >= address.effective_from
AND (
    address.effective_to IS NULL
    OR invoice.invoice_date < address.effective_to
)
```

Confirm the required boundary semantics, detect overlapping validity periods, and verify exactly one effective address per invoice.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
Provide the current join, address validity columns, key definitions, and sample rows. The likely fix belongs in address selection or data constraintsâ€”not result-level deduplication.