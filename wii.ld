/* Wii linker script - from official libogc */

OUTPUT_FORMAT("elf32-powerpc")
OUTPUT_ARCH(powerpc:common)

ENTRY(_start)

MEMORY
{
  ram : ORIGIN = 0x80004000, LENGTH = 24M
}

SECTIONS
{
  /* Text/code section */
  .text : {
    KEEP(*(.init))
    *(.text*)
    *(.rodata*)
    KEEP(*(.fini))
    *(.ctors)
    *(.dtors)
    *(.eh_frame*)
  } > ram

  .eh_frame_hdr : { *(.eh_frame_hdr) } > ram

  /* Small data section */
  .sdata : {
    __sdata_start = .;
    *(.sdata*)
    __sdata_end = .;
  } > ram

  /* Small bss section */
  .sbss : {
    __sbss_start = .;
    *(.sbss*)
    *(COMMON)
    __sbss_end = .;
  } > ram

  /* Data section */
  .data : {
    *(.data*)
  } > ram

  /* BSS section */
  .bss : {
    __bss_start = .;
    *(.bss*)
    __bss_end = .;
  } > ram

  . = ALIGN(8);

  /* Stack area */
  __stack_addr = .;
  . += 0x4000; /* 16KB stack */
  __stack_end = .;

  /* Interrupt stack */
  __intrstack_addr = .;
  . += 0x4000; /* 16KB intr stack */
  __intrstack_end = .;

  /* GX registers area */
  __gxregs = .;
  . += 0x1000;

  /* Arena regions */
  __Arena1Lo = 0x81200000;
  __Arena1Hi = 0x81700000;
  __Arena2Lo = 0x90000000;
  __Arena2Hi = 0x94000000;

  /* IPC buffers */
  __ipcbufferLo = 0x94000000;
  __ipcbufferHi = 0x94200000;

  . = ALIGN(4);
  _end = .;
  PROVIDE(__end__ = _end);

  /* Required by libogc */
  PROVIDE(__isIPL = 0);
}
