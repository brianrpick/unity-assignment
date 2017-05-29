class Project < ApplicationRecord
  def self.create_project(project)
    # unless declared make :enabled true
    if project[:enabled].nil?
      project[:enabled] = true
    end
    #open file, append with each project
    open('projects.txt', 'a') do |line|
      line << project.as_json
      lineg << "\n"
    end
  end
end
