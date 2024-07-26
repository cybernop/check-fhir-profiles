#!/bin/bash
cd $PROJECT_DIR/$SUSHI_ROOT
git config --global --add safe.directory $PROJECT_DIR

fhir restore
git checkout HEAD  -- fhirpkg.lock.json

sushi .

retVal=$?
if [ $retVal -ne 0 ]; then
    git checkout HEAD  -- fsh-generated
    exit $retVal
fi

cd $PROJECT_DIR
git diff --exit-code
retVal=$?

git checkout HEAD  -- $SUSHI_ROOT/fsh-generated
exit $retVal
