## Ruby Dockerfile

### Installation

1. Install [Docker](https://www.docker.com/).

2. `git clone git@github.com:rodolfobandeira/ruby-docker.git`

3. `cd ruby-docker`

4. `./setup.sh` (This processes could take 10 minute)s

### Usage

    docker run -it --rm ruby-docker

or:

    `./execute-bash-on-container.sh`

#### Run `ruby`

    docker run -it --rm ruby-docker ruby
