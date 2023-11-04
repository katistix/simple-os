# This is the Dockerfile for the development environment

# For simplicity, we use ubuntu:latest as the base image
# Then we install the required packages to build the project

FROM ubuntu:latest

# Update the container's package index
RUN apt-get update

# Install git
RUN apt-get install -y git

# Install the required packages
RUN apt-get install -y nasm


# Set the working directory
WORKDIR /workspace

# Command to run your OS development environment
CMD ["/bin/bash"]