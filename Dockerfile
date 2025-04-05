# Use an existing base image as the starting point
FROM ubuntu:20.04 AS build

# Update the package list
RUN apt-get update

# Install NASM and LD
RUN apt-get install -y nasm binutils

# Copy the assembly code into the container
COPY helloworld.asm /app/
COPY conditional.asm /app/
COPY loop.asm /app/

# Assemble and link the code
RUN nasm -f elf -o /app/helloworld.o /app/helloworld.asm
RUN ld -m elf_i386 -s -o /app/helloworld /app/helloworld.o

RUN nasm -f elf -o /app/conditional.o /app/conditional.asm
RUN ld -m elf_i386 -s -o /app/conditional /app/conditional.o

RUN nasm -f elf -o /app/loop.o /app/loop.asm
RUN ld -m elf_i386 -s -o /app/loop /app/loop.o

# Use a minimal image as the final image
FROM alpine:latest

# Copy the executable from the build stage
COPY --from=build /app/helloworld /app/
COPY --from=build /app/conditional /app/
COPY --from=build /app/loop /app/

# Copy the script
COPY run_assemblies.sh /app/run_assemblies.sh

# Give execute permissions to the script and binaries
RUN chmod +x /app/run_assemblies.sh /app/helloworld /app/conditional /app/loop

# Run the executable
CMD ["/bin/sh", "/app/run_assemblies.sh"]