Rails.configuration.workable_token = if Rails.env.test?
                                       'FAKE-KEY'
                                     else
                                       ENV.fetch('WORKABLE_TOKEN')
                                     end

