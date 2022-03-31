class ApplicationJob < ActiveJob::Base
  delegate :logger, to: 'Rails'
  logger = Logger.new('./log/dev/logfile.log')
end
