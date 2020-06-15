data "google_compute_network" "network" {
  name   = var.network
}

resource "google_compute_vpn_gateway" "vpn_gateway_1" {
  count   = length(var.regions)

  name    = "${var.network}-${var.regions[count.index]}-vpngw01"
  network = data.google_compute_network.network.id
  region  = var.regions[count.index]
}

resource "google_compute_vpn_gateway" "vpn_gateway_2" {
  count   = length(var.regions)

  name    = "${var.network}-${var.regions[count.index]}-vpngw02"
  network = data.google_compute_network.network.id
  region  = var.regions[count.index]
}

resource "google_compute_address" "vpn_static_ip_1" {
  count   = length(var.regions)

  name    = "${var.network}-${var.regions[count.index]}-vpngw01-ip"
  region  = var.regions[count.index]
}

resource "google_compute_address" "vpn_static_ip_2" {
  count   = length(var.regions)
  name    = "${var.network}-${var.regions[count.index]}-vpngw02-ip"
  region  = var.regions[count.index]
}

resource "google_compute_forwarding_rule" "fr_esp_1" {
  count       = length(var.regions)

  name        = "${var.network}${var.regions[count.index]}u"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip_1[count.index].address
  target      = google_compute_vpn_gateway.vpn_gateway_1[count.index].id
  region      = var.regions[count.index]
}

resource "google_compute_forwarding_rule" "fr_esp_2" {
  count       = length(var.regions)

  name        = "${var.network}${var.regions[count.index]}v"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip_2[count.index].address
  target      = google_compute_vpn_gateway.vpn_gateway_2[count.index].id
  region      = var.regions[count.index]
}

resource "google_compute_forwarding_rule" "fr_udp500_1" {
  count       = length(var.regions)

  name        = "${var.network}${var.regions[count.index]}w"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip_1[count.index].address
  target      = google_compute_vpn_gateway.vpn_gateway_1[count.index].id
  region      = var.regions[count.index]
}

resource "google_compute_forwarding_rule" "fr_udp500_2" {
  count       = length(var.regions)

  name        = "${var.network}${var.regions[count.index]}x"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip_2[count.index].address
  target      = google_compute_vpn_gateway.vpn_gateway_2[count.index].id
  region      = var.regions[count.index]
}

resource "google_compute_forwarding_rule" "fr_udp4500_1" {
  count       = length(var.regions)

  name        = "${var.network}${var.regions[count.index]}y"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip_1[count.index].address
  target      = google_compute_vpn_gateway.vpn_gateway_1[count.index].id
  region      = var.regions[count.index]
}

resource "google_compute_forwarding_rule" "fr_udp4500_2" {
  count       = length(var.regions)

  name        = "${var.network}${var.regions[count.index]}z"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip_2[count.index].address
  target      = google_compute_vpn_gateway.vpn_gateway_2[count.index].id
  region      = var.regions[count.index]
}
