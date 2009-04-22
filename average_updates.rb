#!/usr/bin/env ruby

require 'twitter.rb'

# doc = twitter('/statuses/friends_timeline.xml')
# doc = twitter('/statuses/show.xml', :get, {:id => 1374254546})
# doc = twitter('/statuses/user_timeline.xml', :get, {:id => 'snf', :count => 5})
# doc = twitter('/statuses/destroy/15788551193557601.xml', :post)
# doc = twitter('/statuses/update.xml', :post, {:status => "Globals"})
doc = twitter('/statuses/update.xml', :post, 'status' => ARGV[0])
 
 
(doc/'status').each do |st|
  @text = (st/'text').inner_html
  followers = (st/'followers_count').inner_html
  following = (st/'friends_count').inner_html
  following_back = (st/'follow').inner_html
  created_at = (st/'created_at').inner_html
  status_id = (st/'id').inner_html
  (st/'user').each do |u|
    @user = (u/'screen_name').inner_html
    @user_id = (u/'id').inner_html
    @user_website = (u/'url').inner_html
  end
  puts "#{@user}-(ID:#{@user_id})"
  puts "Website: #{@user_website}"
  puts "Date: #{created_at}"
  puts "#{@text}"
end

(doc/'hash').each do |response|
  request = (response/'request').inner_html
  error = (response/'error').inner_html
  puts "#{request}"
  puts "#{error}"
end