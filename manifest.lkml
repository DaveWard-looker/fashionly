# project_name: "fashionly"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "elections"
# }

constant: connection_name {
  value: "bigquery_personal_instance"
  export: override_required
}

constant: map_api_key {
  value: "laijhefpa7p976d"
}


localization_settings: {
  default_locale: en
  localization_level: permissive
}
 new_lookml_runtime: yes
