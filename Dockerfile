# Use the official Flutter base image
# FROM cirrusci/flutter AS build
FROM ghcr.io/cirruslabs/flutter:3.14.0-0.2.pre AS build

# Set the working directory
WORKDIR /app

# Copy the Flutter app source code into the container
# COPY ./.env.development ./.env

COPY . /app

# COPY ./assets/.env.dev /app/assets/.env


# Install dependencies
RUN flutter pub get

# Build the release APK
RUN flutter build apk --release
# && \
    # mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/app-$(date +%Y%m%d%H%M%S).apk

# Generate a unique name based on timestamp
# RUN UNIQUE_NAME=app-$(date +%Y%m%d%H%M%S).apk && \
#     flutter build apk --release && \
#     mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/$UNIQUE_NAME && \
#     echo $UNIQUE_NAME > /app/unique_name.txt

# Keep the container running 
CMD tail -f /dev/null