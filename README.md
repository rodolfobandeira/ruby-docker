## Ruby Dockerfile

### Installation

1. Install [Docker](https://www.docker.com/).

2. `git clone git@github.com:rodolfobandeira/ruby-docker.git;cd ruby-docker`

3. `docker build -t="rodolfobandeira/ruby" .`


### Usage

    docker run -it --rm rodolfobandeira/ruby-docker

#### Run `ruby`

    docker run -it --rm rodolfobandeira/ruby-docker ruby
