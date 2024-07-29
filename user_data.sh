#!/bin/bash
# Update the package index
yum update -y

# Install Apache
yum install -y httpd

# Start Apache
systemctl start httpd

# Enable Apache to start on boot
systemctl enable httpd

# Create a simple index.html file
echo "<html><h1>Welcome to the Apache server</h1></html>" > /var/www/html/index.html