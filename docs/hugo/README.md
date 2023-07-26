# Hugo

Hugo is a tool created by Western Digital (HGST) for low level disk
maintenance including, but not limited to, changing the sector size.

## Installation

I used 7.3.2 in the past, but 7.4.5 seems to be freely available from the
internet archive now which is helpful.

- [https://archive.org/download/hugo-7.4.5](https://archive.org/download/hugo-7.4.5)

### Debian

Download the [Debian package] and install it.

[Debian package]: https://archive.org/download/hugo-7.4.5/HUGO-7.4.5.x86_64.deb

```sh
root@173eb0045a96:/# curl -LOfs https://archive.org/download/hugo-7.4.5/HUGO-7.4.5.x86_64.deb
root@173eb0045a96:/# dpkg -i HUGO-7.4.5.x86_64.deb
```

Hugo will need the `ncurses5` package.

```sh
root@173eb0045a96:/# apt install -y libncurses5
```

### Arch Linux

I have managed to get hugo to run on Arch Linux in the past, but I don't
remember how. It will need [ncurses5-compat-libs], but even with that it still wasn't happy.

[ncurses5-compat-libs]: https://aur.archlinux.org/packages/ncurses5-compat-libs

```sh
./usr/bin/hugo: error while loading shared libraries: libadaptec_wrapper.so: cannot open
 shared object file: No such file or directory
```

## Usage

### List disks

Hugo can list all the disks on a system and will report information like the
model, serial number and capacity.

```sh
thomas@7f811895bd:~/hugo-7.3.2.x86_64$ sudo ./hugo s --device

     Manuf.       Model               Serial                Interface   Capacity  Type  Firmware
-----------------------------------------------------------------------------------------------------------
  1) Kingston     SA400S37240G        50026B7783E87A4B      SATA        240   GB   SSD   SBFK62B3
    Device handles: /dev/sg0, /dev/sda
  2) HGST         H7280A520SUN8.0T    2EGYBSKV              SAS         7865  GB   HDD   PD51
    Device handles: /dev/sg2, /dev/sdb
  3) HGST         H7280A520SUN8.0T    2EH618PV              SAS         7865  GB   HDD   PD51
    Device handles: /dev/sg3, /dev/sdc
  4) HGST         H7280A520SUN8.0T    2EH69THV              SAS         7865  GB   HDD   PD51
    Device handles: /dev/sg4, /dev/sdd
  5) HGST         H7280A520SUN8.0T    2EGYD99V              SAS         7865  GB   HDD   PD51
    Device handles: /dev/sg5, /dev/sde
```

### Reformat / Change Sector Size

Vendors like Sun/Oracle and IBM format their disks with type 1, 2 or 3
protection, which is just a regular sector with a [Data Integrity Field (DIF)].

[Data Integrity Field (DIF)]: https://en.wikipedia.org/wiki/Data_Integrity_Field

- [Western Digital Whitepaper](https://documents.westerndigital.com/content/dam/doc-library/en_us/assets/public/western-digital/collateral/white-paper/white-paper-end-to-end-data-protection.pdf)
- [Seagate Technology Paper](https://www.seagate.com/files/staticfiles/docs/pdf/whitepaper/safeguarding-data-from-corruption-technology-paper-tp621us.pdf)

This essentially means that instead of 512 byte sectors, the disk is formatted
with 520 byte sectors, where the 8 additional bytes are a checksum.

```sh
smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.4.0-131-generic] (local build)
Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Vendor:               HGST
Product:              H7280A520SUN8.0T
Revision:             PD51
Compliance:           SPC-4
User Capacity:        7,865,536,647,168 bytes [7.86 TB]
Logical block size:   512 bytes
Physical block size:  4096 bytes
Formatted with type 1 protection
8 bytes of protection information per logical block
LU is fully provisioned
Rotation Rate:        7200 rpm
Form Factor:          3.5 inches
Logical Unit id:      0x5000cca23b3573bc
Serial number:        001536PYD99V        2EGYD99V
Device type:          disk
Transport protocol:   SAS (SPL-3)
Local Time is:        Sat Oct 22 22:18:35 2022 BST
SMART support is:     Available - device has SMART capability.
SMART support is:     Enabled
Temperature Warning:  Enabled
```

The unfortunate consequence of 520 byte sectors is the disk becomes ~ 2%
smaller. For example the above disk reformatted with 4k sectors has a capacity
of 8,001,563,222,016 bytes, which is a difference of 136 gigabytes.

To reformat the disk with 4k sectors, find the model number of the disk(s) and
use hugo format. The operation will take a while, ~ 12 hours for an 8TB disk.

```sh
❯ sudo ./hugo f -m H7280A520SUN8.0T -n max -b 4096
```

The disks should be taken offline after they've been reformatted. A short smart
test should confirm whether they're safe to use.

```sh
❯ sudo smartctl -t short /dev/sdX
❯ sudo smartctl -H /dev/sdX
```

Verify the disks are formatted with the expected sector size too.

#### Alternatives Considered

It's obviously burdensome and strange to install a proprietary tool from the
vendor to change the sector size of a disk, but I did attempt other options.
They all appeared to work initially, but the disks were unable to successfully
complete a smart test.

```sh
# 1  Background long   Aborted (device reset ?)    -   49296                 - [-   -    -]
```

```sh
SMART Self-test log
Num  Test              Status                 segment  LifeTime  LBA_first_err [SK ASC ASQ]
     Description                              number   (hours)
# 1  Background long   Failed in segment -->       3   47877                 - [0x1 0xb 0x97]
# 2  Background long   Failed in segment -->       6   47877         764900874 [0x3 0x5d 0x1]
```

I don't remember if I tried taking the disks offline
before testing them, but I am quite confident the following solutions didn't
work.

##### sg_format

Neither the fast format or regular format options worked.

```sh
❯ sudo sg_format --format --ffmt=1 /dev/sdb
```

```sh
❯ sudo sg_format --format --size=4096 /dev/sdb
```

#### Hugo fast format

Hugo has the option to fast format disks, but smart tests fail if they're
formatted this way.

```sh
❯ sudo ./hugo f -m H7280A520SUN8.0T --fastformat -n max -b 4096
```

## Conclusion

Enterprise disks with protection information can be problematic and waste a
large amount of space. Hugo is a relatively easy way to reformat disks with a
'normal' sector size and reclaim significant capacity.

Some of these enterprise disks also have weird firmware, like for instance Hugo
would report an IBM disk model as "X", and smartctl would report the model as
"HUH728080AL520 X". The same disk reformatted with 4k sectors now reports its
model as "HUH728080AL420" consistently. There is no harm, though it is strange.
