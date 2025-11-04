# Use the official Dart image
FROM dart:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files first for caching
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the app
COPY . .

# Compile the server
RUN dart compile exe bin/quote_app_backend.dart -o bin/quote_app_backend

# Use a smaller runtime image
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/quote_app_backend /app/bin/
EXPOSE 5000
CMD ["/app/bin/quote_app_backend"]
