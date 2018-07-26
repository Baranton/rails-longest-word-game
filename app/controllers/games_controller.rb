require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = ""
    10.times do
      @letters << " #{alphabet[rand(25)]}"
    end
  end

  def score
    @answer = params[:answer].split("")
    @letters = params[:letters].split(" ")
    @solution = ""
    if !letters_included(@answer, @letters)
      @solution = "Forbidden letters selected"
    elsif !dico_check(params[:answer])
      @solution = "Not english"
    else
      @solution = "Valid answer"
    end
  end

  def letters_included(answer, letters)
    answer.each do |letter|
      if letters.include? "#{letter}"
        return true
      else
        return false
      end
    end
  end

  def dico_check(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    data = JSON.parse(open(url).read)
    data["found"]
  end

end


