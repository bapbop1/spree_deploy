#/docker_start.sh
#!/bin/bash

/bin/bash -l -c "bundle check || bundle install"
/bin/bash -l -c "rm tmp/pids/server.pid"

/bin/bash -l -c "bundle exec rails s -b 0.0.0.0"