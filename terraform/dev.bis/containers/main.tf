module "gce-container" {
  source = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"

  container = {
    image = var.image
    command = var.custom_command
    env = local.env_variables
    securityContext = {
      privileged : var.privileged_mode
    }
    tty : var.activate_tty
  }

  restart_policy = "Always"
}

resource "google_compute_instance" "vm" {
  name = local.instance_name
  machine_type = "f1-micro"
  # If true, allows Terraform to stop the instance to update its properties.
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  network_interface {
    network = var.network_name

    access_config {}
  }

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
  }

  labels = {
    container-vm = module.gce-container.vm_container_label
  }

  service_account {
    email = var.client_email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}