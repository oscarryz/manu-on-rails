require "net/http"
class FetchArticlesJob < ApplicationJob
  queue_as :default

  def perform(*args)

    response = Net::HTTP.get(URI("https://oscarryz.com/feed.json"))
    json_feed = JSON.parse(response)
    json_feed["items"].each do |article|
      Article.find_or_create_by( original_id: article["id"]) do |new_article|
        new_article.title = article["title"]
        new_article.body  = article["content_html"]
      end
    end
    puts "Articles fetched"



  end
end
