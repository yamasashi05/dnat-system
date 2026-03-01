FROM node:20-alpine
WORKDIR /app
COPY package.json ./
RUN npm install --production
COPY server.js ./
RUN mkdir -p uploads/equipment
EXPOSE 4000
CMD ["node", "server.js"]