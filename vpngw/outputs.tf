output "data_google_compute_network_network_id" {
  value   = data.google_compute_network.network.id
}

output "data_google_compute_network_network_name" {
  value   = data.google_compute_network.network.name
}

output "resource_google_compute_vpn_gateway_vpn_gateway_1_id" {
  value   = google_compute_vpn_gateway.vpn_gateway_1[*].id
}

output "resource_google_compute_vpn_gateway_vpn_gateway_2_id" {
  value   = google_compute_vpn_gateway.vpn_gateway_2[*].id
}

output "resource_google_compute_address_vpn_static_ip_1_address" {
  value   = google_compute_address.vpn_static_ip_1[*].address
}

output "resource_google_compute_address_vpn_static_ip_2_address" {
  value   = google_compute_address.vpn_static_ip_2[*].address
}
