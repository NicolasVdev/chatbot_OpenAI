require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')

$conversation_history = ""

def converse_with_ai
  api_key = ENV["OPENAI_API_KEY"]
  url = "https://api.openai.com/v1/engines/text-davinci-003/completions"

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  loop do
    input = gets.chomp
    prompt = $conversation_history + input

    data = {
      "prompt" => prompt,
      "max_tokens" => 150,
      "temperature" => 0,
      "n" => 1
    }

    response = HTTP.post(url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body.to_s)
    response_string = response_body['choices'][0]['text'].strip

    $conversation_history += "#{input}\n#{response_string}\n"
    puts response_string

    break if input.downcase == 'stop'
  end
end

converse_with_ai
