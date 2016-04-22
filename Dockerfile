#
# Ruby Dockerfile
#
# https://github.com/rodolfobandeira/ruby-docker
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN	apt-get -y install software-properties-common && \
	add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get -y update
RUN apt-get -y install openjdk-8-jdk
RUN update-alternatives --config java
RUN update-alternatives --config javac
RUN https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
RUN dpkg -i elasticsearch-2.3.1.deb
RUN update-rc.d elasticsearch defaults

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git git-core htop man unzip vim wget && \
  apt-get install -y ruby ruby-dev ruby-bundler rbenv ruby-build && \
  apt=get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev && \ 
  apt-get install -y libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libgmp-dev && \
  apt-get install -y libcurl4-openssl-dev python-software-properties libffi-dev && \
  apt-get install -y mongodb imagemagick redis-server phantomjs
  rm -rf /var/lib/apt/lists/*

RUN cd
RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
RUN exec $SHELL
RUN rbenv install 2.2.2
RUN rbenv global 2.2.2



# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
