require 'rubygems'
require 'hpricot'
require 'net/http'
require 'config.rb'
 
def twitter(command, type=:get, opts={})
    twitter = Net::HTTP.start('twitter.com')
 
    case type
    when :get
        command << "?" + opts.map{|k,v| "#{k}=#{v}"}.join('&')
        req = Net::HTTP::Get.new(command)
 
    when :post
        req = Net::HTTP::Post.new(command)
        req.set_form_data(opts)
    end
 
    req.basic_auth($username, $password)
    
    response = twitter.request_head('/snf')
    puts "Status: " + response['status']
 
    return Hpricot(twitter.request(req).body)
end
