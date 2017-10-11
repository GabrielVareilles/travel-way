class FetchReviewsService

  API_HOST = "https://api.yelp.com"
  SEARCH_PATH = "/v3/businesses/search"
  BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  TOKEN_PATH = "/oauth2/token"
  GRANT_TYPE = "client_credentials"


  # DEFAULT_BUSINESS_ID = "yelp-san-francisco"
  # DEFAULT_TERM = "dinner"
  # DEFAULT_LOCATION = "San Francisco, CA"
  # SEARCH_LIMIT = 5

  CLIENT_ID = ENV['YELP_ID']
  CLIENT_SECRET = ENV['YELP_SECRET']

  def initialize(business_id)
    @url = "https://api.yelp.com/v3/businesses/#{business_id}/reviews"
  end

  def call
    response = HTTP.auth(bearer_token).get(@url)
    response.parse
  end

  private

  def bearer_token
    # Put the url together
    url = "#{API_HOST}#{TOKEN_PATH}"

    raise "Please set your CLIENT_ID" if CLIENT_ID.nil?
    raise "Please set your CLIENT_SECRET" if CLIENT_SECRET.nil?

    # Build our params hash
    params = {
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      grant_type: GRANT_TYPE
    }


    response = HTTP.post(url, params: params)
    parsed = response.parse

    "#{parsed['token_type']} #{parsed['access_token']}"
  end

end
