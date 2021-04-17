json.array!(@groups) do |group|
    json.extract! group, :name, :desc, :projects, :create_at, :updated_at 
end 