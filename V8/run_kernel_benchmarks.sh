#!/bin/bash
OUTPUT_DIR=$1
mkdir -p $OUTPUT_DIR

# lmbench
for i in {1..5}; do
  lmbench -P 1 > $OUTPUT_DIR/lmbench_run_$i.txt
done

# fio (sequential read)
sudo dd if=/dev/zero of=/testfile bs=1G count=1
for i in {1..5}; do
  fio --name=read --filename=/testfile --rw=read --bs=4k --size=1G --numjobs=1 --runtime=60 --time_based --group_reporting > $OUTPUT_DIR/fio_run_$i.txt
done

# perf stat (kernel compilation)
cd ~/security-overhead/kernel/linux-6.6
for i in {1..5}; do
  perf stat -e cycles,instructions,branch-misses,tlb_misses -o $OUTPUT_DIR/perf_run_$i.txt make -j$(nproc)
done

# Kernel compilation time
for i in {1..5}; do
  /usr/bin/time -o $OUTPUT_DIR/compile_run_$i.txt make -j$(nproc)
done
