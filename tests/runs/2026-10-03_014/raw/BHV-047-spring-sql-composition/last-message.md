DECISION  
Continue `code-investigation`; compose Spring and SQL advisers. Do not modify code or advance to decomposition yet.

EVIDENCE CLASSIFICATION  
- FACT: The repository endpoint returns duplicate invoices.
- FACT: Repository mapping, generated SQL, schema, representative rows, and transaction configuration are available for inspection.
- HYPOTHESIS: A one-to-many or many-to-many join multiplies rows at a finer grain than one invoice.
- HYPOTHESIS: Spring mapping or result transformation exposes repeated invoice entities from otherwise expected SQL rows.
- HYPOTHESIS: Source-table duplicates or transaction visibility produce duplicates independently of joins.
- Confirm no root cause until a read-only comparison distinguishes these alternatives.

STATE EFFECT  
Remain in `investigation`; record sourced facts, hypothesis status, contradictions, and the resulting readiness only.

IMPLEMENTATION SCOPE  
None. No query, mapping, schema, configuration, test, or data changes.

VERIFICATION  
Trace repository method → effective Spring mapping → bound/generated SQL → join cardinalities. Compare:
- result count versus `COUNT(DISTINCT invoice_id)`;
- invoice-grain rows before and after each join;
- duplicate keys against schema constraints and representative data;
- raw SQL rows against mapped endpoint results;
- effective transaction/isolation only if duplicates vary by execution or commit state.

UNDERSTANDING  
The immediate goal is sufficiently clear: locate the layer and relationship that creates more than one returned occurrence per intended invoice.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None yet; transaction configuration is supporting evidence, not proof of causality.