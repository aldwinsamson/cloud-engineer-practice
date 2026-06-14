# Base image - official Python slim variant
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy application files
COPY app.py .

# Set environment variable defaults
ENV APP_ENV=production
ENV PORT=5000

# Document the port
EXPOSE 5000

# Health check - Docker will use this to monitor the container
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

# Run the application
CMD ["python", "app.py"]