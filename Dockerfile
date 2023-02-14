FROM node:18.12.0-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.23-alpine
COPY --from=builder /app/dist /app
EXPOSE 80
COPY nginx.conf /etc/nginx/nginx.conf