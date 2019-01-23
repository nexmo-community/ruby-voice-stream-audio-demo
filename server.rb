require 'sinatra'
require 'nexmo'
require 'dotenv'
require 'json'

# Load environment variables
Dotenv.load

# Set Up Nexmo Credentials
client = Nexmo::Client.new(
  api_key: ENV['api_key'],
  api_secret: ENV['api_secret'],
  application_id: ENV['application_id'],
  private_key: File.read(ENV['private_key_path'])
)

# ngrok URL Goes Here
BASE_URL = ''

# Audio File
AUDIO_URL = "#{BASE_URL}/voice_api_audio_streaming.mp3"

# Server Routes
get '/new' do
  # Start call
  response = client.calls.create(
    to: [{ type: 'phone', number: ENV['sender_phone'] }],
    from: { type: 'phone', number: ENV['recipient_phone'] },
    answer_url: ["#{BASE_URL}/answer"],
    event_url: ["#{BASE_URL}/event"]
  )
  puts response.inspect
end

get '/answer' do
    # Provide the Nexmo Call Control Object (NCCO) as JSON to the Nexmo Platform
    content_type :json
    [{ :action => 'stream', :streamUrl => ["#{BASE_URL}/stream/silent"], :loop => 0 }].to_json
end

get '/stream/silent' do
    # Stream a silent file in the background to keep the call open
    send_file File.join(settings.public_folder, 'silence.mp3')
end

post '/event' do
  # Get call status
  data = JSON.parse(request.body.read)
  # Stream audio if call is answered
  response = client.calls.stream.start(data['uuid'], stream_url: [AUDIO_URL]) if data['status'] == 'answered'
  # Print out the response from the Nexmo platform
  puts response.inspect
end