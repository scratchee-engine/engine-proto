//! Canonical engine proto.

/// Path to the canonical engine.proto file.
///
/// Use this constant in build.rs to compile the proto:
/// ```no_run
/// tonic_build::compile_protos(scratchee_engine_proto::PROTO_FILE).unwrap();
/// ```
pub const PROTO_FILE: &str = concat!(env!("CARGO_MANIFEST_DIR"), "/engine.proto");
