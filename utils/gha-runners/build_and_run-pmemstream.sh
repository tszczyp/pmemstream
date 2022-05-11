#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2022, Intel Corporation

#
# build_and_run-pmemstream.sh - Script for building pmemstream and running basic tests.
#

FULL_PATH=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
PMEMSTREAM_PATH="${FULL_PATH}/../.."
PMEM_PATH="/mnt/pmem0"

set -eo pipefail

#
# build_pmemstream -- build pmemstream from source.
#
function build_pmemstream {
	echo "********** make pmemstream **********"
	cd ${PMEMSTREAM_PATH} && mkdir build
	cd ${PMEMSTREAM_PATH}/build && cmake .. -DTEST_DIR=$PMEM_PATH -DBUILD_TESTS=ON -DCMAKE_BUILD_TYPE=Debug
	cd ${PMEMSTREAM_PATH}/build && make -j$(nproc)
	echo "********** make pmemstream test **********"
	cd ${PMEMSTREAM_PATH}/build && ctest --output-on-failure
}

build_pmemstream
