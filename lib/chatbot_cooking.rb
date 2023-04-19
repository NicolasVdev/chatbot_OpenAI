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
  "prompt" => "Génère pour moi une recette de cuisine aléatoire en français avec 5 étapes. Utilise un tiret - devant chaque étape.",
  "max_tokens" => 100,
  "temperature" => 0.5,
  "n" => 10,
  "stop" => "\n-\n"
}


response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip


puts "Hello, voici 1 recette de cuisine aléatoire :"
puts response_string