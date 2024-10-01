# Use the official Node.js image as the base image
FROM node:18

# Set the working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/brainstormerjr/HelloWorldOS.git .

# Install dependencies
RUN npm install -g http-server

# Expose the port the app runs on
EXPOSE 4000

# Command to run the app
CMD ["http-server", ".", "-p", "4000"]