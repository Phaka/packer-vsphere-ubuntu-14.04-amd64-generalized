# Setting the locales, country
# Supported locales available in /usr/share/i18n/SUPPORTED
d-i debian-installer/language string en
d-i debian-installer/country string us
d-i debian-installer/locale string en_US.UTF-8

# Keyboard setting
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/layoutcode string us
d-i keyboard-configuration/xkb-keymap us
d-i keyboard-configuration/modelcode string pc105

# User creation
d-i passwd/user-fullname string ${ ssh_username }
d-i passwd/username string ${ ssh_username }
d-i passwd/user-password password ${ ssh_password }
d-i passwd/user-password-again password ${ ssh_password }
d-i user-setup/allow-password-weak boolean true

# Disk and Partitioning setup
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string regular
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# Set root password
d-i passwd/root-login boolean true
d-i passwd/root-password password ${ ssh_password }
d-i passwd/root-password-again password ${ ssh_password }

# Package installations
d-i pkgsel/include string open-vm-tools openssh-server
d-i grub-installer/only_debian boolean true
d-i preseed/late_command string \
    echo '${ ssh_username } ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/${ ssh_username } ; \
    in-target chmod 440 /etc/sudoers.d/${ ssh_username } ;

d-i finish-install/reboot_in_progress note