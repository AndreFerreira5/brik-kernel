# Brik Kernel

Welcome to the Brik Kernel repository! Brik Kernel is a simple operating system kernel that is currently in its early stages of development. This project is primarily intended for learning purposes and provides a hands-on opportunity to explore low-level programming, x86 assembly, and operating system concepts.

## About Brik Kernel

Brik Kernel is a Multiboot-compliant bootloader and kernel combination that aims to demonstrate fundamental concepts of operating system development. The codebase is written mainly in x86 assembly and C.

Please note that Brik Kernel is still in its infancy and lacks many advanced features found in fully-fledged operating systems. It's designed as a learning tool and a foundation for understanding how operating systems work at a low level.

## Getting Started

To experiment with Brik Kernel, make sure you have the required tools installed on your system. Check the "deps" folder in this repository for details on the tools needed to build and run the kernel.

1. Clone this repository:
   ```sh
   git clone https://github.com/AndreFerreira5/brik-kernel.git
   cd brik-kernel
   ```
2. Build the kernel:
   ```sh
   cd build
   make
   ```
3. Run the kernel:
   ```sh
   make debug
   ```

## Contributing

Contributions to Brik Kernel are welcome, especially if you're interested in low-level programming and operating systems. Feel free to submit pull requests, open issues, or provide feedback to help improve the project.

## Disclaimer

Keep in mind that Brik Kernel is a learning project and is not intended for production use. The project is provided as-is, and the authors make no warranties or guarantees about its functionality or security.