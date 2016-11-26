require './requires.rb'

fail 'Usage: main.rb <num_questions>' if ARGV.count != 1
quiz = Quiz.new(ARGV[0].to_i)

puts quiz.to_s