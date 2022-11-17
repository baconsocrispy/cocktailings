def seed_tools
  tools = File.read(Rails.root.join('lib', 'seeds', 'tools.txt'))
  tools.split("\n").each do |t|
    tool = Tool.find_by(tool_type: t)
    Tool.create!(tool_type: t) unless tool
  end
  p 'Tools successfully seeded'
end