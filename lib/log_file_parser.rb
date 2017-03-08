class LogFileParser
  USER_ID_REGEX = "(.[^\/]+)"
  ACCEPTED_ENDS = [
    ['\/count_pending_messages', ['GET']],
    ['\/get_messages', ['GET']],
    ['\/get_friends_progress', ['GET']],
    ['\/get_friends_score', ['GET']],
    ['', ['GET', 'POST']]
  ]
  ACCEPTED_LOGS = ACCEPTED_ENDS.inject([]) do |items, ends|
    items + ends[1].map{|method| /method=#{method} path=\/api\/users\/#{USER_ID_REGEX}#{ends[0]} / }
  end

  def initialize(path)
    raise FileNotFound unless File.exists?( path )

    @file = File.open(path)
    @data = ACCEPTED_LOGS.inject({}) do |result, log_key|
      result.merge({ log_key => { count: 0, response_times: [], dyno: {} } })
    end
  end

  def read_file
    @file.each_line{|line| process_line(line) }
  end

  def present
    printf "%50s %-10s %-20s %-25s %-25s %s\n", 'path', 'count', 'response time(mean)', 'response time(median)', 'response time(mode)', 'hero dyno'

    @data.each do |key, value|
      printf *[
        "%50s %-10s %-20d %-25d %-25s %s\n",
        key.source.gsub('method=', '').gsub('path=', '').gsub(USER_ID_REGEX, '{user_id}').strip,
        value[:count],
        CollectionMath.mean(value[:response_times]),
        CollectionMath.median(value[:response_times]),
        CollectionMath.mode(value[:response_times]),
        CollectionMath.highest_value(value[:dyno]).join(',')
      ]
    end
  end

  private
  def process_line(line)
    if matcher = ACCEPTED_LOGS.find{|regex| !regex.match(line).nil? }
      dyno = line[/dyno=(.*?) /, 1]
      connect_time = line[/connect=(.*?)ms/, 1].to_i
      service_time = line[/service=(.*?)ms/, 1].to_i

      @data[matcher][:count] += 1
      @data[matcher][:response_times] << connect_time + service_time
      @data[matcher][:dyno][dyno] = (@data[matcher][:dyno][dyno] || 0) + 1
    end
  end
end