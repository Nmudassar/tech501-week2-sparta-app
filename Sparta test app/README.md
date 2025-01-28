# Sparta test app


```markdown
# Setup and Run Node.js App on Azure Virtual Machine

This guide will walk you through the process of setting up and running a Node.js application on an Azure Virtual Machine (VM). The steps include updating the system, installing required packages, cloning the repository, and configuring the app to run on the VM.

## Prerequisites

- An Azure Virtual Machine running Ubuntu 22.04.5 LTS
- SSH access to the VM
- Basic knowledge of Linux commands and node.js

## Step 1: SSH into the Azure VM

SSH into your Azure VM using the following command:

```bash
ssh -i ~/.ssh/tech501-nadia-az-key adminuser@<VM_IP>
```

Replace `<VM_IP>` with the public IP address of your Azure VM.

## Step 2: Update the System Packages

To ensure all system packages are up to date, run the following commands:

```bash
sudo apt-get update -y
sudo apt-get upgrade -y
```

## Step 3: Install Nginx

If Nginx is not installed, you can install it using:

```bash
sudo apt-get install nginx -y
```

Check the status of Nginx to ensure it's running:

```bash
sudo systemctl status nginx
```

## Step 4: Install Node.js

Install Node.js (version 20.x) and npm by running the following commands:

```bash
sudo DEBIAN_FRONTEND=noninteractive bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -" && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
```

Verify the installation by checking the Node.js and npm versions:

```bash
node -v
npm -v
```

## Step 5: Clone the Application Repository

Clone the repository to your VM. If you already have a `repo/` directory, use a different name:

```bash
git clone https://github.com/Nmudassar/test-app.git repo1/
```

Navigate into the newly cloned directory:

```bash
cd repo1/app
```

## Step 6: Install Application Dependencies

Once inside the app directory, install the required dependencies using npm:

```bash
npm install
```

## Step 7: Run the Application

Start the application:

```bash
npm start
```

Your app should now be running and accessible on port **3000**. Open your browser and visit:

```
http://<VM_IP>:3000
```

Replace `<VM_IP>` with your Azure VM’s public IP.

## Step 8: Deprovision the VM for Image Creation

Once you confirm that the app is running correctly, you need to prepare the VM for creating an image. Run the following command to deprovision the VM:

```bash
sudo waagent -deprovision+user -force
```

This will remove the user’s home directory and any other sensitive information, preparing the VM to be captured as an image.

## Step 9: Create a VM Image in Azure Portal

After deprovisioning the VM, you can capture the VM as an image in the Azure portal. Follow these steps:

1. Go to **Virtual Machines** in the Azure portal.
2. Select the VM you want to capture.
3. Click **Capture** at the top of the VM’s page.
4. Provide an image name and choose the resource group and storage options.
5. Click **Create** to capture the image.

## Conclusion

You have successfully set up and run a Node.js app on an Azure Virtual Machine. Additionally, you have prepared the VM to be captured as an image, allowing you to create identical VMs for deployment.

If you need further assistance, feel free to open an issue in this repository or contact the maintainers.
```

### How to Use This File in VS Code:

1. Open VS Code and create a new file named `README.md`.
2. Copy and paste the content from above into the `README.md` file.
3. Save the file.
4. This `README.md` file provides clear instructions for replicating the process of setting up and running your Node.js app on an Azure VM.

Let me know if you need any further adjustments!