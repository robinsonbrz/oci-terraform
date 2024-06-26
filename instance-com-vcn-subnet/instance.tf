// Copyright (c) 2017, 2024, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "fingerprint" {}

variable "private_key_path" {}

variable "region" {}

variable "compartment_ocid" {}

variable "ssh_public_key" {}

variable "route_table_display_name" {}

variable "instancia_display_name" {}

variable "vnic_display_name" {}

variable "subnet_display_name" {}

variable "subnet_dns_label" {}

variable "vcn_display_name" {}

variable "vcn_dns_label" {}

variable "internet_gateway_display_name" {}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "1"
}

# Defines the number of volumes to create and attach to each instance
# NOTE: Changing this value after applying it could result in re-attaching existing volumes to different instances.
# This is a result of using 'count' variables to specify the volume and instance IDs for the volume attachment resource.
variable "num_iscsi_volumes_per_instance" {
  default = "1"
}

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}


variable "instance_ocpus" {
  default = 1
}

variable "instance_vcpus" {
  default = 1
}

variable "instance_shape_config_memory_in_gbs" {
  default = 1
}

variable "instance_image_ocid" {
  type = map(string)

  default = {
    # descreva a abaixo a imagem e a sua região 
    # São Paulo Canonical-Ubuntu-22.04-2024.02.18-0
    # https://docs.oracle.com/en-us/iaas/images/image/6c21715a-0ab7-4a1c-81bd-ea13855f9505/
    sa-saopaulo-1 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaafofcjtufgtru2pebgnmxprwk6ihl5gpwvv2efi2yttovfgiluvvq"
  }
}


resource "oci_core_instance" "tf_instance" {
  count               = var.num_instances
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.instancia_display_name}${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.tf_subnet.id
    display_name              = var.vnic_display_name
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.instancia_display_name}${count.index}"
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region]
    # Apply this to set the size of the boot volume that is created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    boot_volume_size_in_gbs = "50"
    # kms_key_id = var.kms_key_ocid
  }

  # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  preserve_boot_volume = false

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
    # userdata provides custom initialization data to the instance.
    # The file must be in userdata folder. It runs only on creation of the instance
    user_data = base64encode(file("./userdata/bootstrap"))
  }

  timeouts {
    create = "60m"
  }
}

data "oci_core_instance_devices" "tf_instance_devices" {
  count       = var.num_instances
  instance_id = oci_core_instance.tf_instance[count.index].id
}

output "instance_private_ips" {
  value = [oci_core_instance.tf_instance.*.private_ip]
}

output "instance_public_ips" {
  value = [oci_core_instance.tf_instance.*.public_ip]
}

# Output the boot volume IDs of the instance
output "boot_volume_ids" {
  value = [oci_core_instance.tf_instance.*.boot_volume_id]
}

resource "oci_core_vcn" "tf_vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
}

resource "oci_core_internet_gateway" "tf_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = var.internet_gateway_display_name
  vcn_id         = oci_core_vcn.tf_vcn.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.tf_vcn.default_route_table_id
  display_name               = var.route_table_display_name

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.tf_internet_gateway.id
  }
}

resource "oci_core_subnet" "tf_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.1.20.0/24"
  display_name        = var.subnet_display_name
  dns_label           = var.subnet_dns_label
  security_list_ids   = [oci_core_vcn.tf_vcn.default_security_list_id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.tf_vcn.id
  route_table_id      = oci_core_vcn.tf_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.tf_vcn.default_dhcp_options_id
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

