# flutter_rust_builder
docker image to build a flutter and rust app (using flutter_rust_bridge)

Supports generating the bindings and building the actual app.

## Usage in Github Action
```yaml
name: App

env:
  RUSTUP_HOME: /root/.rustup

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest
    container: ghcr.io/mnlphlp/flutter_rust_builder:latest

    steps:
      - uses: actions/checkout@v3
      
      - name: rust cache
        uses: actions/cache@v3
        with:
          path: |
            ~/.cargo/bin/
            ~/.cargo/registry/index/
            ~/.cargo/registry/cache/
            ~/.cargo/git/db/
            ./native/target/
          key: ${{ runner.os }}-cargo-${{ hashFiles('**/Cargo.lock') }}
          restore-keys: ${{ runner.os }}-cargo-

      - name: check toolchain
        run: flutter --version && rustup show

      - name: Install flutter dependencies
        run: flutter pub get

      - name: Gen flutter_rust_bridge bindings
        run: just gen

      - name: build apk
        run: flutter build apk --release
```
