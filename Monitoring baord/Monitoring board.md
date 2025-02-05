- [Azure Monitoring and Alerting Setup](#azure-monitoring-and-alerting-setup)
  - [Introduction](#introduction)
  - [Creating a Monitoring Dashboard](#creating-a-monitoring-dashboard)
  - [Installing Apache Bench (ab)](#installing-apache-bench-ab)
  - [Steps to Create an Action Group in Azure](#steps-to-create-an-action-group-in-azure)
  - [Steps to Create an Alert Rule in Azure Monitor](#steps-to-create-an-alert-rule-in-azure-monitor)
  - [Conculsion](#conculsion)

# Azure Monitoring and Alerting Setup

## Introduction

This guide provides step-by-step instructions to set up a monitoring dashboard, install Apache Bench for CPU stress testing, and create alert rules in Azure Monitor.

## Creating a Monitoring Dashboard

1. From the **VM Overview** page, navigate to **Monitoring**.
2. Pin the desired metrics like cpu Average , memory Average, and disk read ops/sec to the dashboard.
3. Choose **Create New Dashboard** and **Share** it.
4. From the **Dashboard Hub**, edit metrics to view them in one line.
5. Azure provides **1-minute interval checks**.
6. Change the local time filter to the **last 30 minutes** and save the dashboard.

## Installing Apache Bench (ab)

1. SSH into the virtual machine:
   ```sh
   ssh <your-vm-user>@<your-vm-ip>
   ```
2. Install Apache Bench:
   ```sh
   sudo apt-get install apache2-utils
   ```
3. Overload the CPU with HTTP requests:
   ```sh
   ab -n 1000 -c 100 http://<your-vm-ip>/
   ```
4. Observe CPU utilization increase on the dashboard.

## Steps to Create an Action Group in Azure

1. **Create an Action Group**

   - Go to **Azure Portal** → Navigate to **Monitor**.
   - Select **Alerts** → Click on **Manage actions**.
   - Click **Create action group**.
   - Fill in the details:
     - **Subscription**: Choose your Azure subscription.
     - **Resource Group**: Select an existing one or create a new one.
     - **Action Group Name**: e.g., `CPU_Alert_Group`.
     - **Display Name**: e.g., `CPU Alert`.

2. **Add an Email Notification**

   - Under **Notifications**, click **Add notification**.
   - Choose **Email/SMS message/Push/Voice**.
   - Enter your email address.
   - Click **OK**.

3. **Save and Use the Action Group**
   - Click **Review + Create**, then **Create**.
   - Now, when creating your CPU usage alert, select this action group.

## Steps to Create an Alert Rule in Azure Monitor

1. **Create an Alert Rule**

   - Go to **Azure Portal** → Navigate to **Monitor**.
   - Select **Alerts** → Click on **Create** → **Alert rule**.
   - Select the **Target Resource**:
     - Click **Select scope**.
     - Choose your **Virtual Machine (VM)** or relevant resource.
     - Click **Apply**.

2. **Define the Condition**
   - Click **Add condition**.
   - Select **Percentage CPU** under **Signals**.
   - Set the **Threshold value** to **greater than 3%**.
   - Configure **Aggregation Type** to **Average**.
   - Set **Evaluation Frequency** (e.g., every 1 minute).
   - Click **Done**.

!![Cpu](<Images1/Screenshot 2025-02-04 230615.png>)

1. **Configure the Action Group (Email Notification)**

   - Under **Actions**, click **Select action group**.
   - Click **Create action group**.
   - Fill in:
     - **Subscription & Resource Group**.
     - **Action Group Name** (e.g., `CPU_Alert_Group`).
   - Under **Notifications**, select **Email/SMS message/Push/Voice**.
   - Enter the **Email Address**.
   - Click **OK**.
     ![email alert](<Images1/Screenshot 2025-02-04 230641.png>)
     !

1. **Configure Alert Rule Details**
   - Name the alert rule (e.g., `High_CPU_Alert`).
   - Set the **Severity Level** (e.g., Informational, Warning, Critical).
   - (Optional) Enable **Automatically Resolve Alerts**.
   - Click **Create Alert Rule**.

!![alert eamil
](<Images1/Screenshot 2025-02-04 232718.png>)

## Conculsion

By following these steps, you will have set up an Azure monitoring dashboard, tested CPU load with Apache Bench, and configured alert rules to notify you of high CPU usage on your VM. This setup helps in proactive monitoring and alerting for system performance issues.
