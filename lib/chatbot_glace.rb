require 'http'
require 'json'
require 'dotenv'


Dotenv.load('.env')


api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/engines/text-babbage-001/completions"


headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}


data = {
  "prompt" => "5 flavor of icecream, put each result line after line with - and a space betwen - and the result",
  "max_tokens" => 50,
  "n" => 5,
  "temperature" => 0.1

}


response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip


puts "Hello, voici 5 parfums de glace aléatoire :"
puts response_string