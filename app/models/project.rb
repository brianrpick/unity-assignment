class Project < ApplicationRecord
  def self.create_project(project)
    if project[:enabled].nil?
      project[:enabled] = true
    end
    open('projects.txt', 'a') do |f|
      f << project.as_json
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
      unless check(test_project)
        all_projects << test_project
      end
    end
    all_projects
  end

  def self.check(project)
    date = DateTime.strptime(project['expiry_date'], '%m%d%Y %T')
    if project['enabled'] == false || date < Date.today || project['project_url'].nil?
      return false
    end
  end

  def self.find_project(link_params)
    selected_projects = []
    reduced_params = link_params.reject{|_, v| v.blank?}
    all_projects = self.all_projects
    unless reduced_params[:id]
      reduced_params.each do |key, value|
        all_projects.each_with_index do |project, i|
          if project[i][:"#{key}"] == value
            selected_projects << project
            i++
          else
            i++
          end
        end
      end
    end
    # if all values are empty, send to find highest cost
  end

  def self.find_highest_cost(all_projects)
    highest_cost = {}
    all_projects.each do |project|
      if highest_cost.empty?
        highest_cost = project
      elsif project['project_cost'] > highest_cost['project_cost']
        highest_cost = project
      end
    end
    highest_cost
  end
end
