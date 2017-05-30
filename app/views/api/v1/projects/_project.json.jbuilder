json.id project['id']
json.projectName project['project_name']
json.creationDate project['creation_date']
json.expiryDate project['expiry_date']
json.targetCountries project['target_countries']
json.projectCost project['project_cost']
json.projectUrl project['project_url']

json.targetKeys project['target_keys'].each do |t_key|
  json.number t_key['number']
  json.keyword t_key['keyword']
end