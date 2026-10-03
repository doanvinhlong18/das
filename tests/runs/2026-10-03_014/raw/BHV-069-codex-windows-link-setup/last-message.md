**DECISION**

Use the central PowerShell installer with an explicit NTFS junction:

```powershell
& 'D:\Work\dev-agent-skills\adapters\codex\scripts\install.ps1' `
  -Scope Project `
  -ProjectRoot (Get-Location).Path `
  -SourceRoot 'D:\Work\dev-agent-skills' `
  -LinkType Junction
```

**EVIDENCE CLASSIFICATION**

- Confirmed: the project has no `.agents/skills`.
- Confirmed: the installer supports project scope and `Junction`.
- Confirmed: `Auto` attempts a symbolic link first, then falls back to a junction on Windows.
- Context-supported: symbolic-link permissions may be unavailable; junctions are supported.

**STATE EFFECT**

`READY_FOR_MINIMAL_DECOMPOSITION` — this is a local, mechanical, low-risk setup task with no blocking uncertainty.

**IMPLEMENTATION SCOPE**

Create `.agents/skills` and junction each central `core` and `domains` skill directory into it. Do not copy skills or alter unrelated project files.

**VERIFICATION**

After installation, confirm every entry under `.agents/skills` has `LinkType` equal to `Junction` and targets the corresponding directory under `D:\Work\dev-agent-skills`.

No files are modified in this read-only simulation.