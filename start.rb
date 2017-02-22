require './config/loader'

module Logregate
  class Application
    class << self
      def start
        file_path  = ARGV[0] || 'sample.log'
        log_parser = LogFileParser.new(file_path)

        log_parser.read_file
        log_parser.present
      end
    end
  end
end

Logregate::Application.start