provider "google" {
  project     = var.project_name
  region      = var.region
  credentials  = file(var.credentials_file)
}

data "google_client_openid_userinfo" "me" {
}

resource "google_compute_network" "vpc_network" {
  name = "${var.project_name}-${var.env}-vpc-network"
}

resource "google_compute_subnetwork" "subnet" {  
  name          = "${var.project_name}-${var.env}-subnet"  
  ip_cidr_range = "10.0.0.0/24"  
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_firewall" "fw" {
  project     = var.project_name
  name    = "${var.project_name}-${var.env}-firewall"
  network = google_compute_network.vpc_network.self_link
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
}

resource "google_service_account" "service_account" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

# Instance pour la machine virtuelle de dev
resource "google_compute_instance" "vm" {  
  name         = "${var.project_name}-${var.env}-virtual-machine"  
  machine_type = "e2-small"  
  zone         = "${var.region}-${var.zone}"
  tags         = ["wp"]
  allow_stopping_for_update = true
  boot_disk {    
    initialize_params {      
      image = "ubuntu-os-cloud/ubuntu-2004-lts"     
    }  
  }  
  network_interface {    
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link 
    access_config {
    }
  }

  service_account {    
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.    
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]  
  }
}