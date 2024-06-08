#!/bin/bash
echo "Enter password length: "
read length
openssl rand -base64 48 | cut -c1-$length
