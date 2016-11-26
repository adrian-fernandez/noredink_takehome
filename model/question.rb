class Question
  attr_accessor :strand_id, :strand_name,  :standard_id, :standard_name,
                :question_id, :difficulty,
                :answered_ago, :assigned_ago

  # Initialize method
  # data Array<Hash> data to initialize the object
  def initialize(data)
    data.each { |key, value| send("#{key}=", value) }
    answered_ago = nil
    assigned_ago = nil
  end

  # Sort questions by strand_id, standard_id and difficulty
  def <=>(question2)
    [strand_id, standard_id, question2.assigned_ago, question2.answered_ago, difficulty] <=> [question2.strand_id, question2.standard_id, assigned_ago, answered_ago, question2.difficulty]
  end

  # Builds a hash of questions { strand_id: { standard_id: [Question] } } }
  def self.build_hash(questions)
    result = Hash.new

    questions.each do |question|
      result[question.strand_id] ||= Hash.new
      result[question.strand_id][question.standard_id] ||= Array.new
      result[question.strand_id][question.standard_id] << question
    end

    return result
  end

  def update_usages!(usages)
    return if usages.nil?

    usages.each do |usage|
      next if usage.question_id != question_id

      update_time_ago!('assigned_ago', usage.assigned_hours_ago)
      update_time_ago!('answered_ago', usage.answered_hours_ago)
    end
  end

  def update_time_ago!(field_name, new_value)
    return if new_value.nil?

    current_value = send(field_name)

    if current_value.nil? or current_value > new_value 
      send("#{field_name}=", new_value) 
    end
  end

  # Output expects question_id
  def to_s
    "ID: #{question_id}, strand_id: #{strand_id}, standard_id: #{standard_id}, answered_ago: #{answered_ago}, assigned_ago: #{assigned_ago}, difficulty: #{difficulty}"
  end
end