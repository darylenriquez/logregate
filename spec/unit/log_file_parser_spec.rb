require 'helper/spec_helper'

describe LogFileParser do

  ["USER_ID_REGEX", "ACCEPTED_ENDS", "ACCEPTED_LOGS"].each do |constant|
    it "should have constant #{constant}" do
      expect(LogFileParser.const_defined?(constant)).to be true
    end
  end

  describe "#initialize" do
    let(:log_parser) { LogFileParser.new('spec/mock/sample.log') }

    context "when file does not exists" do
      it "should return the original gross_amount passed" do
        expect{LogFileParser.new('')}.to raise_exception(FileNotFound)
      end
    end

    context "when file exists" do
      ["@file", "@data"].each do |instance_var|
        it "should have instance variable #{instance_var}" do
          expect(log_parser.instance_variable_defined?(instance_var)).to be true
        end
      end
    end
  end

  describe "#readfile" do
    let(:log_parser) { LogFileParser.new('spec/mock/sample.log') }

    before do
      @data = log_parser.instance_variable_get("@data").dup

      log_parser.read_file
    end
    it "should change its @data instance variable" do
      expect(log_parser.instance_variable_get("@data")).not_to be @data
    end
  end

  describe "#present" do
    let(:log_parser) { LogFileParser.new('spec/mock/sample.log') }
    let(:expected_output) {
      """
                                              path count      response time(mean)  response time(median)     response time(mode)       hero dyno
    GET /api/users/{user_id}count_pending_messages 2430       25                   15                        11                        web.2
              GET /api/users/{user_id}get_messages 652        62                   32                        23                        web.11
      GET /api/users/{user_id}get_friends_progress 1117       111                  51                        35                        web.5
         GET /api/users/{user_id}get_friends_score 1533       228                  143                       67                        web.7
                          GET /api/users/{user_id} 561        52                   26                        26                        web.10
                         POST /api/users/{user_id} 2036       82                   46                        23                        web.11
"""
    }

    before { log_parser.read_file }

    it "should output the result in console" do
      expect{ log_parser.present }.to output(expected_output[1...expected_output.length]).to_stdout
    end
  end
end