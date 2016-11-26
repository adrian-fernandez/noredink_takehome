class QuizBuilder
  attr_accessor :available_questions,
                :questions_statistics,
                :usages_statistics

  def initialize(num_questions)
    fail 'num_questions must be greater than zero' unless num_questions > 0

    initialize_data
    selected_questions = select_questions(num_questions)
  end

  private

  def select_questions(num)
    select_data = build_select_data(num)
  end

  def build_select_data(num)
    result = Array.new

    avg_questions_per_strand = num.to_f / self.questions_statistics[:num_strands]

    self.available_questions.keys.each do |strand_id|
      num_to_select = avg_questions_per_strand.ceil
      avg_questions_per_standard = num_to_select.to_f / self.available_questions[strand_id].keys.count

      self.available_questions[strand_id].keys.each do |standard_id|
        puts "Questions from standard: #{self.available_questions[strand_id][standard_id].map(&:to_s)}"
      end

      self.available_questions

    end


    puts "AVG per strand: #{avg_questions_per_strand}"
  end

  def initialize_data
    questions = DataLoader.get_questions
    available_usages = DataLoader.get_usages
    questions.each { |question| question.update_usages!(available_usages) }

    questions.sort!

    self.available_questions = Question.build_hash(questions)
    build_statistics_questions(questions.count)
  end

  def build_statistics_questions(num_questions)
    self.questions_statistics = Hash.new

    self.questions_statistics[:total] = num_questions

    self.questions_statistics[:num_strands] = available_questions.keys.count
    self.questions_statistics[:num_standards] = Hash.new
    (1..self.questions_statistics[:num_strands]).each do |i|     
      self.questions_statistics[:num_standards][i] = available_questions[i.to_s].keys.count
    end

    puts self.questions_statistics.inspect
  end

end