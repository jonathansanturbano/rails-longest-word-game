require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    dictionary(@word) && realword(@word)
  end

  def dictionary(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def realword(word)
    wordarray = word.chars
    wordarray.select do |gridletter|
      gridletter.include?(@letters)
    end
  end
end
