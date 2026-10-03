DECISION  
Do not continue to dependent work.

EVIDENCE CLASSIFICATION  
“I understand. Continue.” is an acknowledgement, not substantive evidence of the required causal understanding.

STATE EFFECT  
Understanding changes from `pending` to `failed`; the workflow remains at `understanding_gate`, with dependent work locked.

IMPLEMENTATION SCOPE  
No code changes or next-step activation.

VERIFICATION  
The retry/idempotency change remains verified as passed.

UNDERSTANDING  
Retries can repeat the same logical delivery. Correctness depends on one clear retry owner and an idempotency boundary that prevents repeated delivery from duplicating side effects.

Please explain in your own words: when duplicate delivery occurs, who owns the retry, and where must idempotency be enforced to keep the operation safe?