locals {
  timestamp = formatdate("EEE, DD MMM YYYY hh:mm:ss ZZZ", timestamp())
  suffix = formatdate("YYYYMMDD'T'hhmm", timestamp())
  vm_name = "Ubuntu-14.04-amd64-${local.suffix}"
  iso_path = join("", [var.iso_path_prefix, var.iso_path])
  boot_commands = <<-EOT
    <enter><wait><f6><wait><esc><wait>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>
    <bs><bs><bs>
    /install/vmlinuz
     initrd=/install/initrd.gz
     priority=critical
     locale=en_US
     preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg
    <enter>
    EOT
}