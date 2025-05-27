locals {
  public_subnet_map      = zipmap(local.az_slice, var.public_subnet)
  private_subnet_map     = zipmap(local.az_slice, var.private_subnet)
  public_subnet_map_keys = keys(local.public_subnet_map)
  az_slice               = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet))

}