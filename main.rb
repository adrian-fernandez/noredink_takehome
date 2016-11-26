require './requires.rb'

challenge = QuizBuilder.new(3)
puts challenge.available_questions.map(&:to_s)