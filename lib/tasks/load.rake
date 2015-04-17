require 'nokogiri'
require 'open-uri'
require 'json'

namespace :api do
  task load: :environment do
    base_url = 'https://thelistservearchive.com'
    page = Nokogiri::HTML(open(base_url))
    ng_links = page.css('li a')
    bare_links = ng_links.map { |l| l['href'] }
    bare_links.each do |link|
      begin
        email = JSON.parse(open(base_url + link.split('/')[0..3].join('/') + '.json').read)[0]['post']
        email['sent_date'] = Date.new(*email['date'])
        email.delete('date')
        unless Post.find_by(sent_date: email['sent_date'])
          if Post.create(email)
            puts "Loaded #{email['date']} email."
          end
        end
      rescue Exception => e
        puts e
        next
      end
    end
  end
end
