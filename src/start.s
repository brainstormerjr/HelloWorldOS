// We declare the 'kernel_main' label as being external to this file.
// That's because it's the name of the main C function in 'kernel.c'.
.extern kernel_main
 
// We declare the 'start' label as global (accessible from outside this file), since the linker will need to know where it is.
// In a bit, we'll actually take a look at the code that defines this label.
.global start
 
// Our bootloader, GRUB, needs to know some basic information about our kernel before it can boot it.
// We give GRUB this information using a standard known as 'Multiboot'.
// To define a valid 'Multiboot header' that will be recognised by GRUB, we need to hard code some
// constants into the executable. The following code calculates those constants.
.set MB_MAGIC, 0x1BADB002          // This is a 'magic' constant that GRUB will use to detect our kernel's location.
.set MB_FLAGS, (1 << 0) | (1 << 1) // This tells GRUB to 1: load modules on page boundaries and 2: provide a memory map (this is useful later in development)
// Finally, we calculate a checksum that includes all the previous values
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS))
 
// We now start the section of the executable that will contain our Multiboot header
.section .multiboot
	.align 4 // Make sure the following data is aligned on a multiple of 4 bytes
	// Use the previously calculated constants in executable code
	.long MB_MAGIC
	.long MB_FLAGS
	// Use the checksum we calculated earlier
	.long MB_CHECKSUM
 
// This section contains data initialised to zeroes when the kernel is loaded
.section .bss
	// Our C code will need a stack to run. Here, we allocate 4096 bytes (or 4 Kilobytes) for our stack.
	// We can expand this later if we want a larger stack. For now, it will be perfectly adequate.
	.align 16
	stack_bottom:
		.skip 4096 // Reserve a 4096-byte (4K) stack
	stack_top:
 
// This section contains our actual assembly code to be run when our kernel loads
.section .text
	// Here is the 'start' label we mentioned before. This is the first code that gets run in our kernel.
	start:
		// First thing's first: we want to set up an environment that's ready to run C code.
		// C is very relaxed in its requirements: All we need to do is to set up the stack.
		// Please note that on x86, the stack grows DOWNWARD. This is why we start at the top.
		mov $stack_top, %esp // Set the stack pointer to the top of the stack
 
		// Now we have a C-worthy (haha!) environment ready to run the rest of our kernel.
		// At this point, we can call our main C function.
		call kernel_main
 
		// If, by some mysterious circumstances, the kernel's C code ever returns, all we want to do is to hang the CPU
		hang:
			cli      // Disable CPU interrupts
			hlt      // Halt the CPU
			jmp hang // If that didn't work, loop around and try again. 
