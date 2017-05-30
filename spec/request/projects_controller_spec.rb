require 'rails_helper'

RSpec.describe "ProjectsController", type: :request do
  describe 'GET /api/v1/requestproject.json' do
    it 'will retrieve project with the highest cost' do
      get '/api/v1/requestproject.json'
      expect(JSON.parse(response.body)).to eql(
        'id' => 4,
        'creationDate' => '05112017 00:00:00',
        'expiryDate' => '05202018 00:00:00',
        'projectCost' => 8.5,
        'projectName' => 'test project number 1',
        'projectUrl' => 'http://www.unity3d.com',
        'targetCountries' => ['USA', 'CANADA', 'MEXICO', 'BRAZIL'],
        'targetKeys' => [{'number'=>25, 'keyword'=>'movie'}, {'number'=>30, 'keyword'=>'sports'}]
        )
    end
  end
  describe 'GET /api/v1/requestproject.json?country=YES' do
    it 'will retrieve project with the highest cost and country YES' do
      get '/api/v1/requestproject.json?country=YES'
      expect(JSON.parse(response.body)).to eql(
        'id' => 3,
        'creationDate' => '05112017 00:00:00',
        'expiryDate' => '05202018 00:00:00',
        'projectCost' => 7.5,
        'projectName' => 'test project number 1',
        'projectUrl' => 'http://www.unity3d.com',
        'targetCountries' => ['YES', 'CANADA', 'MEXICO', 'BRAZIL'],
        'targetKeys' => [{'number'=>50, 'keyword'=>'movie'}, {'number'=>30, 'keyword'=>'sports'}]
        )
    end
  end
  describe 'GET /api/v1/requestproject?number=100' do
    it 'will retrieve project with the highest cost and country YES' do
      get '/api/v1/requestproject.json?number=100'
      expect(JSON.parse(response.body)).to eql(
        'message' => 'no project found'
        )
    end
  end
end