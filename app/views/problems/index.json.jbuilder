json.array!(@problems) do |problem|
  json.extract! problem, :id, :name, :start_time, :end_time
  json.url problem_url(problem, format: :json)
end
