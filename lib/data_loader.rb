require 'csv'

module DataLoader
  DATA_QUESTIONS = [__dir__, '..', 'data', 'questions.csv'].join('/')
  DATA_USAGES = [__dir__, '..', 'data', 'usage.csv'].join('/')

  def self.get_questions
    DataLoader.load_data(DATA_QUESTIONS, Question)
  end

  def self.get_usages
    DataLoader.load_data(DATA_QUESTIONS, Question)
  end

  private

  def self.load_data(file_path, class_name)
    result = []

    CSV.foreach(file_path, headers: true) do |row|
      result << class_name.new(row.to_hash)
    end

    result
  end

end