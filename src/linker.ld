/* The bootloader will start execution at the symbol designated as the entry point. In this case, that's 'start' (defined in start.s) */
ENTRY(start)
 
/* Tell the linker part of the compiler where the various sections of the kernel will be put in the final kernel executable. */
SECTIONS
{
	/* Begin putting sections at 1 Megabyte (1M), a good place for kernels to be loaded at by the bootloader. */
	/* This is because memory below 1 Megabyte is reserved for other x86-related things, so we can't use it */
	. = 1M;
 
	/* We align all sections in the executable at multiples of 4 Kilobytes (4K). This will become useful later in development when we add paging */
 
	/* First put the multiboot header, as it's required to be near the start of the executable otherwise the bootloader won't find it */
	/* The Multiboot header is Read-Only data, so we can put it in a '.rodata' section. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
	}
 
	/* Executable code */
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.text)
	}
 
	/* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}
 
	/* Read-write data (initialized) */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}
 
	/* Read-write data (uninitialized) and stack */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}
}