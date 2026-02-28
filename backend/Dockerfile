FROM node:20-alpine

WORKDIR /app

# Install dependencies first (cache layer)
COPY package.json ./
RUN npm install --production

# Copy source
COPY server.js ./

# Create uploads directory
RUN mkdir -p uploads/equipment

EXPOSE 4000

CMD ["node", "server.js"]
