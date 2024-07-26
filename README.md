# Check FHIR Profiles Image

Run the check with for repository checked out at `<repository dir>`. This needs to be a git repository and be switch to the branch one wants to check.

```bash
docker run --rm [-e SUSHI_ROOT=<sushi root>] -v <repository dir>:/project fhir-check
```

If your sushi project is not located at the root of the repository, one can specify its relative path with `-e SUSHI_ROOT=<sushi root>`.
