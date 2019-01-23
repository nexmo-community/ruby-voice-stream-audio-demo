# Nexmo Ruby Stream Audio To Call Demo

A demo that streams an audio file to an in-progress phone call with Ruby using Sinatra and the [Nexmo Voice API](LINK).

### Usage

* Clone this repository
* Sign up for a [Nexmo account](https://dashboard.nexmo.com/sign-up)
* Create a Nexmo application using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli)
* Fill in the environment variables in `.env.sample` and rename it to `.env`
* Follow [these instructions](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) to make your local server externally accessible with `ngrok`
* Add your `ngrok` url to the `BASE_URL` variable in `server.rb`
* Run `ruby server.rb`
* Visit [http://localhost:4567/new](http://localhost:4567/new)
* You will receive a phone call with the sample audio streaming when it is answered

## License

This sample is released under the [MIT License](LICENSE)