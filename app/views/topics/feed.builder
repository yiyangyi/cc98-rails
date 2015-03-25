xml.instruct! :xml, version: "1.0"
xml.rss(version: "2.0") do
  xml.channel do
  	xml.title ""
  	xml.description ""
  	xml.link root_url
  	xml.language "en-US"

  	for topic in @topics
  	  xml.item do
  	  	xml.title       topic.title
  	  	xml.description topic.html
  	  	xml.author      topic.user.login
  	  	xml.pubDate     topic.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
  	  	xml.link        topic_url topic
  	  end
  	end
  end	
end