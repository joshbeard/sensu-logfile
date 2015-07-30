#!/usr/bin/env ruby
#
# Simple Sensu handler for writing notification events to a file
#

require 'rubygems'
require 'json'
require 'sensu-handler'

class LogFile < Sensu::Handler
  option :json_config,
         description: 'Configuration name',
         short: '-j JSONCONFIG',
         long: '--json JSONCONFIG',
         default: 'logfile'
  option :file,
         description: 'The file to write to',
         short: '-f    FILE',
         long: '--file FILE',
         default: '/tmp/sensu-events.txt'

  def setting(name)
    if defined?(settings[config[:json_config]][name])
      settings[config[:json_config]][name]
    end
  end

  def logfile
    setting('file') || config[:logfile]
  end

  def message
    message = <<-EOT
    #{Time.now}
             Host: #{@event['client']['name']}
          Address: #{@event['client']['address']}
        Timestamp: #{Time.at(@event['check']['issued'])}
            Check: #{@event['check']['name']}
           Output: #{@event['check']['output']}
           Status: #{@event['check']['status']}
          Command: #{@event['check']['command']}
      Occurrences: #{@event['occurrences']}
           Action: #{@event['action']}
         Interval: #{@event['check']['interval']}
    -------------------------------------------------------------------------------

    EOT
    message
  end

  def handle
    File.open(logfile, 'a') do |file|
      file.write(message)
    end
  end
end
