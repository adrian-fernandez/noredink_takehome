class QuizBuilder
  attr_accessor :available_questions,
                :available_usages

  def initialize
    initialize_data
  end

  private

  def initialize_data
    self.available_questions = DataLoader.get_questions
    self.available_usages = DataLoader.get_usages
  end

end