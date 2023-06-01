FROM openjdk:11-jdk

ENV ANDROID_COMPILE_SDK=33
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_TOOLS=7583922

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN apt-get -qq install curl
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
ENV ANDROID_HOME=$PWD/android-sdk-linux
ENV PATH=$PATH:$PWD/android-sdk-linux/platform-tools/
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
ENV GRADLE_USER_HOME=$PWD/.gradle

