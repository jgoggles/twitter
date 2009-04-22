#!/usr/bin/env ruby

require 'twitter.rb'

doc = twitter('/statuses/update.xml', :post, 'status' => ARGV[0])

(doc/'status').each do |st|
  @text = (st/'text').inner_html
  @created_at = (st/'created_at').inner_html
  @message_id = (st/'id').inner_html
  
  (st/'user').each do |u|
    @user = (u/'screen_name').inner_html
    @user_id = (u/'id').inner_html
  end
  
end

puts "#{@user}-( Message ID:#{@message_id})"
puts "Date: #{DateTime.parse(@created_at).strftime('%m/%d/%Y - %k:%M:%S')}"
puts "#{@text}"
