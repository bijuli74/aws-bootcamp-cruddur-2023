require 'minitest/autorun'
require_relative 'function' # replace with your actual lambda function file

class TestImageUpload < Minitest::Test
  def setup
    @event = {
      'routeKey' => '',
      'headers' => {'authorization' => 'Bearer token'},
      'body' => '{"extension": "jpg"}',
      'requestContext' => {'authorizer' => {'lambda' => {'sub' => '1fc76104-fd4e-4f00-a9e9-ce413c66b4f5'}}}
    }
    @context = {}
  end

  def test_preflight_check
    @event['routeKey'] = "OPTIONS /{proxy+}"
    response = handler(event: @event, context: @context)
    assert_equal 200, response[:statusCode]
    assert_equal "https://bijuli.xyz", response[:headers]["Access-Control-Allow-Origin"]
  end

  def test_image_upload
    response = handler(event: @event, context: @context)
    assert_equal 200, response[:statusCode]
    assert_match /^https:\/\/.*/, JSON.parse(response[:body])["url"]
  end

  def test_without_authorization_header
    @event['headers'] = {}
    assert_raises KeyError do
      handler(event: @event, context: @context)
    end
  end

  def test_without_body
    @event['body'] = nil
    assert_raises JSON::ParserError do
      handler(event: @event, context: @context)
    end
  end
end
