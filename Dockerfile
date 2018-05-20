FROM phusion/passenger-ruby25:0.9.32
ENV HOME /root
CMD ["/sbin/my_init"]

# Keep OS up to date
RUN apt-get update \
 && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Always make sure we are on latest rubygems and bundler
RUN gem update --system
RUN gem update bundler

# Enable NGINX and Passenger
RUN rm -f /etc/service/nginx/down

# Remove default and add web configuration
RUN rm /etc/nginx/sites-enabled/default
ADD nginx/web.conf /etc/nginx/sites-enabled/web.conf

# Install bundle of gems
WORKDIR /tmp
ADD Gemfile* /tmp/
RUN bundle install
RUN rm -rf /tmp/* /var/tmp/*

COPY --chown=app:app . /var/www/app

WORKDIR /var/www/app/
