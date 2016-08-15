class ProjectsController < ApplicationController
  self.resource = Project
  self.serializer_class = ProjectSerializer
end
