# scratchee-engine-proto

Canonical protocol buffer definition for the Scratchee engine gRPC interface.

## Developer Setup

After cloning this repository, run the setup script to activate git hooks:

```bash
bin/setup
```

This enables commit-msg, pre-commit, and pre-push hooks that enforce project conventions (SEN-602/628/766/767/769).

## What this is

This repository contains the single source of truth for `engine.proto` — the gRPC service definition consumed by:

- **[engine](https://github.com/scratchee-engine/engine)** (Rust) — implements the gRPC server
- **[api](https://github.com/scratchee-engine/api)** (Node.js) — implements the gRPC client

Both repositories depend on this proto as a versioned package to prevent drift and ensure compatibility.

## Consumption

### Rust (engine repo)

Add to `Cargo.toml`:
```toml
[dependencies]
scratchee-engine-proto = { git = "https://github.com/scratchee-engine/engine-proto", tag = "v0.1.0" }
```

Reference in `build.rs`:
```rust
let proto_path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    .join("../engine-proto/engine.proto");
tonic_build::compile_protos(proto_path)?;
```

### Node.js (api repo)

Add to `package.json`:
```json
{
  "dependencies": {
    "@scratchee-engine/engine-proto": "github:scratchee-engine/engine-proto#v0.1.0"
  }
}
```

Reference in code:
```javascript
import { resolve } from 'path';
import { fileURLToPath } from 'url';
const PROTO_PATH = resolve(
  fileURLToPath(import.meta.url),
  '../../node_modules/@scratchee-engine/engine-proto/engine.proto'
);
```

## Change workflow

Proto changes must follow this sequence to prevent breaking either consumer:

1. **PR to this repo** with the proto change
2. **Merge and tag** a new version (semver):
   - Patch (0.1.1): additive-only changes (new optional fields, new RPCs)
   - Minor (0.2.0): backward-compatible additions
   - Major (1.0.0): breaking changes (removed fields, renamed RPCs, changed semantics)
3. **Update engine repo** to reference the new tag, verify CI green
4. **Update api repo** to reference the new tag, verify CI green
5. **Both must agree** on the version before any RPC change is deployed

## Versioning policy

- **Patch bump (0.1.x)**: additive-only changes, safe to roll one consumer at a time
- **Minor bump (0.x.0)**: backward-compatible, but both repos should update before deploying new RPCs
- **Major bump (x.0.0)**: breaking change, requires coordinated deployment of both repos

## License

MIT — see [LICENSE](./LICENSE)
