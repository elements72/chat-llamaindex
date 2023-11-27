FROM node:latest
 
# Create app directory
RUN mkdir -p ./src
WORKDIR ./src

# Copy files
COPY . .
 
RUN npm install -g

# Add your application code here

CMD python3 -m http.server