source "virtualbox-iso" "basic" {
    guest_os_type = "Ubuntu_64"
    vm_name = "packer-ubuntu-{{timestamp}}-18.04-amd64"
    iso_url = "https://releases.ubuntu.com/18.04.5/ubuntu-18.04.5-live-server-amd64.iso"
    iso_checksum_type = "sha256"
    iso_checksum = "3756b3201007a88da35ee0957fbe6666c495fb3d8ef2e851ed2bd1115dc36446"
    ssh_username = "ubuntu"
    ssh_password = "ubuntu"
    ssh_port = 22
    ssh_wait_timeout = "1800s"
    guest_additions_path = "VBoxGuestAdditions.iso"
}

build {
    source = [
        "source.virtualbox-iso.basic"
    ]
    provisioner "shell" {
        inline = ["echo \" >>>> Hello, World <<<< \""]
    }
}
