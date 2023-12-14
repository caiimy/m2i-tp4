provider "google" {
  project = var.project
  credentials = file(var.credentials_file)
  region = var.region
  zone = var.zone
}

module "gce-worker-container" {
  source = "./gce-with-container"

  image = "gcr.io/${var.project}/jafar@sha256:6b71cebad455dae81af9fcb87a4c8b5bca2c2b6b2c09cec21756acd0f1ae7cec"
  privileged_mode = true
  activate_tty = true
  custom_command = [
    "./scripts/start-worker.sh"
  ]

  instance_name = "jafar-worker"
  network_name = "default"
  # This has the permission to download images from Container Registry
  client_email = "custom-gce-dealer@${var.project}.iam.gserviceaccount.com"
}