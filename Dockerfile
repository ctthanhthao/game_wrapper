# Use official Swift image
FROM swift:5.8

# Set working directory inside the container
WORKDIR /app

# Copy everything from the repo into the container
COPY . .

# Install Vapor (for Swift web server)
RUN apt-get update && apt-get install -y \
    libssl-dev \
    && swift package resolve \
    && swift build -c release

# Expose port 8080
EXPOSE 8080

# Run the built Swift server
CMD ["./.build/release/Run"]
