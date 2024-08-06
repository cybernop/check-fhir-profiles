#!/bin/bash
cd $PROJECT_DIR/$SUSHI_ROOT
git config --global --add safe.directory $PROJECT_DIR

fhir restore
git checkout HEAD  -- fhirpkg.lock.json

sushi .

retVal=$?
if [ $retVal -ne 0 ]; then
    git checkout HEAD  -- fsh-generated
    printf "\nBuild failed! \n"
    exit $retVal
fi

cd $PROJECT_DIR
git diff --exit-code
retVal=$?

git checkout HEAD  -- $SUSHI_ROOT/fsh-generated

if [ $retVal -ne 0 ]; then
    printf "\nBuilt different! \n"
else
    printf "\nBuilt up-to-date! \n"
fi

exit $retVal
