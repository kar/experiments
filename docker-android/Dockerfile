FROM dockerfile/java:oracle-java7

MAINTAINER Karol Gusak "dev@kar.gs"

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter platform-tools,build-tools-21.1.2,android-21,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository"]
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter android-19"]
# RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter sys-img-armeabi-v7a-android-21"]

# Some workaround
# RUN ["adb", "kill-server"]
# RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter tools"]

RUN which adb
RUN which android

# Create emulator
# RUN echo "no" | android create avd \
#                 --force \
#                 --device "Nexus 5" \
#                 --name test \
#                 --target android-21 \
#                 --abi armeabi-v7a \
#                 --skin WVGA800 \
#                 --sdcard 512M

# Cleaning
RUN apt-get clean

# GO to workspace
VOLUME ["/opt/workspace"]
WORKDIR /opt/workspace

ENTRYPOINT ["/opt/workspace/gradlew"]

ONBUILD ADD . /app/src
# TODO: Change the gradlew task to the one that downloads libraries only.
ONBUILD RUN cd /app/src/ && /app/src/gradlew assembleDebug check