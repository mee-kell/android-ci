FROM openjdk:11-jdk

ENV ANDROID_COMPILE_SDK=33
ENV ANDROID_BUILD_TOOLS=30.0.3
ENV ANDROID_SDK_TOOLS=7583922

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN apt-get -qq install curl
# ENV ANDROID_HOME="${PWD}/android-home"
# RUN install -d $ANDROID_HOME
RUN wget --output-document=$ANDROID_HOME/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip
# RUN pushd $ANDROID_HOME
RUN unzip -d cmdline-tools cmdline-tools.zip
# RUN pushd cmdline-tools
# RUN mv cmdline-tools tools || true
# RUN popd
# RUN popd
ENV PATH=$PATH:${ANDROID_HOME}/cmdline-tools/tools/bin/
RUN sdkmanager --version
RUN yes | sdkmanager --licenses || true
RUN sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"
RUN sdkmanager "platform-tools"
RUN sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
ENV GRADLE_USER_HOME=$PWD/.gradle
# RUN chmod +x ./gradlew


# RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
# RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
# RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
# ENV ANDROID_HOME=$PWD/android-sdk-linux
# ENV PATH=$PATH:$PWD/android-sdk-linux/platform-tools/
# RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
# ENV GRADLE_USER_HOME=$PWD/.gradle

