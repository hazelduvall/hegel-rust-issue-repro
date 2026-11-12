# hegel-rust issue repro

The issue is specifically seems to be with the rust-toolchain nix module.

Running using a "normal" `cargo` from nixpkgs:

```
$ nix-shell -p cargo --command 'cargo clean'
$ nix-shell -p cargo --command 'cargo test'
# ...
    Finished `test` profile [unoptimized + debuginfo] target(s) in 11.48s
     Running unittests src/lib.rs (target/debug/deps/hegel_repro-4c4adc82f8148076)

running 1 test
test tests::test_simple_inequality ... FAILED

failures:

---- tests::test_simple_inequality stdout ----
let x = 0;
let y = 0;
thread 'tests::test_simple_inequality' (2) panicked at src/lib.rs:10:9:
assertion failed: x > y

To reproduce this failure, add the attribute below #[hegel::test]:
    #[hegel::reproduce_failure("AXicY2IAAi5GBgQFAAEFABk=")]


failures:
    tests::test_simple_inequality

test result: FAILED. 0 passed; 1 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.10s

error: test failed, to rerun pass `--lib`
```

Running using the rust-toolchain `cargo`:

```
$ nix develop --command cargo clean
$ nix develop --command cargo test
# ...
    Finished `test` profile [unoptimized + debuginfo] target(s) in 10.32s
     Running unittests src/lib.rs (target/debug/deps/hegel_repro-5527d8e41d819f63)

running 1 test
fatal runtime error: failed to initiate panic, error 5, aborting
error: test failed, to rerun pass `--lib`

Caused by:
  process didn't exit successfully: `/Users/hazelduvall/github/hegel-repro/target/debug/deps/hegel_repro-5527d8e41d819f63` (signal: 6, SIGABRT: process abort signal)
```

There seems to be some sort of loader shenanigans going on. I noticed this when
switching the `nix-shell -p cargo` version too: if hegel can't find a libc
among some hardcoded paths, it crashes with a different error.

I think this is a bug in hegel because I have not had this sort of issue with
rust-toolchain ever before.
