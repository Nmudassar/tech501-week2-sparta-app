# VM Deployment Automation Guide

## **Overview**
This document provides step-by-step instructions on how to deploy a fully automated virtual machine (VM) for your application using a custom image and user data. The goal is to eliminate manual SSH access and ensure that the application starts automatically after the VM is created.

---

## **1️⃣ Database Virtual Machine (MongoDB)**
### **Steps Taken:**
- A **custom image** of the database VM has been created.
- MongoDB is set to start automatically using:
  ```bash
  systemctl enable mongod
  ```
- MongoDB status is verified after boot:
  ```bash
  systemctl status mongod
  ```
- **Database VM is ready and does not require further configuration.**

---

## **2️⃣ Application Virtual Machine (Node.js App)**
### **Deployment Steps:**
- Create a new VM from the **ready-to-run application image**.
- Add the **user data script** to automate the application startup.

---

## **3️⃣ User Data (Cloud-Init) Script for Automation**
The following script should be pasted into the **Advanced → User Data** section during VM creation.

### **User Data Script:**
```bash
#!/bin/bash

# Update system packages
apt update && apt upgrade -y

# Navigate to the application folder
cd /home/azureuser/repo-folder

# Export database connection with private IP
export DATABASE_URL="mongodb://10.0.3.4:27017/mydatabase"

# Ensure dependencies are installed (only if necessary)
npm install

# Start the application using PM2
pm2 start app.js --name myapp
pm2 save
pm2 startup systemd
```

---

## **4️⃣ Final Checklist Before Creating the VM**
### ✅ **Network Security Group (NSG):**
- Ensure ports **80, 3000, 27017, and SSH (22)** are open.

### ✅ **Database Private IP Address:**
- Double-check that the MongoDB **private IP** is correct (e.g., `10.0.3.4`).

### ✅ **Correct Image Selection:**
- Ensure you are selecting the **application image** (not the database image).

### ✅ **User Data in Advanced Settings:**
- Paste the **full script** into the **User Data** field.
- Ensure the script starts with `#!/bin/bash`.

### ✅ **License Type:**
- Select **“Other”** if using a custom image.

### ✅ **PM2 Verification:**
If the app doesn’t start, try restarting PM2:
```bash
pm2 restart myapp
```
If PM2 isn’t installed, install it before creating the image:
```bash
npm install -g pm2
```

---

## **5️⃣ What Happens After VM Creation?**
- The **user data script runs ONCE** immediately after the VM is created.
- If the VM **restarts**, the user data **WILL NOT** run again.
- To ensure the app starts on reboot, run:
```bash
pm2 startup
pm2 save
```

---

## **6️⃣ Testing & Debugging**
### **If the app doesn’t start, check PM2:**
```bash
pm2 list
journalctl -u pm2 -n 50 --no-pager
```

### **If MongoDB isn’t connecting, check:**
```bash
netstat -tulnp | grep 27017  # Ensure MongoDB is listening
```

---

.

