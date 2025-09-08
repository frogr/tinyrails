# frozen_string_literal: true

RSpec.describe Tinyrails do
  include Rack::Test::Methods

  it 'has a version number' do
    expect(Tinyrails::VERSION).not_to be nil
  end

  def app
    Tinyrails::Application.new
  end

  class TestsController < Tinyrails::Controller
    def an_action
      "Result!"
    end
  end

  it 'can make a request' do
    get '/tests/an_action'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Result!')
  end

  context 'when the file doesnt exist' do
    it 'displays the correct error' do
      get '/fake_route'
      expect(last_response).to_not be_ok
      expect(last_response.status).to eq(404)
      expect(last_response.body).to include("was not found")
    end
  end

  context 'when the action is missing from a controller' do
    it 'displays the correct error' do
      get '/tests/fake_action'
      expect(last_response).to_not be_ok
      expect(last_response.status).to eq(404)
      expect(last_response.body).to include("undefined method")
    end
  end
end
