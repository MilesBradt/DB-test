require 'pg'

class Task
  attr_reader :description

  def initialize(attributes)
    @description = attributes[:description]
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      tasks.push(Task.new({:description => description}))
    end
    tasks
  end

  def ==(another_tast)
    self.description().==(another_tast.description())
  end
  def save
    DB.exec("INSERT INTO tasks (description) VALUES ('#{@description}');")
  end
end
