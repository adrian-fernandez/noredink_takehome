class Usage
  attr_accessor :student_id, :question_id, :assigned_hours_ago, :answered_hours_ago

  # Initialize method
  # data Array<Hash> data to initialize the object
  def initialize(data)
    data.each { |key, value| send("#{key}=", value) unless key.nil? }
  end

end