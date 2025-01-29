### 1. **Backup the NGINX Configuration File**

Before making any changes, it's always a good idea to back up the configuration file:

```bash
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
```

### 2. **Edit the NGINX Configuration File**

Open the NGINX configuration file:

```bash
sudo nano /etc/nginx/sites-available/default
```

### 3. **Modify the `location /` Block**

Find the `location /` block in the configuration file and **modify** the `proxy_pass` line.

Replace the existing line:

```nginx
proxy_pass http://localhost:3000;
```

With:

```nginx
proxy_pass http://localhost:3000;
```

(It's essentially a copy-paste, but this confirms you have set up the correct proxy).

### 4. **Restart NGINX**

After editing the configuration file, restart NGINX:

```bash
sudo systemctl restart nginx
```

### 5. **Test the Reverse Proxy**

Test the reverse proxy by visiting the public IP of the server in your browser (without the `:3000` port):

```bash
http://<your-public-ip>
```

This should forward traffic to your Node.js application running on port 3000.

---

### Commands Summary:

1. **Backup NGINX config file**:

   ```bash
   sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
   ```

2. **Edit the NGINX config file**:

   ```bash
   sudo nano /etc/nginx/sites-available/default
   ```

3. **Restart NGINX**:
   ```bash
   sudo systemctl restart nginx
   ```
