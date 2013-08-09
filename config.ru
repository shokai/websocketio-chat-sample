require 'rubygems'
require 'bundler/setup'
Bundler.require
if development?
  $stdout.sync = true
  require 'sinatra/reloader'
end
require 'sinatra/websocketio'

require File.dirname(__FILE__)+'/main'

set :haml, :escape_html => true
set :websocketio, :port => 9000

run Sinatra::Application
