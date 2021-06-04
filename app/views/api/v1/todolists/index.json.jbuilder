json.array!(@todolists) do |todolist|
    json.extract! todolist, :title, :bolean
end 