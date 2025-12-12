#!/usr/bin/env bash
set -euo pipefail

# Get script directory reliably
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Allow work_dir to be overridden by environment variable
work_dir="${WORK_DIR:-work}"

# Determine airootfs path
airootfs_dir="${script_dir}/../${work_dir}/x86_64/airootfs"

# Verify airootfs directory exists
if [[ ! -d "${airootfs_dir}" ]]; then
    echo "ERROR: airootfs directory not found at: ${airootfs_dir}"
    echo "Please check WORK_DIR environment variable or ensure work directory exists"
    exit 1
fi

arch_chroot() {
    local cmd="$1"
    arch-chroot "${airootfs_dir}" /bin/bash -c "${cmd}"
}

main() {
    arch_chroot "/usr/bin/iso-init"
}

main
