require_relative 'spec_helper'

require 'libis/services/primo/search'
require 'libis-tools'

describe 'Primo search service' do
  let(:subject) { Libis::Services::Primo::Search.new }

  context 'query' do

    it 'default return result' do
      result = subject.query 'foo'
      expect(result.keys).to eq [:count, :from, :to, :step, :data]
      expect(result[:data].size).to eq [result[:count], result[:step] - 1].min
    end

  end

  context 'find' do

    it 'default return result' do
      result = subject.query 'foo'
      count = result[:count]
      result = subject.find 'foo'
      expect(result).to be_a Array
      expect(result.size).to eq count
    end

    it 'limit number of results' do
      result = subject.query 'foo', step: 1
      count = result[:count] / 2
      result = subject.find 'foo', max_count: count
      expect(result).to be_a Array
      expect(result.size).to eq count
    end

  end

  end
