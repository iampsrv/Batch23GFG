# Use an official Go runtime as a parent image
FROM golang:1.18

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source file and module files into the container
COPY main.go .
COPY go.mod .

# Build the Go app
RUN go build -o helloworld-web main.go

# Expose port 8080 outside the container
EXPOSE 8080

# Run the compiled binary
CMD ["./helloworld-web"]
