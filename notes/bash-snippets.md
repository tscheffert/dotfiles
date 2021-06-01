# Bash Snippets

## Parameter Expansion

```bash
local container_name="${1:?Must provide an image to check}"
```

## Stuff

### Debug some bash stuff

```bash
# Add to start of debug area
set -x

...

# Add after debug area
set +x
```

### Echo to STDERR instead of STDOUT

```bash
echo "This is text from echo that is going to STDERR, not STDOUT!"  1>&2

function warn {
  local message="${1:?Must provide a message to warn}"
  echo "$message" 1>&2
}
```

### Check whether a given executable exists

```bash
test_exists() {
  type $1 >/dev/null 2>&1
}

if ! test_exists expect; then
  echo "I expect you've done fucked up now"
fi
```

### Only do something if a command fails, with silenced output

Redirects are hard.

Redirect info: <https://mywiki.wooledge.org/BashFAQ/055>

```bash
if !my_command --arg thing >/dev/null 2>&1; then
  echo "my_command failed"
fi
```

TLDR:

`>/dev/null` will redirect STDOUT to `/dev/null` and `2>&1` will redirect STDERR to STDOUT (which is going to `/dev/null`)

### Run a command in a loop every few seconds

```
while sleep 5; do clear; <command>; done
```

### Run a command in a range

```
END=9; for ((i=1;i<=END;i++)); do knife cookbook delete role_common_app "123.456.$i" -y --config ~/.chef/sandbox/knife-dev.rb; done
```

### Timestamps
References:

- <https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations>
- <>

```bash
# Use ISO 8601 basic, meaning no dash or colons, in UTC
local timestamp=$(date --utc +"%Y%m%dT%H%M%SZ")
```

RFC-3559
```
date --utc +”%Y-%m-%dT%H:%M:%SZ”
```

### Docker functions

```bash
function ensure_docker_running {
  if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, but is required to build the PostgreSQL container. Please run docker and try again."  1>&2
    exit 1
  fi
}

function check_docker_container_running {
  local container_name="${1:?Must provide an image to check}"
  # Get the container status; ignoring errors by sending STDERR to /dev/null
  local container_status=$(docker inspect --type=container --format '{{.State.Running}}' "$container_name" 2>/dev/null)

  [[ "$container_status" = "true" ]]
}

function check_docker_container_existance {
  local container_name="${1:?Must provide an image to check}"
  docker inspect --type=container "$container_name" >/dev/null 2>&1
}


function check_docker_image_existance {
  local image_name="${1:?Must provide an image to check}"
  docker inspect --type=image "$image_name" >/dev/null 2>&1

  # Alternative:
  #   Used docker inspect to learn more about the generic inspect
  #
  #   docker image inspect "$image_name" >/dev/null 2>&1
}
```
