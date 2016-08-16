class ProjectsController < ApplicationController
  self.resource = Project
  self.serializer_class = ProjectSerializer
  self.schema_class = ProjectSchema
end
