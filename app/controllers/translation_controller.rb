class TranslationController < ApplicationController
  def index
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["x-rapidapi-host"] = 'google-translate1.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV["RAPIDAPI_KEY"]
    request["accept-encoding"] = 'application/gzip'
    request["content-type"] = 'application/x-www-form-urlencoded'
    request.body = "source=ja&q=#{params[:translation]}&target=en"

    @response = http.request(request)
    result = JSON.parse(@response.body)

    @translated_text = result["data"]["translations"][0]["translatedText"]
  end
end
