- dashboard: brand_dashboard
  title: Brand Dashboard
  layout: newspaper
  elements:
  - name: 4 Brand Orders
    title: 4 Brand Orders
    model: fashionly_davew
    explore: products
    type: single_value
    fields: [order_items.count]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Brand Orders
    defaults_version: 1
    listen:
      Brand Name: products.brand_name
    row: 5
    col: 0
    width: 4
    height: 4
  - name: Brand Category Diversity
    title: Brand Category Diversity
    model: fashionly_davew
    explore: products
    type: looker_bar
    fields: [products.brand, products.category, products.count]
    pivots: [products.category]
    filters:
      products.count: NOT NULL
    sorts: [products.category 0, products.count desc 7]
    limit: 10
    query_timezone: America/Los_Angeles
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: right
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hidden_series: []
    hide_legend: false
    series_types: {}
    defaults_version: 1
    listen:
      Product Categories: products.category
    row: 26
    col: 0
    width: 24
    height: 15
  - name: 4 Brand Total Gross Revenue
    title: 4 Brand Total Gross Revenue
    model: fashionly_davew
    explore: products
    type: single_value
    fields: [order_items.total_gross_revenue]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Gross Revenue
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: The Total Gross Revenue with no deductions over the full lifetime of
      the brands sale period with fashionly.
    listen:
      Brand Name: products.brand_name
    row: 5
    col: 14
    width: 5
    height: 4
  - name: min_max_comparison
    title: min_max_comparison
    model: fashionly_davew
    explore: products
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [products.max_item_cost, products.min_item_cost]
    sorts: [products.max_item_cost desc]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '15'
    style_products.max_item_cost: "#3A4245"
    show_title_products.max_item_cost: true
    title_placement_products.max_item_cost: above
    value_format_products.max_item_cost: ''
    style_products.min_item_cost: "#3A4245"
    show_title_products.min_item_cost: true
    title_placement_products.min_item_cost: above
    value_format_products.min_item_cost: ''
    show_comparison_products.min_item_cost: true
    comparison_style_products.min_item_cost: value
    comparison_show_label_products.min_item_cost: true
    comparison_label_placement_products.min_item_cost: below
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Maximum Item Cost
    defaults_version: 0
    series_types: {}
    title_hidden: true
    listen:
      Brand Name: products.brand_name
    row: 5
    col: 19
    width: 5
    height: 4
  - name: 4 Average Item Cost
    title: 4 Average Item Cost
    model: fashionly_davew
    explore: products
    type: single_value
    fields: [products.average_item_cost, products.brand_name]
    sorts: [products.average_item_cost desc]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Average Item Cost
    defaults_version: 1
    listen:
      Brand Name: products.brand_name
    row: 5
    col: 4
    width: 5
    height: 4
  - name: 4 Order Count
    title: 4 Order Count
    model: fashionly_davew
    explore: products
    type: looker_line
    fields: [order_items.created_month, products.brand_name, order_items.count]
    pivots: [products.brand_name]
    fill_fields: [order_items.created_month]
    filters: {}
    sorts: [order_items.created_month, products.brand_name]
    limit: 500
    column_limit: 50
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
    show_null_points: true
    interpolation: linear
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: order_items.total_gross_revenue, name: Total Gross Revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: '', orientation: right, series: [{axisId: order_items.count,
            id: order_items.count, name: Order Items}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Brand Orders
    defaults_version: 1
    listen:
      Brand Name: products.brand_name
    row: 18
    col: 0
    width: 12
    height: 8
  - name: 4 Total Gross Revenue Comparison
    title: 4 Total Gross Revenue Comparison
    model: fashionly_davew
    explore: products
    type: looker_line
    fields: [order_items.created_month, products.brand_name, order_items.total_gross_revenue]
    pivots: [products.brand_name]
    fill_fields: [order_items.created_month]
    filters: {}
    sorts: [order_items.created_month, products.brand_name]
    limit: 500
    column_limit: 50
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
    show_null_points: true
    interpolation: linear
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: order_items.total_gross_revenue, name: Total Gross Revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: '', orientation: right, series: [{axisId: order_items.count,
            id: order_items.count, name: Order Items}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Brand Orders
    defaults_version: 1
    listen:
      Brand Name: products.brand_name
    row: 18
    col: 12
    width: 12
    height: 8
  - name: brand logo
    title: brand logo
    model: fashionly_davew
    explore: order_items
    type: single_value
    fields: [products.brand_logo]
    sorts: [products.brand_logo]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    listen:
      Brand Name: products.brand_name
    row: 5
    col: 9
    width: 5
    height: 4
  - name: Department Split
    title: Department Split
    model: fashionly_davew
    explore: order_items
    type: looker_pie
    fields: [products.department, products.distinct_product_count]
    sorts: [products.department]
    limit: 500
    query_timezone: America/Los_Angeles
    value_labels: labels
    label_type: labPer
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    listen:
      Brand Name: products.brand_name
    row: 9
    col: 0
    width: 7
    height: 9
  - name: Top 10 Selling Products
    title: Top 10 Selling Products
    model: fashionly_davew
    explore: order_items
    type: looker_bar
    fields: [order_items.total_gross_revenue, products.name]
    sorts: [order_items.total_gross_revenue desc]
    limit: 10
    query_timezone: America/Los_Angeles
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
    listen:
      Brand Name: products.brand_name
    row: 9
    col: 7
    width: 10
    height: 9
  - name: Distribution centres
    title: Distribution centres
    model: fashionly_davew
    explore: order_items
    type: looker_pie
    fields: [distribution_centers.name, order_items.count]
    sorts: [order_items.count desc]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
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
      Brand Name: products.brand_name
    row: 9
    col: 17
    width: 7
    height: 9
  - name: Gross Revenue By Brand
    title: Gross Revenue By Brand
    model: fashionly_davew
    explore: products
    type: looker_bar
    fields: [order_items.total_gross_revenue, products.brand]
    sorts: [order_items.total_gross_revenue desc]
    limit: 10
    query_timezone: America/Los_Angeles
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
    listen:
      Product Categories: products.category
    row: 41
    col: 0
    width: 24
    height: 12
  - name: Customer_behaviour_button
    title: Customer_behaviour_button
    model: fashionly_davew
    explore: order_items
    type: single_value
    fields: [order_items.customer_behaviour_button]
    sorts: [order_items.customer_behaviour_button]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    row: 0
    col: 8
    width: 8
    height: 3
  - name: overview_button
    title: overview_button
    model: fashionly_davew
    explore: order_items
    type: single_value
    fields: [order_items.overview_button]
    sorts: [order_items.overview_button]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    row: 0
    col: 0
    width: 8
    height: 3
  - name: cohort_analysis
    title: cohort_analysis
    model: fashionly_davew
    explore: order_items
    type: single_value
    fields: [order_items.cohort_analysis_button]
    sorts: [order_items.cohort_analysis_button]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    row: 0
    col: 16
    width: 8
    height: 3
  - name: <font color = "black" size = "15" weight="bold"><i class = "fa fa-chart-bar"
      aria-hidden="true"</i><strong>  Brand Analysis</strong>
    type: text
    title_text: <font color = "black" size = "15" weight="bold"><i class = "fa fa-chart-bar"
      aria-hidden="true"</i><strong>  Brand Analysis</strong>
    row: 3
    col: 0
    width: 24
    height: 2
  filters:
  - name: Brand Name
    title: Brand Name
    type: field_filter
    default_value: Ray-Ban
    allow_multiple_values: true
    required: false
    model: fashionly_davew
    explore: products
    listens_to_filters: []
    field: products.brand_name
  - name: Product Categories
    title: Product Categories
    type: field_filter
    default_value: Accessories,Tops & Tees,Swim,Active,Dresses,Fashion Hoodies & Sweatshirts,Clothing
      Sets,Blazers & Jackets,Intimates,Jumpsuits & Rompers,Jeans,Leggings,Maternity
    allow_multiple_values: true
    required: false
    model: fashionly_davew
    explore: products
    listens_to_filters: []
    field: products.category
