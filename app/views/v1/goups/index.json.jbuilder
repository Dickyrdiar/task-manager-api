json.array!(@groups) do |group|
    json.extract! group, :name, :desc, :slug, :projects, :create_at, :updated_at 
end 