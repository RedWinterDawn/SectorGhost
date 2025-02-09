# SectorGhost
Finds and writes into every possible hard drive sector, marking it as used.

Modified Assembly Code (x86, Linux)
This updated code:

Opens the disk (/dev/sda or any raw block device).
Starts writing from the first available sector.
Continues until the entire disk is full.
Logs sector writes for tracking.

How This Works
Opens the disk (/dev/sda) in read/write mode.
Finds and writes into every possible sector, marking it as used.
Writes until the entire disk is full.
Logs the written sectors to track progress.
Closes and exits when the drive is completely used.

How to Compile & Run
Compile:
nasm -f elf32 disk_filler.asm -o disk_filler.o
ld -m elf_i386 disk_filler.o -o disk_filler

Run (as root, be careful!):
sh
Copy
Edit
sudo ./disk_filler

🚨 WARNING: This will completely fill your drive. Run it only on test disks like USB drives or virtual machines!

