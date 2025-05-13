## Vue Maintenance Task Application

### Description
This application is a Vue.js-based maintenance task manager with CRUD functionality, utilizing a multi-select for equipment management. It uses Nginx as the web server and is containerized using Docker.

### Prerequisites
- Node.js (v18+)
- Docker
- Docker Compose (optional)

### Running Locally
1. Clone the repository:
   ```bash
   git clone https://github.com/adrianescobar/inventory-web-app.git
   cd inventory-web-app
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file:
   ```bash
   VITE_API_BASE_URL=http://localhost:8080
   ```
4. Start the development server:
   ```bash
   npm run dev
   ```
5. Visit:
   ```
   http://localhost:5173
   ```

### Building and Running with Docker
1. Build the Docker image:
   ```bash
   docker build -t inventory-web-app .
   ```
2. Run the container:
   ```bash
   docker run -d -p 80:80 -e API_BASE_URL=http://backend:8080 inventory-web-app
   ```
3. Access the application:
   ```
   http://localhost
   ```

### Environment Variables
- `VITE_API_BASE_URL` - Base URL for API requests.
- `API_BASE_URL` - Nginx runtime environment variable.

### Project Structure
- `src/` - Vue.js application files
- `Dockerfile` - Docker build configuration
- `nginx.conf` - Nginx server configuration
