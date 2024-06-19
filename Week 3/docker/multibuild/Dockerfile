# Stage 1: Build stage
FROM python:3.9-alpine AS builder

RUN apk update && \
    apk add --no-cache build-base

WORKDIR /app
COPY req.txt .
RUN pip install --no-cache-dir -r req.txt

# Stage 2: Production stage
FROM python:3.9-alpine

WORKDIR /app
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY . .

# Remove cached package files
RUN rm -rf /var/cache/apk/*

EXPOSE 8080
CMD ["python3", "app.py"]
