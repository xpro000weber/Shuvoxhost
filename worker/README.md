# ShuvoX Worker

This directory is intended for a separate Linux VPS with Docker. Do not deploy this worker as a Vercel Function.

The current worker is intentionally a placeholder. Before enabling arbitrary user code, implement:
- authenticated control-plane communication
- per-bot isolated containers with CPU, memory, PID and disk limits
- non-root execution, read-only base filesystem, dropped Linux capabilities
- network egress restrictions and secret isolation
- upload validation, file size limits, dependency allowlists/caching
- log and process lifecycle management
- cleanup, quotas, abuse detection and audit logs

Never execute uploaded Python with `exec()` or directly on the host.
