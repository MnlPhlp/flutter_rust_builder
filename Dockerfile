FROM ghcr.io/cirruslabs/flutter:3.10.5

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install cargo-ndk flutter_rust_bridge_codegen just cargo-expand
RUN rustup target install aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android 
RUN apt-get update && apt-get install -y --no-install-recommends gcc-multilib clang
RUN sdkmanager --install "ndk;25.2.9519653" 
RUN mkdir -p ~/.gradle && echo 'ANDROID_NDK=/opt/android-sdk-linux/ndk/25.2.9519653' >> ~/.gradle/gradle.properties
RUN sdkmanager --install "build-tools;30.0.3" "platforms;android-32" "platforms;android-31" "platforms;android-30"
