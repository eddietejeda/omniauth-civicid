# Omniauth::Civicid

An Omniauth strategy for authenticating using CivicID.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-civicid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-civicid

## Usage

Add the strategy to your application:

    use OmniAuth::Builder do
      provider :civic_id, {
        :app_id      => 'Your app id',
        :app_secret  => 'Your app secret', 
        :scope       => 'The scope', 
        :environment => 'Your desired environment' 
      }
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
