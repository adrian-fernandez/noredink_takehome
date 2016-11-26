class QuizBuilder
  attr_accessor :available_questions,
                :questions_statistics,
                :available_usages,
                :usages_statistics

  def initialize(num_questions)
    fail 'num_questions must be greater than zero' unless num_questions > 0

    initialize_data
  end

  private

  def select_questions(num)
    
  end

  def initialize_data
    self.available_questions = DataLoader.get_questions
    build_statistics_questions

    self.available_usages = DataLoader.get_usages
    build_statistics_usages
  end

  def build_statistics_questions
    questions_statistics = Hash.new

    questions_statistics[:total] = available_questions.count
    questions_statistics[:num_strands] = available_questions.map(&:strand_id).uniq.count

    questions_statistics[:num_standards] = Hash.new
    (1..questions_statistics[:num_strands]).each do |i|     
      questions_statistics[:num_standards][i] = available_questions.select do |question|
                                                  question.strand_id == i
                                                end.map(&:standard_id).uniq.count
    end
  end

  def build_statistics_usages

  end

end