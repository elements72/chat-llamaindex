
FROM node:latest
 
# Create app directory
RUN mkdir -p ./src
WORKDIR ./src

# Copy files
COPY . .
 
RUN npm install -g npm

# Add your application code here
