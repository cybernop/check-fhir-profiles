# Check FHIR Profiles Image

Run the check with for repository checked out at `<repository dir>`. This needs to be a git repository and be switch to the branch one wants to check.

```bash
docker run --rm -u $(id -u):$(id -g) \
    [-e SUSHI_ROOT=<sushi root>] \
    -v <repository dir>:/project \
    ghcr.io/cybernop/check-fhir-profiles:<sushi version>
```

With `<sushi version>` one can specify which version of FSH Sushi to use for checking. Currently the following versions are supported:

* `3.11.0`

If your sushi project is not located at the root of the repository, one can specify its relative path with `-e SUSHI_ROOT=<sushi root>`.
