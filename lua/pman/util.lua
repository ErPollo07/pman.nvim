function printProjects(header, projects) 
  print(header)

  local i = 1;

  for key, val in pairs(projects) do
    print(string.format("[%d] %s : %s", i, key, val.name))
    i += 1
  end
end
