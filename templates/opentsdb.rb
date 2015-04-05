Eye.application 'opentsdb' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/opentsdb-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :opentsdb do
    pid_file '/var/hadoop/opentsdb.pid'
    start_command 'sudo -E -u hadoop PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/java/jdk1.8.0_11/bin JAVA_HOME=/usr/java/jdk1.8.0_11 /opt/opentsdb/build/tsdb tsd'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
