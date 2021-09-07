connection: "bigquery_personal_instance"

explore: dresses {}

# include all the views
include: "/views/**/*"

datagroup: order_items_datagroup {
  sql_trigger: SELECT max(id) FROM order_items ;;
  max_cache_age: "24 hours"
}

datagroup: inventory_items_datagroup {
  sql_trigger: select max(id) from inventory_items ;;
  max_cache_age: "24 hours"
}

persist_with: order_items_datagroup

access_grant: private_data {
  allowed_values: ["Yes"]
  user_attribute: private_data_access
}

explore: fact_order {}

explore: events {
  join: users {

    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    fields: [-products.profit_per_customer]
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  access_filter: {
    field: users.country
    user_attribute: manager_country
  }
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
  join: user_orders_fact {
    type: left_outer
    sql_on: ${order_items.user_id} = ${user_orders_fact.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  access_filter: {
    field: category
    user_attribute: sales_department
  }
  fields: [ALL_FIELDS*,-products.profit_per_customer]
  join: distribution_centers {

    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}


explore: orders_by_gender {
  from: order_items
  join: male_users {
    from: users
    sql_on: ${orders_by_gender.user_id} = ${male_users.id}
    and ${male_users.gender} = 'Male';;
    relationship: many_to_one
  }
  join: female_users {
    from: users
    sql_on: ${orders_by_gender.user_id} = ${male_users.id}
    and ${male_users.gender} = 'Female';;
    relationship: many_to_one
  }
}



access_grant: brand_client_flag {
  user_attribute: is_brand_client
  allowed_values: ["yes"]
}


# aggregate awareness code

# Place in `fashionly` model
explore: +order_items {
  aggregate_table: rollup__shipped_date {
    query: {
      dimensions: [
        # "users.country" is automatically filtered on in an access_filter.
        # Uncomment to allow all possible filters to work with aggregate awareness.
        # users.country,
        shipped_date
      ]
      measures: [total_sale_price]
      filters: [
        # "users.country" is automatically filtered on in an access_filter in this query.
        # Remove this filter to allow all possible filters to work with aggregate awareness.
        users.country: "USA",
        order_items.created_date: "14 days"
      ]
    }

    materialization: {
      datagroup_trigger: order_items_datagroup
    }
  }
}
