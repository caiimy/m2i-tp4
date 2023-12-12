terraform {
 backend "gcs" {
   bucket  = "m2i-tp4-dev-bucket-2"
   prefix  = "terraform/state"
   credentials  = "../../credentials.json"
 }
}