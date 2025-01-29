
#!/bin/bash


# Step 2: Update the package list

sudo apt-get update -y


# Step 3: Upgrade existing packages

sudo apt-get upgrade -y


# Step 4: Check Nginx status
sudo systemctl status nginx


# Step 5: Install or update packages (curl, gnupg)
sudo apt-get install -y gnupg curl


# Step 6: Add MongoDB PGP key
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor


# Step 7: Add MongoDB repository
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list


# Step 8: Update package list again
sudo apt-get update -y

# Step 9: Install MongoDB (specific version)
sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6

# Step 10: Start MongoDB service
sudo systemctl start mongod

# Step 11: Enable MongoDB to start on boot
sudo systemctl enable mongod

# Step 12: Check MongoDB status
sudo systemctl status mongod
