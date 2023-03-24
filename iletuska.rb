require 'open-uri'
require 'nokogiri'
require 'json'

url = "https://tvp.info"  # Replace with your desired URL
search_words = ["Tusk", "Kaczyńsk", "Morawiec"]  # Replace with your desired search words

# Define the user agent string
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36"

# Download the webpage and create a Nokogiri document with the user agent set in the headers
html = URI.open(url, "User-Agent" => user_agent).read
document = Nokogiri::HTML.parse(html)
f = "results.json"

# Get the current date and time as a Unix timestamp
current_time = Time.now.iso8601

# Create an empty file
unless File.exist?(f)
  File.new(f, "w")
end

results = {}


# Loop through the search words and count the number of occurrences of each word
search_words.each do |word|
  # Split the document text into words
  words = document.css('body').text.split(/\W+/)
  
  # Count the number of instances of the search word
  word_count = words.count { |w| w.downcase.include?(word.downcase) }

  # Add the word count to the results hash for the current timestamp
  if results[current_time].nil?
    results[current_time] = {}
  end
  results[current_time][word] = word_count
end

# Write the updated results hash to the results JSON file
File.write(f, JSON.generate(results)+"\n", File.size(f), mode: 'a')