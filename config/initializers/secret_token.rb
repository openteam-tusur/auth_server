# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Server::Application.config.secret_key_base = '72f2142e99ebb5ef9095672ced47cd38b107e06aa20ab4a171e48393839bcd856518b2c222b27f08dc351c3a88873cf24ca2d9026b6a5f9461558df71ff54aea'
