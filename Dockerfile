# WORKING Version
# Use an official Python 3.12 Debian-based image
FROM python:3.12-slim

# Install build deps if needed (apt update included), then clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for your app (absolute path recommended)
# (Avoid relying on WORKDIR overriding behavior when GitHub mounts GITHUB_WORKSPACE;
# see the docs linked above if using this image for Actions containers.)
WORKDIR /usr/src/app

# Copy application files (adjust as needed)
COPY . /usr/src/app

# Install Python dependencies
RUN python -m pip install --upgrade pip \
    && pip install pyyaml

# Example entrypoint script pattern (make sure script is executable in repo)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# ********************************************************************************************

# # Specify the ENTRYPOINT for this project, specifying the shellscript file to run
# # - so basically runs the specific file when this machine is finished procuring
# #  
# ENTRYPOINT [ "/entrypoint.sh" ]
