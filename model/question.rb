class Question
  attr_accessor :strand_id, :strand_name,  :standard_id, :standard_name,
                :question_id, :difficulty

  # Initialize method
  # data Array<Hash> data to initialize the object
  def initialize(data)
    data.each { |key, value| send("#{key}=", value) }
  end
end