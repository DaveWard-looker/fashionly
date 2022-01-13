project_name: "fashionly"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

constant: connection_name {
  value: "bigquery_personal_instance"
  export: override_required
}


localization_settings: {
  default_locale: en
  localization_level: permissive
}
