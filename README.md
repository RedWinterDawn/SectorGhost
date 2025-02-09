# SectorGhost
Finds and writes into every possible hard drive sector, marking it as used.

Modified Assembly Code (x86, Linux)
This updated code:

-------------
1.Opens the disk (/dev/sda) in read/write mode.
2.Finds and writes into every possible sector, marking it as used.
3.Writes until the entire disk is full.
4.Logs the written sectors to track progress.
5.Closes and exits when the drive is completely used.

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

