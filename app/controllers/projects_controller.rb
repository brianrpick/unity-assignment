class ProjectsController < ApplicationController
  def create
    # create project to send to model method
    project = {
      id: params[:id], project_name: params[:projectName], creation_date: params[:creationDate], expiry_date: params[:expiryDate], enabled: params[:enabled], target_countries: params[:targetCountries], project_cost: params[:projectCost], project_url: params[:projectUrl], target_keys: params[:targetKeys]
    }
    # call model to create project
    if Project.create_project(project)
      # send success message
      render json: { message: 'campaign is successfully created' }
    else
      render json: { message: Project.errors.as_json }
    end
  end
end
