class Project < ApplicationRecord
  def self.create_project(project)
    date = DateTime.now.strftime('%m%d%Y %T')
    # if no enabled value was given, set it equal to true
    if project[:enabled].nil?
      project[:enabled] = true
    end
    # open projects file and add the new project to it
    open('projects.txt', 'a') do |f|
      f << project.as_json
      f << "\n"
    end
    # add new project to log
    open('logs.txt', 'a') do |f|
      f << "New project created named: #{project[:project_name]}, with id: #{project[:id]}"
      f << " - This project was created at #{date}"
      f << "\n"
    end
  end

  def self.all_projects
    all_projects = []
    # grabbing information from projects.txt and form into a json
    file = JSON.pretty_generate(File.open('projects.txt', 'r').as_json)
    json_projects = JSON.parse(file)
    # take each entry in the json and form into hash
    json_projects.each do |project|
      test_project = eval(project)
      # check if any criteria is disqualifying
      if check(test_project)
        # if passes ceck, add to array
        all_projects << test_project
      end
    end
    all_projects
  end

  def self.check(project)
    date = DateTime.strptime(project['expiry_date'], '%m%d%Y %T')
    # If disqualifying information is found dont add to qualifying array
    if project['enabled'] == false || date < Date.today || project['project_url'].nil?
      return false
    else
      return true
    end
  end

  def self.find_highest_cost(projects)
    date = DateTime.now.strftime('%m%d%Y %T')
    highest_cost = []
    # run if more than one project is in array
    if projects.length > 1
      projects.each do |project|
        # if empty, make project what we are testing against
        if highest_cost.empty?
          highest_cost = project
        # if the project's cost is higher than the previous, make it the 'highest cost'
        elsif project['project_cost'].to_i > highest_cost['project_cost'].to_i
          highest_cost = project
        end
      end
    else
      # if only one project, return that project to controller
      highest_cost = projects
    end
    # open log, add when data was accessed and give id
    open('logs.txt', 'a') do |f|
      f << "Web Service Accessed on #{date}, responding with Project id: #{highest_cost['id']}"
      f << "\n"
    end
    # return highest cost project to requestee
    highest_cost
  end

  def self.find_project(link_params)
    selected_projects = []
    # remove all params that are empty
    slim_params = (link_params.reject { |_, v| v.blank? })
    # if given id in params, try to find it in qualifying array
    if slim_params[:id]
      selected_projects = all_projects.find {|i| i["id"] == slim_params[:id] }
    else
      all_projects = self.all_projects
      all_projects.each do |project|
        # send each project to see if parameters match hash values
        selected_projects << sift_through(project.stringify_keys, slim_params.stringify_keys)
      end
    end
    # send all projects with matching parameters to find the one with highest cost
    find_highest_cost(selected_projects)
  end

  def self.sift_through(project, slim_params)
    slim_params.each do |key, value|
      # check if we have to go through each target key
      if key == 'number' || key == 'keyword'
        project['target_keys'].each do |target_hash|
          # check target keys for matching values
          if target_hash.any? { target_hash[key] == value }
            return project
          end
        end
      # see if country is inside project
      elsif project['target_countries'].include? slim_params[key]
        return project
      end
    end
  end
end
