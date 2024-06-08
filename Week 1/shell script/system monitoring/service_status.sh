#!/bin/bash

# List of critical services
SERVICES=("nginx" "mysql" "redis")

# Function to check service status
function check_service {
    if ! systemctl is-active --quiet $1; then
        echo "$1 service is not running!" | mail -s "$1 service down!" admin@example.com
    fi
}

# Check each service and send alerts if necessary
for SERVICE in "${SERVICES[@]}"; do
    check_service $SERVICE
done

echo "Service status check complete."
