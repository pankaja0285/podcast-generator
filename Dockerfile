# TRY 3
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
  python3.12 \
  python3-pip \
  git

RUN pip3 install PyYAML==6.0.1

COPY feed.py /usr/bin/feed.py

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# # TRY 2
# # Use the latest Ubuntu image as the base
# FROM ubuntu:latest

# # Prevent interactive prompts during package installation
# ENV DEBIAN_FRONTEND=noninteractive

# # Install prerequisites and Python 3.12 via deadsnakes PPA
# RUN apt-get update && apt-get install -y \
#     software-properties-common \
#     && add-apt-repository ppa:deadsnakes/ppa \
#     && apt-get update && apt-get install -y \
#     python3.12 \
#     python3.12-dev \
#     python3-pip \
#     && rm -rf /var/lib/apt/lists/*

# # Install PyYAML specifically for the new Python version
# # Note: Ubuntu 24.04+ may require --break-system-packages if not using a venv
# RUN python3.12 -m venv /opt/venv
# ENV PATH="/opt/venv/bin:$PATH"
# RUN python3.12 -m pip install --upgrade pip
# RUN python3.12 -m pip install pyyaml

# # Copy your action code into the container
# COPY . /app
# WORKDIR /app

# # Set the entrypoint for the GitHub Action
# # This script will run when the container starts
# ENTRYPOINT ["python3.12", "/app/feed.py"]


# ****************  PREV ***********************************
# # NOTE: There cannot be any space between ubuntu: and latest
# # Otherwise it will keep giving error that the syntax is not correct
# # you need 1 or 3 arguments etc.,
# # get the latest ubuntu virtual machine
# FROM ubuntu:latest
# # NOTE: add -y for install so it doesn't sit at the prompt waiting for your answer
# # Install apt-get and with apt-get install python, python3-pip and git
# RUN apt-get update && apt-get install -y\
#     python3.12\
#     python3-pip\
#     git

# # Create virtual environment
# RUN python3 -m venv /opt/venv
# # Activate virtual environment by adding it to PATH
# ENV PATH="/opt/venv/bin:$PATH"
# # Install requirements in virtual environment
# RUN python3 -m pip install -r requirements.txt

# # COPY files from the repo to the docker container
# COPY feed.py /usr/bin/feed.py

# # COPY the entrypoint shell file as well but at the root level
# COPY entrypoint.sh /entrypoint.sh

# # Specify the ENTRYPOINT for this project, specifying the shellscript file to run
# # - so basically runs the specific file when this machine is finished procuring
# #  
# ENTRYPOINT [ "/entrypoint.sh" ]
