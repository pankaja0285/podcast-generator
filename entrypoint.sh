!/bin/bash

# echo is useful for debugging, also when the action runs we can clearly 
# this section in the long list of commmands. And one can be as creative or 
# stick to what's useful, especially in the development stage
echo "============================"
# add a placeholder for the user name as ${GITHUB_ACTOR}
# - this allows to keep track of who's running the action
git config --global user.name "${GITHUB_ACTOR}"
# same way we do for the email as well --> ${INPUT_EMAIL}
git config --global user.email "${INPUT_EMAIL}"

# we add below to make sure that we can run the workflows
# - this will make sure we are adding it to safe list of directories
#   so, we can run git operations in here
git config --global --add safe.directory /github/workspace

# next we execute the python file 
# NOTE: here we are using python3
python3 /usr/bin/feed.py

# then push the podcast.xml that gets generated to git
# we then add, commit to git - in one go, or we can do as 2 separate commands
# one for add and one for commit
git add -A && git commit -m "Update Feed"

# git push and set upstream to enable tracking, we don't have to do it every time
# - but this is sort of like a new machine, we just make sure the upstream branch
#   is set up
git push --set-upstream origin main

echo "============================"
