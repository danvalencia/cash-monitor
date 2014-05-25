#! /usr/local/rvm/rubies/ruby-1.9.3-p327/bin/ruby
require_relative 'event'

include Event

create_session
sleep 0.1
coin_insert 1
close_session