- dashboard: inventory_items
  title: Inventory Items
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: FXjIrfhlAJ3BMK1pNbgNkL
  elements:
  - title: Inventory Items
    name: Inventory Items
    model: fashionly
    explore: inventory_items
    type: looker_column
    fields: [inventory_items.timeframe, inventory_items.display_value]
    filters: {}
    sorts: [inventory_items.timeframe desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_null_points: true
    interpolation: linear
    listen:
      Sold At Timeframe: inventory_items.sold_at_timeframe
      Aggregate Value: inventory_items.aggregate_value
    row: 0
    col: 0
    width: 24
    height: 7
  filters:
  - name: Sold At Timeframe
    title: Sold At Timeframe
    type: field_filter
    default_value: day
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: fashionly
    explore: inventory_items
    listens_to_filters: []
    field: inventory_items.sold_at_timeframe
  - name: Aggregate Value
    title: Aggregate Value
    type: field_filter
    default_value: cost
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: fashionly
    explore: inventory_items
    listens_to_filters: []
    field: inventory_items.aggregate_value
