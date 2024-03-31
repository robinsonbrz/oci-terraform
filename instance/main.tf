// Copyright (c) 2017, 2024, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro" # Free tier Shape
}

variable "instance_ocpus" { default = 1 }

variable "instance_shape_config_memory_in_gbs" { default = 1 }


/* Instances */
resource "oci_core_instance" "second-instance" {
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[0], "name")
  compartment_id      = var.compartment_ocid
  display_name        = "second-instance"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.subnet_id # oci_core_subnet.test_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "second-instance"
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.this.images.0.id # lookup(data.oci_core_images.test_images.images[0], "id")
    boot_volume_size_in_gbs = 50
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_authorized_keys)
  }

  preserve_boot_volume = false

}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "this" {
  compartment_id = var.compartment_ocid

  operating_system = "Canonical Ubuntu"
  shape            = var.instance_shape
  sort_by          = "TIMECREATED"
  sort_order       = "DESC"
  state            = "available"

  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-([\\.0-9-]+)$"]
    regex  = true
  }
}