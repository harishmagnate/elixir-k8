FROM elixir:1.12-alpine AS builder

ARG BUILD_ENV=prod
ARG BUILD_REL=my_app

# Install system dependencies
RUN mix local.hex --force
RUN mix local.rebar --force

# Add sources
ADD . /workspace/
WORKDIR /workspace

ENV MIX_ENV=${BUILD_ENV}

# Fetch dependencies
RUN mix deps.get

# Build project
RUN mix compile

# Run test-suite
RUN mix test --cover

# Build release
RUN mix release ${BUILD_REL}

FROM alpine:latest AS runner

ARG BUILD_ENV=prod
ARG BUILD_REL=my_app

# Install system dependencies
RUN apk add --no-cache openssl ncurses-libs libgcc libstdc++

# Install release
COPY --from=builder /workspace/_build/${BUILD_ENV}/rel/${BUILD_REL} /opt/myapp

## Configure environment

# We want a FQDN in the nodename
ENV RELEASE_DISTRIBUTION="my-app"

# This value should be overriden at runtime
ENV RELEASE_IP="127.0.0.1"

# This will be the basename of our node
ENV RELEASE_NAME="${BUILD_REL}"

# This will be the full nodename
ENV RELEASE_NODE="${RELEASE_NAME}@${RELEASE_IP}"

# If empty, the default cookie generated by `mix release` will be used
# OVERRIDE IT!!
ENV RELEASE_COOKIE=""

ENTRYPOINT ["/opt/myapp/bin/${BUILD_REL}"]
CMD ["start"]