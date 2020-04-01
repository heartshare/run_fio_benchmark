This script runs the fio benchmark tool on a given device for Sequential Writes, Random Reads and Random Writes on 1G, 5G and 10G files. Tested on Mac and Linux. (should work on windows too, feel free to test and submit a PR)

Requirements :
  [fio benchmark tool](https://fio.readthedocs.io/en/latest/fio_doc.html)
  - Install on Linux (centos) : sudo yum install fio
  - Install on Mac : brew install fio
  
Usage :
 ./runfiobench.sh /mnt/pmem1/
(Run as root)

Sample results :

```Running benchmark for /mnt/pmem1
Sequential write - IOPS; Filesize - 1G
  write: IOPS=426, BW=426MiB/s (447MB/s)(1024MiB/2403msec)
Random Read - IOPS; Filesize - 1G
   read: IOPS=333k, BW=1301MiB/s (1364MB/s)(38.1GiB/30001msec)
Random Write - IOPS; Filesize - 1G
  write: IOPS=143k, BW=560MiB/s (587MB/s)(16.4GiB/30001msec)

Sequential write - IOPS; Filesize - 5G
  write: IOPS=1263, BW=1264MiB/s (1325MB/s)(5120MiB/4051msec)
Random Read - IOPS; Filesize - 5G
   read: IOPS=339k, BW=1325MiB/s (1389MB/s)(38.8GiB/30001msec)
Random Write - IOPS; Filesize - 5G
  write: IOPS=172k, BW=671MiB/s (704MB/s)(19.7GiB/30001msec)

Sequential write - IOPS; Filesize - 10G
  write: IOPS=1272, BW=1273MiB/s (1335MB/s)(10.0GiB/8046msec)
Random Read - IOPS; Filesize - 10G
   read: IOPS=329k, BW=1286MiB/s (1349MB/s)(37.7GiB/30001msec)
Random Write - IOPS; Filesize - 10G
  write: IOPS=153k, BW=598MiB/s (627MB/s)(17.5GiB/30001msec)
```
