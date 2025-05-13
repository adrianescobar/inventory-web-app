# Build Stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Production Stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Copy the Nginx configuration template
COPY nginx.conf /etc/nginx/nginx.template.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port on which the app will run
EXPOSE 80

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
