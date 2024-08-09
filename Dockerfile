FROM golang:1.19-alpine AS builder

WORKDIR /app

# Copy the Go module files
COPY go.* ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o pipeline-test .

# Set the entrypoint to execute the function app
ENTRYPOINT ["./pipeline-test"]

# Expose the port for HTTP triggers
EXPOSE 80
