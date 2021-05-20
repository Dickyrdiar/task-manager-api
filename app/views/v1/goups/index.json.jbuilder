json.array!(@groups) do |group|
    json.extract! group, :name, :desc, :slug, :projects, :group_member, :create_at, :updated_at 
end 