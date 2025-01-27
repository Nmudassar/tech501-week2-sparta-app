# Sparta test app

## Step 1

- SSH into your vm : ssh -i ~/.ssh/tech501-nadia-az-key adminuser@20.11777.11.74
- uname --all - tells you about the image youre running.

## Step 2

- sudo apt-get update -y
- sudo apt-get upgrade -y.
- Purple tab will come up press tab and enter for "Ok"
- sudo apt install nginx -y - more user input is required press tab and then enter for "ok"
- sudo systemctl status nginx - check status of nginx
- sudo DEBIAN_FRONTEND=noninteractive bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -" && \ sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs -- Installation of Nodejs

## Step 3

- 1st Method:
  - Use the scp feature to copy all the files for the local repo to the VM
  -

!

- Second method:
  - Git clone command to get code from github repo to local machine.
  - Use git clone https://github.com/Nmudassar/tech501-sparta-app
  - Then go into the app folder
  - npm install there
  - npm start after that

!!![screenshot](<../../Screenshot 2025-01-27 200218.png>)
