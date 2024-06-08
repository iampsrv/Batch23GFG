#!/bin/bash
find "/backup/" -type f -mtime +5 -exec rm {} \;