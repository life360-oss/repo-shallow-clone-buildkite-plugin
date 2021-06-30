# Repo Shallow Clone Buildkite Plugin
A Buildkite plugin to execute shallow clones for the git checkout process.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: ls
    plugins:
      - life360/repo-shallow-clone#v1.0.0:
          depth: 1
          run_on_pull_requests: false
```

## Configuration

### `depth` (Optional, number)

The depth to execute the shallow clone. (`default = 1`).

### `run_on_pull_requests` (Required, boolean)

Defines if the rule to execute a shallow clone should be applied to pull requests as well.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
