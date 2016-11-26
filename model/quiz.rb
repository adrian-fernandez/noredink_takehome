class Quiz
  attr_accessor :questions

  def initialize(num_questions)
    quiz_builder = QuizBuilder.new(num_questions)
    self.questions = quiz_builder.get_questions()
  end

  def to_s
    questions.each(&:to_s).join(', ')
  end
end