class QuizBuilder
  attr_accessor :available_questions,
                :questions_statistics,
                :usages_statistics,
                :selected_questions

  def initialize(num_questions)
    fail 'num_questions must be greater than zero' unless num_questions > 0

    initialize_data
    self.selected_questions = select_questions(num_questions)
  end

  def get_questions
    return self.selected_questions
  end

  private

  def select_questions(num)
    selected_questions = build_selected_questions(num)
    debug_data selected_questions.map(&:to_s)
    debug_data "Selected: #{selected_questions.count}"

    return selected_questions
  end

  def build_selected_questions(num)
    result = Array.new

    avg_questions_per_strand = num.to_f / self.questions_statistics[:num_strands]
    to_add_strand = 0
    to_add_standard = []
    avg_questions_per_standard = 0
    num_per_strand = avg_questions_per_strand.ceil

    self.available_questions.keys.each do |strand_id|
      debug_data "STRAND_ID = #{strand_id}"
      debug_data ""

      avg_questions_per_standard = num_per_strand.to_f / self.available_questions[strand_id].keys.count
      num_to_add = avg_questions_per_standard.ceil

      if to_add_standard.count > avg_questions_per_standard
        num_per_strand = avg_questions_per_strand.floor
        avg_questions_per_standard = (num_per_strand.to_f) / self.available_questions[strand_id].keys.count
        num_to_add = avg_questions_per_standard.ceil
        debug_data "    UPDATE"
        debug_data "    Update num_per_strand = #{num_per_strand}"
        debug_data "    Update avg_questions_per_standard = #{avg_questions_per_standard}"
        debug_data "    Update num_to_add = #{num_to_add}"
      else
        debug_data "  * No se actualiza porque to_add_standard.count = #{to_add_standard.count} y avg_questions_per_standard = #{avg_questions_per_standard}"
      end

      self.available_questions[strand_id].keys.each do |standard_id|
        debug_data "  Van: #{result.count}"

        if num_to_add.zero? or to_add_strand >= num_per_strand
          debug_data "    can't add more (to_add_strand = #{to_add_strand}, num_per_strand = #{num_per_strand}"
          next
        end 
        debug_data "  STANDARD_ID = #{standard_id}"
        debug_data ""

        debug_data "    avg_questions_per_strand = #{avg_questions_per_strand}"
        debug_data "    avg_questions_per_standard = #{avg_questions_per_standard}"
        debug_data "    num_per_strand = #{num_per_strand}"
        debug_data "    num_to_add = #{num_to_add}"

        to_add_standard = self.available_questions[strand_id][standard_id][0..(num_to_add-1)]
        to_add_strand += to_add_standard.count
        debug_data ""
        debug_data "    To Add: #{to_add_standard.count}"
        debug_data ""
        result << to_add_standard
      end

      to_add_strand = 0
    end

    debug_data "AVG per strand: #{avg_questions_per_strand}"
    result
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

    debug_data self.questions_statistics.inspect
  end

  def debug_data(text)
    #puts text
  end

end