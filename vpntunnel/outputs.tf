output "existing_network_id" {
  value = data.google_compute_network.existing_network.id
}
output "existing_network_name" {
  value = data.google_compute_network.existing_network.name
}
output "new_network_id" {
  value = data.google_compute_network.new_network.id
}
output "new_network_name" {
  value = data.google_compute_network.new_network.name
}
output "existing_vpngw01_id" {
  value = data.google_compute_vpn_gateway.existing_vpngw[0].id
}
output "existing_vpngw01_ip_address" {
  value = data.google_compute_address.existing_vpngw_ip[0].address
}
output "existing_vpngw02_id" {
  value = data.google_compute_vpn_gateway.existing_vpngw[1].id
}
output "existing_vpngw02_ip_address" {
  value = data.google_compute_address.existing_vpngw_ip[1].address
}
output "new_vpngw01_id" {
  value = data.google_compute_vpn_gateway.new_vpngw[0].id
}
output "new_vpngw01_ip_address" {
  value = data.google_compute_address.new_vpngw_ip[0].address
}
output "new_vpngw02_id" {
  value = data.google_compute_vpn_gateway.new_vpngw[1].id
}
output "new_vpngw02_ip_address" {
  value = data.google_compute_address.new_vpngw_ip[1].address
}
