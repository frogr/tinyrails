# frozen_string_literal: true

RSpec.describe Tinyrails do
  include Rack::Test::Methods

  it 'has a version number' do
    expect(Tinyrails::VERSION).not_to be nil
  end

  def app
    Tinyrails::Application.new
  end

  it 'can make a request' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Hello')
  end
end
