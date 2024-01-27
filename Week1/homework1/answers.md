A1. --rm 

A2. 0.42.0

A3. 15612

    select lpep_pickup_datetime 
    from green_taxi_trips 
    where date_trunc('day', lpep_pickup_datetime) = timestamp '2019-09-18'
    and date_trunc('day', lpep_dropoff_datetime) = timestamp '2019-09-18'

A4. 2019-09-26

    SELECT lpep_pickup_datetime
    FROM green_taxi_trips
    ORDER BY trip_distance DESC
    LIMIT 1;

A5. "Brooklyn" "Manhattan" "Queens"
    
    select z."Borough", sum(g.total_amount)
    from green_taxi_trips g
	inner join green_zones z on z."LocationID" = g."PULocationID"
    where date_trunc('day', lpep_pickup_datetime) = timestamp '2019-09-18'
	group by z."Borough"
	order by sum(g.total_amount) desc
	
A6. "Long Island City/Queens Plaza"
    
    select zdo."Zone", sum(tip_amount)
    from green_taxi_trips g
	inner join green_zones zpu on zpu."LocationID" = g."PULocationID"
	inner join green_zones zdo on zdo."LocationID" = g."DOLocationID"
    where date_trunc('day', lpep_pickup_datetime)  >= timestamp '2019-09-01'
	and date_trunc('day', lpep_pickup_datetime) < timestamp '2019-10-01'
	and zpu."Zone" = 'Astoria'
	group by zdo."Zone"
	order by sum(tip_amount) desc
"Central Park"	57.92
"Jamaica"	26.380000000000003
"JFK Airport"	277.26
"Long Island City/Queens Plaza"	709.0299999999997

A7. 
    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # google_bigquery_dataset.demo_dataset will be created
    + resource "google_bigquery_dataset" "demo_dataset" {
        + creation_time              = (known after apply)
        + dataset_id                 = "demo_dataset"
        + default_collation          = (known after apply)
        + delete_contents_on_destroy = false
        + effective_labels           = (known after apply)
        + etag                       = (known after apply)
        + id                         = (known after apply)
        + is_case_insensitive        = (known after apply)
        + last_modified_time         = (known after apply)
        + location                   = "US"
        + max_time_travel_hours      = (known after apply)
        + project                    = "thinking-land-410514"
        + self_link                  = (known after apply)
        + storage_billing_model      = (known after apply)
        + terraform_labels           = (known after apply)
        }

    # google_storage_bucket.demo-bucket will be created
    + resource "google_storage_bucket" "demo-bucket" {
        + effective_labels            = (known after apply)
        + force_destroy               = true
        + id                          = (known after apply)
        + location                    = "US"
        + name                        = "thinking-land-410514-terra-bucket"
        + project                     = (known after apply)
        + public_access_prevention    = (known after apply)
        + rpo                         = (known after apply)
        + self_link                   = (known after apply)
        + storage_class               = "STANDARD"
        + terraform_labels            = (known after apply)
        + uniform_bucket_level_access = true
        + url                         = (known after apply)

        + lifecycle_rule {
            + action {
                + type = "Delete"
                }
            + condition {
                + age                   = 30
                + matches_prefix        = []
                + matches_storage_class = []
                + matches_suffix        = []
                + with_state            = (known after apply)
                }
            }

        + versioning {
            + enabled = true
            }
        }

    Plan: 2 to add, 0 to change, 0 to destroy.

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

    google_bigquery_dataset.demo_dataset: Creating...
    google_storage_bucket.demo-bucket: Creating...
    google_bigquery_dataset.demo_dataset: Creation complete after 1s [id=projects/thinking-land-410514/datasets/demo_dataset]
    google_storage_bucket.demo-bucket: Creation complete after 2s [id=thinking-land-410514-terra-bucket]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.