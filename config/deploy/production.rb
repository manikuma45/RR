# frozen_string_literal: true

server '54.250.61.57', user: 'app', roles: %w[app db web]
set :ssh_options, keys: '/Users/apple/.ssh/id_rsa'
