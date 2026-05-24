# Stage 1: Build the application
FROM node:18-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

# Stage 2: Create the final image
FROM node:18-alpine

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app/node_modules ./node_modules
COPY . .

RUN npm prune --production

EXPOSE 3000

USER node

CMD ["npm", "index.js"]
