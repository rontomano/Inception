#!/bin/sh

# SIGTERM-handler
term_handler() {
  exit 0
}

# Setup signal handler
trap 'term_handler' SIGTERM

# Run php server
exec "$@"
