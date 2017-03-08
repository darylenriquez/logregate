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
   GET /api/users/{user_id}/count_pending_messages 3          13                   3                         3                         web.12
             GET /api/users/{user_id}/get_messages 3          15                   6                         6                         web.12
     GET /api/users/{user_id}/get_friends_progress 1          33                   33                        33                        web.12
        GET /api/users/{user_id}/get_friends_score 1          2                    2                         2                         web.12
                          GET /api/users/{user_id} 3          12                   2                         2                         web.12
                         POST /api/users/{user_id} 1          4                    4                         4                         web.12
"""
    }

    before { log_parser.read_file }

    it "should output the result in console" do
      expect{ log_parser.present }.to output(expected_output[1...expected_output.length]).to_stdout
    end
  end
end