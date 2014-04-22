#! /bin/sh

# Make sure bundler is installed
gem install bundler

# Install gems from Gemfile
bundle

# Install dependencies from Podfile
bundle exec pod install
