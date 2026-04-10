# NOTE: There cannot be any space between ubuntu: and latest
# Otherwise it will keep giving error that the syntax is not correct
# you need 1 or 3 arguments etc.,
# get the latest ubuntu virtual machine
FROM ubuntu:latest
# NOTE: add -y for install so it doesn't sit at the prompt waiting for your answer
# Install apt-get and with apt-get install python, python3-pip and git
RUN apt-get update && apt-get install -y\
    python3.12\
    python3-pip\
    git

# Next RUN to install pyyaml
# RUN pip install pyyaml
RUN python3 -m pip install -r requirements.txt

# COPY files from the repo to the docker container
COPY feed.py /usr/bin/feed.py

# COPY the entrypoint shell file as well but at the root level
COPY entrypoint.sh /entrypoint.sh

# Specify the ENTRYPOINT for this project, specifying the shellscript file to run
# - so basically runs the specific file when this machine is finished procuring
#  
ENTRYPOINT [ "/entrypoint.sh" ]

