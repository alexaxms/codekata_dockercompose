class TodoWorker
  include Sidekiq::Worker

  def perform(todo_id)
    todo = Todo.find(todo_id)
    Todo.create(title: todo.description, description: todo.title)
  end
end