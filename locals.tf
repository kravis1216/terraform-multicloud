locals {
  ## COMMON
  project = var.project
  env     = terraform.workspace == "default" ? var.environment : terraform.workspace

  ## Azure AD 
  domain_name = data.azuread_domains.aad_domains.domains.0.domain_name
  users       = csvdecode(file("./azuread_users.csv"))

  ## Type
  # https://docs.microsoft.com/ja-jp/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
  type_as   = "avail"
  type_rg   = "rg"
  type_nic  = "nic"
  type_snet = "snet"
  type_vm   = "vm"
  type_vnet = "vnet"
  type_workspaces     = "workspaces"

  ## Name/Prefix for Availability Zone
  as_prefix = "${local.project}-${local.env}-${local.type_as}"

  ## Name/Prefix for Resource Group
  rg_prefix = "${local.project}-${local.env}-${local.type_rg}"

  ## Name?prefix for Network Interface
  nic_prefix = "${local.project}-${local.env}-${local.type_nic}"

  ## Name/Prefix for Subnet
  snet_prefix = "${local.project}-${local.env}-${local.type_snet}"

  ## Name/Prefix for VM
  vm_prefix = "${local.project}-${local.env}-${local.type_vm}"

  ## Name/Prefix for VNet
  vnet_prefix = "${local.project}-${local.env}-${local.type_vnet}"

  ## Name/Prefix for Log Analytics Workspace
  workspaces_prefix = "${local.project}-${local.env}-${local.type_workspaces}"
}
