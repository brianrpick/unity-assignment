class Project < ApplicationRecord
  def self.create_project(project)
    date = DateTime.now.strftime('%m%d%Y %T')
    if project[:enabled].nil?
      project[:enabled] = true
    end
    open('projects.txt', 'a') do |f|
      f << project.as_json
      f << "\n"
    end
    open('logs.txt', 'a') do |f|
      f << "New project created named: #{project[:project_name]}, with id: #{project[:id]}"
      f << " - This project was created at #{date}"
      f << "\n"
    end
  end

  def self.all_projects
    all_projects = []
    file = JSON.pretty_generate(File.open('projects.txt', 'r').as_json)
    json_projects = JSON.parse(file)
    json_projects.each do |project|
      # maybe running json.parse on each prjoect will work instead of eval
      test_project = eval(project)
      # check if any criteria is disqualifying
      if check(test_project)
        all_projects << test_project
      end
    end
    return all_projects
  end

  def self.check(project)
    date = DateTime.strptime(project['expiry_date'], '%m%d%Y %T')
    if project['enabled'] == false || date < Date.today || project['project_url'].nil?
      return false
    else
      return true
    end
  end

  def self.find_highest_cost(projects)
    date = DateTime.now.strftime('%m%d%Y %T')
    highest_cost = []
    if projects.length > 1
      projects.each do |project|
        if highest_cost.empty?
          highest_cost = project
        elsif project['project_cost'].to_i > highest_cost['project_cost'].to_i
          highest_cost = project
        end
      end
    else
      highest_cost = projects
    end
    open('logs.txt', 'a') do |f|
      f << "Web Service Accessed on #{date}, responding with Project id: #{highest_cost['id']}"
      f << "\n"
    end
    return highest_cost
  end

  def self.find_project(link_params)
    selected_projects = []
    slim_params = (link_params.reject { |_, v| v.blank? })
    if slim_params[:id]
      selected_projects = all_projects.find {|i| i["id"] == slim_params[:id] }
    else
      all_projects = self.all_projects
      all_projects.each do |project|
        selected_projects << sift_through(project.stringify_keys, slim_params.stringify_keys)
      end
    end
    find_highest_cost(selected_projects)
  end

  def self.sift_through(project, slim_params)
    slim_params.each do |key, value|
      if key == 'number' || key == 'keyword'
        project['target_keys'].each do |target_hash|
          if target_hash.any? { target_hash[key] == value }
            return project
          end
        end
      elsif project['target_countries'].include? slim_params[key]
        return project
      end
    end
  end
end
