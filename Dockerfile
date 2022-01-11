FROM golang:1.17-bullseye as builder

WORKDIR /src/autorelease-action
COPY . /src/autorelease-action

# Statically compile and omit symbol tables and debugging information
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -v -o autorelease-action .

# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/base-debian11

COPY --from=builder /src/autorelease-action /autorelease-action

ENTRYPOINT ["/autorelease-action"]