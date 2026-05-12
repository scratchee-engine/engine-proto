.PHONY: precommit
precommit:
	cargo check && cargo clippy -- -D warnings
