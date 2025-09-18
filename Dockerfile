# Base image
FROM nginx:alpine

# Copy all portfolio files to nginx html folder
COPY . /usr/share/nginx/html

# Expose nginx port
EXPOSE 80

# Default command
CMD ["nginx", "-g", "daemon off;"]
