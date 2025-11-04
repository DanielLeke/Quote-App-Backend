# Use the official Dart image from Docker Hub
FROM dart:stable

# Set the working directory inside the container
WORKDIR /app

# Copy pubspec files and get dependencies first (to cache them)
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of your app's code
COPY . .

# Precompile the server to a native executable (optional but faster)
RUN dart compile exe bin/server.dart -o bin/server

# Tell Docker what port the app will use
EXPOSE 5000

# Start the compiled server
CMD ["./bin/server"]
