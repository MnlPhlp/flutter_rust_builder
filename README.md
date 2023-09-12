# flutter_rust_builder
docker image to build a flutter and rust app (using flutter_rust_bridge)

Supports generating the bindings and building the actual app.

## Usage in github action
```yaml
name: App

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

      - name: Install dependencies
        run: flutter pub get

      - name: Gen flutter_rust_bridge bindings
        run: just gen

      - name: build apk
        run: flutter build apk --release
```