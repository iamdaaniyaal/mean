// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}


//MEAN Stack

//Reserving MEAN Stack IP
resource "google_compute_address" "meanip" {
  name   = "meanip"
  region = "${var.mean_stack_instance_ip_region}"
}

  
// MEAN Stack Instance
resource "google_compute_instance" "mean-stack" {
  name         = "${var.mean_stack_instance_name}"
  machine_type = "${var.mean_stack_machine_type}"
  zone         = "${var.mean_stack_zone}"
  
   tags = ["http-server"]
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network    = "${var.mean_stack_vpc_name}"
    subnetwork = "${var.mean_stack_subnet_name}"

    access_config {
      // Ephemeral IP

      nat_ip       = "${google_compute_address.meanip.address}"
      network_tier = "PREMIUM"
    }
  }
  metadata_startup_script = "sudo apt-get update; sudo apt-get install git  -y; git clone https://github.com/iamdaaniyaal/mean.git; cd /; cd mean; sudo chmod 777 mean.sh; sh mean.sh"

 
}
