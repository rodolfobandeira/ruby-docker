#
# Ruby Dockerfile
#
# https://github.com/rodolfobandeira/ruby-docker
#

# Pull base image.
FROM ubuntu

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y install software-properties-common && \
	add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get -y update && \
  apt-get -y install openjdk-8-jdk wget
RUN update-alternatives --config java
RUN update-alternatives --config javac
RUN cd ~
RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
RUN dpkg -i elasticsearch-2.3.1.deb
RUN update-rc.d elasticsearch defaults

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git git-core htop man unzip vim wget && \
  apt-get install -y ruby ruby-dev ruby-bundler rbenv ruby-build && \
  apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev && \ 
  apt-get install -y libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libgmp-dev && \
  apt-get install -y libcurl4-openssl-dev python-software-properties libffi-dev && \
  apt-get install -y mongodb imagemagick redis-server phantomjs && \
  rm -rf /var/lib/apt/lists/*

RUN cd ~
# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# Install multiple versions of ruby
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./versions.txt /root/versions.txt
RUN xargs -L 1 rbenv install < /root/versions.txt

# Install Bundler for each version of ruby
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv global $v; gem install bundler; done'

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

