require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('pg')

DB = PG.connect({:dbname => "to_do_test"})

get('/') do
  erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

post("/lists") do
  @lists = List.all()
  erb(:lists)
end

get('/lists/:id') do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post('/tasks') do
  description = params.fetch('description')
  task = Task.new(description)
  task.save()
  erb(:success)
end
