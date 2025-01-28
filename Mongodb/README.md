# MongoDB Installation and Configuration

## Prerequisites

1. **Ubuntu 22.04** server.
2. **SSH** access to the server.
3. **MongoDB version** 7.0.6.

## Steps to Install MongoDB

### 1. Update and Upgrade the System

Run the following commands to update and upgrade your system packages:

```bash
sudo apt-get update -y
sudo apt-get upgrade -y
```

````

### 2. Install Dependencies

Install required tools for downloading MongoDB:

```bash
sudo apt-get install gnupg curl -y
```

### 3. Import MongoDB GPG Key

Download the MongoDB GPG key:

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
```

### 4. Create MongoDB Repository List

Create the list file for MongoDB repository:

```bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
```

### 5. Update Package List

After adding the repository, update your package list:

```bash
sudo apt-get update -y
```

### 6. Install MongoDB

Install MongoDB components needed for the system:

```bash
sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 \
   mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6
```

### 7. Start MongoDB

Start the MongoDB service:

```bash
sudo systemctl start mongod
```

### 8. Configure MongoDB Bind IP

By default, MongoDB accepts connections only from the local machine. To allow connections from other machines (e.g., your application server), update the bind IP.

Open MongoDB configuration file:

```bash
sudo nano /etc/mongod.conf
```

Find the line with `bindIp: 127.0.0.1` and change it to:

```yaml
bindIp: 0.0.0.0
```

This will allow MongoDB to accept connections from any IP. **Note:** In a production environment, restrict this to trusted IPs.

Save the file and exit.

### 9. Restart MongoDB

Restart the MongoDB service to apply the changes:

```bash
sudo systemctl restart mongod
```

### 10. Verify MongoDB Status

To check if MongoDB is running:

```bash
sudo systemctl status mongod
```

## Connect Your App to MongoDB

1. **Set up the Database Host**: Use the IP address of the MongoDB server in your app configuration.
2. **Set the Environment Variable**: In your app's environment, set the `DB_HOST` variable to the IP address of your MongoDB server:
   ```bash
   export DB_HOST=your_mongo_ip
   ```
3. **Start the App**: After setting the `DB_HOST`, ensure that your app is configured to connect to the MongoDB instance.

### Troubleshooting

- If MongoDB is not running, ensure you start the service using `sudo systemctl start mongod`.
- If connection errors occur, double-check the firewall and network security group settings to ensure proper communication between your app and the MongoDB server.

```

```
````
