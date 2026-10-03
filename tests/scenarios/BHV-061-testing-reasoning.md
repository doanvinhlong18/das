# BHV-061 Testing Reasoning

**ID:** BHV-061-testing-reasoning

**TITLE:** Detect a mock that removes the behavior under test

**PURPOSE:** Test useful reasoning about test boundaries and false confidence
from unrealistic doubles.

**SEVERITY:** high

**INITIAL STATE:** A service unit test passes, but production fails at a
transactional database boundary.

**USER REQUEST:** "Why does the test not catch the bug?"

**CONTEXT:** The repository dependency is mocked and returns already-materialized
objects; production relies on lazy loading inside a transaction.

**EXPECTED BEHAVIOR:** Explain how the mock removes transaction and lazy-loading
semantics, identify what the unit test still proves, and propose the smallest
integration boundary that can discriminate the production failure.

**FORBIDDEN BEHAVIOR:** Dismiss unit tests generally, require full end-to-end
testing, modify tests, or declare the production cause confirmed from mock use.

**EXPECTED STATE TRANSITIONS:** Remain in the current investigation or
verification stage; core owns evidence classification and result.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable before successful verification.

**PASS CRITERIA:** Advice precisely identifies the missing semantic boundary and
proposes a proportional check while preserving uncertainty.

**FAIL CRITERIA:** Advice is generic, over-broad, changes tests, or controls
workflow.

**EVIDENCE TO CAPTURE:** Test setup, mock behavior, production boundary,
domain analysis, proposed integration check, limitations, and core record.
