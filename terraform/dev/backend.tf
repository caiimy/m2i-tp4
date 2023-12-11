terraform {
 backend "gcs" {
   bucket  = "m2i-tp4-dev-bucket"
   prefix  = "terraform/state"
 }
}