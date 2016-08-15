class ProjectSerializer < ApplicationSerializer
  attribute :slug
  filterable_by :slug

  link(:self){ project_path object }
  link(:splits){ splits_path filter: { project_id: object.id } }
end
