#!/bin/bash
set -e


rake db:create && rake db:migrate

# Remove a potentially pre-existing server.pid for Rails.
rm -f /codekata/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"