#!/usr/bin/env bash

set -eu

# Resolve script dir regardless of execution location
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
runs_dir="$script_dir/runs"

# Require DEV_ENV to be set
if [ -z "${DEV_ENV:-}" ]; then
    echo "❌ Error: env var DEV_ENV needs to be present"
    exit 1
fi

export DEV_ENV="$DEV_ENV"

# Parse args
grep=""
dry_run="0"

while [[ $# -gt 0 ]]; do
    case "$1" in
    --dry)
        dry_run="1"
        ;;
    *)
        grep="$1"
        ;;
    esac
    shift
done

# Logging utility
log() {
    if [[ "$dry_run" == "1" ]]; then
        echo "[DRY_RUN]: $1"
    else
        echo "$1"
    fi
}

log "RUN: DEV_ENV=$DEV_ENV -- grep='$grep'"

echo ""
echo "🚀 Starting full dev setup..."

for script in "$runs_dir"/*.sh; do
    base=$(basename "$script")

    if [[ -n "$grep" && "$base" != *"$grep"* ]]; then
        continue
    fi

    echo ""
    echo "⚙️  Running $base..."

    chmod +x "$script"

    if [[ "$dry_run" == "1" ]]; then
        log "Would run $script"
    else
        "$script"
    fi
done

echo ""
echo "✅ All setup scripts completed successfully!"
