require './config/loader'

module Logregate
  class Application
    class << self
      def start
        log_parser = LogFileParser.new('sample.log')

        log_parser.read_file
        log_parser.present
      end
    end
  end
end

Logregate::Application.start