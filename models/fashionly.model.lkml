connection: "@{connection_name}"
include: "/value_formats.explore.lkml"

# include all the views
include: "/views/**/*"

datagroup: order_items_datagroup {
  sql_trigger: SELECT max(id) FROM order_items ;;
  max_cache_age: "24 hours"
}

datagroup: no_cache {
  max_cache_age: "0 hours"
}

datagroup: inventory_items_datagroup {
  sql_trigger: select max(id) from inventory_items ;;
  max_cache_age: "24 hours"
}

persist_with: order_items_datagroup


explore: dt_users_per_shipping {}

explore: order_items {
  # persist_with: no_cache
  join: dt_client {
    sql_on: ${order_items.user_id} = ${dt_client.user_id} ;;
    relationship: many_to_one
  }
}


explore: events {
  join: users {

    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


explore: events_ireland {
  from: events
  sql_always_where: ${country} = 'Ireland' ;;
  sql_always_having: ${users.count} > 5  ;;
  join: users {

    type: left_outer
    sql_on: ${events_ireland.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}



explore: inventory_items {

  hidden: yes
  persist_with: inventory_items_datagroup
  join: products {
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

# explore: order_items {
#   # access_filter: {
#   #   field: users.country
#   #   user_attribute: manager_country
#   # }
#   join: users {
#     type: left_outer
#     sql_on: ${order_items.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }

#   join: inventory_items {
#     type: left_outer
#     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
#     relationship: many_to_one
#   }

#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }

#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${inventory_items.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
#   join: user_orders_fact {
#     type: left_outer
#     sql_on: ${order_items.user_id} = ${user_orders_fact.id} ;;
#     relationship: many_to_one
#   }
# }

explore: products {

  join: distribution_centers {

    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items_marketing {
  hidden: no
  label: "Inventory Items Marketing"
  description: "This is marketing specific inventory items view."
  extends: [inventory_items]
  from: inventory_items
  view_name: inventory_items
  join: customers {
    sql_on: ${customers.product_id} = ${products.id} ;;
    type: left_outer
    relationship: many_to_one
  }
}





# aggregate awareness code


# Place in `fashionly` model
explore: +events {
  aggregate_table: rollup__users_age_group__users_customer_name__users_gender {
    query: {
      dimensions: [users.age_group, users.customer_name, users.gender]
      measures: [users.count]
      timezone: "UTC"
    }

    materialization: {
      datagroup_trigger: order_items_datagroup
    }
  }
}
