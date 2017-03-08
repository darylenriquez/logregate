# logregate

A piece of code that aggregates log file data:

```
                                              path count      response time(mean)  response time(median)     response time(mode)       hero dyno
  GET /api/users/{user_id}\/count_pending_messages 2430       25                   15                        11                        web.2
            GET /api/users/{user_id}\/get_messages 652        62                   32                        23                        web.11
    GET /api/users/{user_id}\/get_friends_progress 1117       111                  51                        35                        web.5
       GET /api/users/{user_id}\/get_friends_score 1533       228                  143                       67                        web.7
                          GET /api/users/{user_id} 0          0                    0                                                   
                         POST /api/users/{user_id} 2022       82                   46                        23                        web.11
```

run `ruby start.rb` to run the code.

There are tests <3: `rspec`. I did not get it the first time so I updated the sample log file for test using data I actually can compute and can compare.
