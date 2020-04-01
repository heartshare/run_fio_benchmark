#!/bin/bash

#TODO: parse out and report only IOPS and Bandwidth
#TODO: graph out results of multiple runs

ioengine="unknown"

if [ "$(uname)" == "Darwin" ]; then
    ioengine="posixaio"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    ioengine="libaio"
else
     echo "Unsupported OS, pls run on Mac or Linux; or submit a patch if you try on another OS"
     exit 1
fi

display_usage() {
  echo "Run FIO benchmarks on local drives; Sequential Write, Random Read and Write for 1, 5, 10G files"
  echo "**Tested on Mac 10.14 & Centos 7**"
	echo -e "\nUsage:\n runbench.sh <device path> \n"
	}

if [  $# -le 0 ]
	then
		display_usage
		exit 1
fi

# Change this variable to the path of the device you want to test
block_dev=$1/benchmark.file

echo "Running benchmark for $1"
for i in 1 5 10
do
  # full write pass
  echo "Sequential write - IOPS; Filesize - ${i}G"
  sudo fio --name=writefile --size=${i}G --filesize=${i}G \
  --filename=$block_dev --bs=1M --nrfiles=1 \
  --direct=1 --sync=0 --randrepeat=0 --rw=write --refill_buffers --end_fsync=1 \
  --iodepth=200 --ioengine=$ioengine | grep IOPS=

  # rand read
  echo "Random Read - IOPS; Filesize - ${i}G"
  sudo fio --time_based --name=benchmark --size=${i}G --runtime=30 \
  --filename=$block_dev --ioengine=$ioengine --randrepeat=0 \
  --iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 \
  --numjobs=4 --rw=randread --blocksize=4k --group_reporting | grep IOPS=

  # rand write
  echo "Random Write - IOPS; Filesize - ${i}G"
  sudo fio --time_based --name=benchmark --size=${i}G --runtime=30 \
  --filename=$block_dev --ioengine=$ioengine --randrepeat=0 \
  --iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 \
  --numjobs=4 --rw=randwrite --blocksize=4k --group_reporting | grep IOPS=

  sudo rm $block_dev
  echo
done
