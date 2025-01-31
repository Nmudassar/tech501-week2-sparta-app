- [MongoDB Setup, Application Start, and Connectivity Check on Ubuntu VM (Azure)](#mongodb-setup-application-start-and-connectivity-check-on-ubuntu-vm-azure)
  - [Prerequisites:](#prerequisites)
  - [Steps:](#steps)
    - [1. SSH into the VM](#1-ssh-into-the-vm)
    - [2. Update the Package List](#2-update-the-package-list)
    - [3. Upgrade Existing Packages (Optional)](#3-upgrade-existing-packages-optional)
    - [4. Check Nginx Status (Optional)](#4-check-nginx-status-optional)
    - [5. Install or Update Packages (Optional)](#5-install-or-update-packages-optional)
    - [6. Install MongoDB (If Required)](#6-install-mongodb-if-required)
    - [7. Set the `DB_HOST` Environment Variable](#7-set-the-db_host-environment-variable)
    - [8. Start the Application](#8-start-the-application)
    - [9. Troubleshoot SSH Session Closing Unexpectedly](#9-troubleshoot-ssh-session-closing-unexpectedly)
      - [Prevent SSH Timeouts:](#prevent-ssh-timeouts)
      - [Optional: Use `autossh` to Keep SSH Alive](#optional-use-autossh-to-keep-ssh-alive)
    - [10. Verify Database Connectivity from the Application VM](#10-verify-database-connectivity-from-the-application-vm)
  - [Troubleshooting:](#troubleshooting)
- [List of commands](#list-of-commands)
  - [1. SSH into the VM](#1-ssh-into-the-vm-1)
  - [2. Update the package list](#2-update-the-package-list-1)
  - [3. Upgrade existing packages](#3-upgrade-existing-packages)
  - [4. Check Nginx status](#4-check-nginx-status)
  - [5. Install or update packages (curl, gnupg)](#5-install-or-update-packages-curl-gnupg)
  - [6. Add MongoDB PGP key](#6-add-mongodb-pgp-key)
  - [7. Add MongoDB repository](#7-add-mongodb-repository)
  - [8. Update package list again](#8-update-package-list-again)
  - [9. Install MongoDB (specific version)](#9-install-mongodb-specific-version)
  - [10. Start MongoDB service](#10-start-mongodb-service)
  - [11. Enable MongoDB to start on boot](#11-enable-mongodb-to-start-on-boot)
  - [12. Check MongoDB status](#12-check-mongodb-status)
  - [13. Set the DB_HOST environment variable](#13-set-the-db_host-environment-variable)
  - [14. Verify DB_HOST variable](#14-verify-db_host-variable)
  - [15. Start the Node.js application](#15-start-the-nodejs-application)
  - [16. Troubleshoot SSH session closing by editing SSH configuration file](#16-troubleshoot-ssh-session-closing-by-editing-ssh-configuration-file)
  - [17. Add settings to prevent SSH timeouts](#17-add-settings-to-prevent-ssh-timeouts)
  - [Add the following lines to sshd_config:](#add-the-following-lines-to-sshd_config)
  - [18. Restart SSH service](#18-restart-ssh-service)
  - [19. Use autossh to reconnect SSH session automatically](#19-use-autossh-to-reconnect-ssh-session-automatically)
- [20. Ping the database VM to check connectivity from the app VM](#20-ping-the-database-vm-to-check-connectivity-from-the-app-vm)

# MongoDB Setup, Application Start, and Connectivity Check on Ubuntu VM (Azure)

This document provides detailed instructions for setting up MongoDB on an Ubuntu VM, connecting your Node.js application to the database, and ensuring connectivity between the application VM and the database VM. Additionally, it covers troubleshooting SSH disconnections and checking if the app can successfully connect to MongoDB.

## Prerequisites:

- SSH access to an Ubuntu VM (Azure)
- MongoDB installation and updates
- Node.js application setup
- Basic knowledge of Ubuntu commands and system management

---

## Steps:

### 1. SSH into the VM

To connect to the Ubuntu VM using SSH, run the following command:

```bash
ssh -i ~/.ssh/tech501-nadia-az-key adminuser@20.77.114.100
```

When prompted to confirm the authenticity of the host, type `yes`:

```bash
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
```

### 2. Update the Package List

Once logged in, update the system’s package list to make sure all packages are up-to-date:

```bash
sudo apt-get update -y
```

### 3. Upgrade Existing Packages (Optional)

To upgrade all existing packages:

```bash
sudo apt-get upgrade -y
```

### 4. Check Nginx Status (Optional)

To check if Nginx is running:

```bash
sudo systemctl status nginx
```

If Nginx is active, the output will show the process running.

### 5. Install or Update Packages (Optional)

To install missing packages such as `curl` and `gnupg`:

```bash
sudo apt-get install gnupg curl
```

### 6. Install MongoDB (If Required)

If MongoDB is not installed or if you need to upgrade, follow these steps:

- **Add the MongoDB PGP Key**:

  ```bash
  curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
  ```

- **Add the MongoDB Repository**:

  ```bash
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
  ```

- **Update Package List Again**:

  ```bash
  sudo apt-get update -y
  ```

- **Install MongoDB (Specific Version)**:
  Install MongoDB version 7.0.6:

  ```bash
  sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6
  ```

- **Start the MongoDB Service**:

  ```bash
  sudo systemctl start mongod
  ```

- **Enable MongoDB to Start on Boot**:

  ```bash
  sudo systemctl enable mongod
  ```

- **Check MongoDB Status**:
  To verify MongoDB is running:
  ```bash
  sudo systemctl status mongod
  ```

---

### 7. Set the `DB_HOST` Environment Variable

Set the `DB_HOST` environment variable for your Node.js application to connect to MongoDB. Run the following command:

```bash
export DB_HOST="mongodb://10.0.3.5:27017"
```

To verify that the variable is set correctly, use:

```bash
printenv DB_HOST
```

The output should display:

```bash
mongodb://10.0.3.5:27017
```

### 8. Start the Application

Start your Node.js application:

```bash
npm start
```

The app should output:

```bash
Your app is ready and listening on port 3000
```

### 9. Troubleshoot SSH Session Closing Unexpectedly

If the SSH session closes unexpectedly (e.g., "Connection to 20.77.114.83 closed by remote host"), follow these steps:

#### Prevent SSH Timeouts:

- **Edit the SSH Configuration File**:

  ```bash
  sudo nano /etc/ssh/sshd_config
  ```

- **Add the Following Lines**:

  ```bash
  ClientAliveInterval 300
  ClientAliveCountMax 0
  ```

- **Restart the SSH Service**:
  ```bash
  sudo systemctl restart sshd
  ```

#### Optional: Use `autossh` to Keep SSH Alive

To automatically reconnect the SSH session if it drops, install `autossh`:

```bash
sudo apt-get install autossh
```

Then, use `autossh` to keep the session alive:

```bash
autossh -M 0 -i ~/.ssh/tech501-nadia-az-key adminuser@20.77.114.100
```

---

### 10. Verify Database Connectivity from the Application VM

After setting up the environment and starting the application, you need to ensure that the application VM can connect to the database VM. To verify this:

- **Ping the Database VM**:
  Test the connectivity from the application VM to the database VM using the `ping` command:

  ```bash
  ping 10.0.3.5
  ```

  If the ping succeeds, it confirms that the application VM can reach the database VM.

- **Verify MongoDB Connection**:
  Run the application and check the database connection. If there is no error, it indicates a successful connection. You can also verify the application’s database connection within the app's logs or code if any connection failure messages are shown.

---

## Troubleshooting:

- **MongoDB Connection Error**:
  If your application cannot connect to MongoDB, ensure that MongoDB is running on `mongodb://10.0.3.5:27017`. Check firewall rules and make sure MongoDB is listening on the correct IP and port.

- **SSH Session Timeout**:
  If the SSH session disconnects due to inactivity, use the configuration steps outlined above to keep the session alive.

- **Database Connectivity Issues**:
  If the application is not connecting to the database:
  - Check if the database IP (`10.0.3.5`) is correct and reachable.
  - Verify MongoDB’s binding IP by checking the MongoDB configuration (`/etc/mongod.conf`), ensuring that it binds to the correct interface.

---

# List of commands

## 1. SSH into the VM

ssh -i ~/.ssh/tech501-nadia-az-key adminuser@20.77.114.100

## 2. Update the package list

sudo apt-get update -y

## 3. Upgrade existing packages

sudo apt-get upgrade -y

## 4. Check Nginx status

sudo systemctl status nginx

## 5. Install or update packages (curl, gnupg)

sudo apt-get install gnupg curl

## 6. Add MongoDB PGP key

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

## 7. Add MongoDB repository

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

## 8. Update package list again

sudo apt-get update -y

## 9. Install MongoDB (specific version)

sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6

## 10. Start MongoDB service

sudo systemctl start mongod

## 11. Enable MongoDB to start on boot

sudo systemctl enable mongod

## 12. Check MongoDB status

sudo systemctl status mongod

## 13. Set the DB_HOST environment variable

export DB_HOST="mongodb://10.0.3.5:27017"

## 14. Verify DB_HOST variable

printenv DB_HOST

## 15. Start the Node.js application

npm start

## 16. Troubleshoot SSH session closing by editing SSH configuration file

sudo nano /etc/ssh/sshd_config

## 17. Add settings to prevent SSH timeouts

## Add the following lines to sshd_config:

ClientAliveInterval 300
ClientAliveCountMax 0

## 18. Restart SSH service

sudo systemctl restart sshd

## 19. Use autossh to reconnect SSH session automatically

autossh -M 0 -i ~/.ssh/tech501-nadia-az-key adminuser@20.77.114.100

# 20. Ping the database VM to check connectivity from the app VM

ping 10.0.3.5

```

```
