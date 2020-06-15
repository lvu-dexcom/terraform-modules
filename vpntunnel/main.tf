data "google_compute_network" "existing_network"{
  project = var.existing_project
  name    = var.existing_network
}

data "google_compute_network" "new_network"{
  project = var.new_project
  name    = var.new_network
}

data "google_compute_vpn_gateway" "existing_vpngw"{
  count = 2

  project = var.existing_project
  name    = "${var.existing_network}-${var.region}-vpngw0${count.index+1}"
}

data "google_compute_address" "existing_vpngw_ip"{
  count = 2

  project = var.existing_project
  name    = "${var.existing_network}-${var.region}-vpngw0${count.index+1}-ip"
}
data "google_compute_vpn_gateway" "new_vpngw"{
  count = 2

  project = var.new_project
  name    = "${var.new_network}-${var.region}-vpngw0${count.index+1}"
}
data "google_compute_address" "new_vpngw_ip"{
  count = 2

  project = var.new_project
  name    = "${var.new_network}-${var.region}-vpngw0${count.index+1}-ip"
}

resource "google_compute_vpn_tunnel" "exist_new_tunnel" {
  count                   = 2

  project                 = var.existing_project
  name                    = "${var.new_network}-tunnel0${count.index+1}"
  peer_ip                 = data.google_compute_address.new_vpngw_ip[count.index].address
  target_vpn_gateway      = data.google_compute_vpn_gateway.existing_vpngw[count.index].id
  
  shared_secret           = var.vpn_shared_secret
  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]
}

resource "google_compute_vpn_tunnel" "new_exist_tunnel" {
  count                   = 2

  project                 = var.new_project
  name                    = "${var.existing_network}-tunnel0${count.index+1}"
  peer_ip                 = data.google_compute_address.existing_vpngw_ip[count.index].address
  target_vpn_gateway      = data.google_compute_vpn_gateway.new_vpngw[count.index].id
  
  shared_secret           = var.vpn_shared_secret
  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]
}

resource "google_compute_route" "new_network_route_1" {
  count      = length(var.new_dest_ranges)

  project    = var.existing_project
  name       = "${var.new_network}-${split("/",replace(var.new_dest_ranges[count.index],".","-"))[0]}-route01"
  network    = data.google_compute_network.existing_network.name
  dest_range = var.new_dest_ranges[count.index]
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.exist_new_tunnel[0].id
}

resource "google_compute_route" "new_network_route_2" {
  count      = length(var.new_dest_ranges)

  project    = var.existing_project
  name       = "${var.new_network}-${split("/",replace(var.new_dest_ranges[count.index],".","-"))[0]}-route02"
  network    = data.google_compute_network.existing_network.name
  dest_range = var.new_dest_ranges[count.index]
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.exist_new_tunnel[1].id
}

#This is dest route from new network to the existing network
resource "google_compute_route" "existing_network_route_1" {
  count      = length(var.existing_dest_ranges)

  project    = var.new_project
  name       = "${var.existing_network}-${split("/",replace(var.existing_dest_ranges[count.index],".","-"))[0]}-route01"
  network    = data.google_compute_network.new_network.name
  dest_range = var.existing_dest_ranges[count.index]
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.new_exist_tunnel[0].id
}

resource "google_compute_route" "existing_network_route_2" {
  count      = length(var.existing_dest_ranges)

  project    = var.new_project
  name       = "${var.existing_network}-${split("/",replace(var.existing_dest_ranges[count.index],".","-"))[0]}-route02"
  network    = data.google_compute_network.new_network.name
  dest_range = var.existing_dest_ranges[count.index]
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.new_exist_tunnel[1].id
}