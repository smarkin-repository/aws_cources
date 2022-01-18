    "provisioners": [
        {
            "type": "shell",
            "inline": "sudo yum install -y epel-release"
        },
        {
            "type": "shell",
            "inline": ["sudo yum install -y nginx","sudo systemctl enable nginx", "sudo systemctl start nginx"]
        },
        {
            "execute_command": "{{ .Vars }} sudo -E sh '{{ .Path }}'",
            "inline": [
              "apt-get -y update",
              "apt-get install -y unzip apt-transport-https ca-certificates fail2ban"
            ],
            "type": "shell"
        },
        {
            "type": "shell",
            "scripts": [
                "{{user `scriptdir`}}/install_httpd.sh"
            ]
        }