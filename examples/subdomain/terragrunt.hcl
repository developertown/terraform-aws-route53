include {
  path = find_in_parent_folders()
}

terraform {
  source = "../..//"
}

inputs = {
  region             = "us-east-1"
  dns_name           = "subdomain.somedomain.com"
  parent_dns_zone_id = "ZXXXXXXXXXXXXXXXXXXXX"
}
