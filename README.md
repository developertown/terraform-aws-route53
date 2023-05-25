# terraform-aws-route53

Manages a Route53 zone and optionally name servers for the zone in a parent or apex zone.

## Usage

### Basic

Create a Route 53 Zone in the Authenticated AWS Account

<details open>
  <summary>Terragrunt</summary>

```hcl
terraform {
  source = "git::https://github.com/developertown/terraform-aws-route53.git?ref=vVERSION"
}

inputs = {
  region   = "us-east-1"
  dns_name = "somedomain.com"
}
```

</details>

<details>
  <summary>Terraform</summary>

```hcl
module "apex_zone" {
  source  = "github.com/developertown/terraform-aws-route53.git"
  version = "VERSION"

  region   = "us-east-1"
  dns_name = "somedomain.com"
}
```

</details>

### Basic Subdomain

Create a Route 53 Zone in the Authenticated AWS Account. Add Nameserver (NS) Records to Zone `ZXXXXXXXXXXXXXXXXXXXX` which is also managed by the Authenticated AWS Account

<details open>
  <summary>Terragrunt</summary>

```hcl
terraform {
  source = "git::https://github.com/developertown/terraform-aws-route53.git?ref=vVERSION"
}

inputs = {
  region             = "us-east-1"
  dns_name           = "subdomain.somedomain.com"
  parent_dns_zone_id = "ZXXXXXXXXXXXXXXXXXXXX"
}
```

</details>

<details>
  <summary>Terraform</summary>

```hcl
module "apex_zone" {
  source  = "github.com/developertown/terraform-aws-route53.git"
  version = "VERSION"

  region             = "us-east-1"
  dns_name           = "subdomain.somedomain.com"
  parent_dns_zone_id = "ZXXXXXXXXXXXXXXXXXXXX"
}
```

</details>

### Assume Role

Create a Route 53 Zone by Assuming Role into another AWS Account

<details open>
  <summary>Terragrunt</summary>

```hcl
terraform {
  source = "git::https://github.com/developertown/terraform-aws-route53.git?ref=vVERSION"
}

inputs = {
  region   = "us-east-1"
  role_arn = "arn:aws:iam::XXXXXXXXXXXX:role/SomeRole"
  dns_name = "somedomain.com"
}
```

</details>

<details>
  <summary>Terraform</summary>

```hcl
module "apex_zone" {
  source  = "github.com/developertown/terraform-aws-route53.git"
  version = "VERSION"

  region   = "us-east-1"
  role_arn = "arn:aws:iam::XXXXXXXXXXXX:role/SomeRole"
  dns_name = "somedomain.com"
}
```

</details>

### Assume Role Subdomain

Create a Route 53 Zone by Assuming Role into another AWS Account. Add Nameserver (NS) Records to Zone `ZXXXXXXXXXXXXXXXXXXXX` which is managed by the Authenticated AWS Account. Use `parent_role_arn` if the `parent_dns_zone_id` requires an assumed role to be accessible.

<details open>
  <summary>Terragrunt</summary>

```hcl
terraform {
  source = "git::https://github.com/developertown/terraform-aws-route53.git?ref=vVERSION"
}

inputs = {
  region             = "us-east-1"
  role_arn           = "arn:aws:iam::XXXXXXXXXXXX:role/SomeRole"
  dns_name           = "subdomain.somedomain.com"
  parent_dns_zone_id = "ZXXXXXXXXXXXXXXXXXXXX"
  #parent_role_arn    = "arn:aws:iam::XXXXXXXXXXXX:role/SomeOtherRole"
}
```

</details>

<details>
  <summary>Terraform</summary>

```hcl
module "apex_zone" {
  source  = "github.com/developertown/terraform-aws-route53.git"
  version = "VERSION"

  region             = "us-east-1"
  role_arn           = "arn:aws:iam::XXXXXXXXXXXX:role/SomeRole"
  dns_name           = "subdomain.somedomain.com"
  parent_dns_zone_id = "ZXXXXXXXXXXXXXXXXXXXX"
  #parent_role_arn    = "arn:aws:iam::XXXXXXXXXXXX:role/SomeOtherRole"
}
```

</details>

## Providers

| Name            | Version     |
| --------------- | ----------- |
| `hashicorp/aws` | `~> 4.36.1` |

## Inputs

| Input              | Description                                                       | Default | Required |
| ------------------ | ----------------------------------------------------------------- | ------- | -------- |
| region             | AWS Region to create resources in                                 | N/A     | Yes      |
| tags               | A set of key/value label pairs to assign to this to the resources | `{}`    | No       |
| role_arn           | The AWS assume role                                               | `""`    | No       |
| dns_name           | The DNS zone to create                                            | N/A     | Yes      |
| dns_ttl            | The TTL for Route53 NS Records                                    | `60`    | No       |
| parent_dns_zone_id | The Route53 Zone to create an NS Record                           | `""`    | No       |
| parent_role_arn    | The AWS assume role                                               | `""`    | No       |

## Outputs

| Output       | Description                             |
| ------------ | --------------------------------------- |
| domain_name  | The domain name created in the dns zone |
| name_servers | The name servers for the dns zone       |
| zone_id      | The Route53 Zone ID                     |
