FROM node:20-alpine

WORKDIR /app

# Install the angular application dependencies.
COPY package.json ./
RUN npm install

# Copy the angular application files.
COPY . ./

# Build the angular application.
CMD [ "npm", "run", "build" ]
