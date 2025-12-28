 AWS Three-Tier Architecture Project

This project demonstrates a **highly available, scalable, and secure three-tier architecture** on AWS using **VPC, EC2, RDS, ALB, and Route 53, certificate Manager**.

**Architecture Overview:**  
(User → Internet-Facing LB → Web Server → Internal LB → App Server → RDS Database)

---

## Project Overview

**Three Tiers:**
- **Web Tier (Public)** – Handles user requests via Internet-facing Load Balancer
- **Application Tier (Private)** – Handles business logic and API requests via internal Load Balancer
- **Database Tier (Private)** – Stores application data in RDS (MySQL)

---

## Step-by-Step Implementation

1. **Create VPC**  
   CIDR: `10.0.0.0/16`

2. **Create Subnets**  
   - Web Server (Public): 2 subnets  
   - App Server (Private): 2 subnets  
   - Database (Private): 2 subnets  

3. **Route Tables**  
   - **Public:** Routes via Internet Gateway  
   - **Private:** Routes via NAT Gateway (for App Server)  
   - **Database:** Private, optional NAT for patching  

4. **Security Groups**  
   - **WebServer-SG:** SSH, HTTP, HTTPS (all traffic from `0.0.0.0/0`)  
   - **AppServer-SG:** Ports `5000`, `80`, `443` from WebServer-SG; SSH from WebServer-SG  
   - **DB-SG:** Port `3306` from AppServer-SG  
   - Optional: Add extra 2 SGs for more segmentation (Total 5 SGs)

5. **Route 53**  
   - Create a hosted zone  
   - Map your domain NS records  
   - Create A-records pointing to Load Balancers  

6. **ACM SSL Certificate**  
   - Validate domain via Route 53 CNAME  
   - Attach SSL to Frontend Load Balancer  

7. **Create RDS (MySQL)**  
   - DB Subnet Group with 2 private subnets  
   - Security Group: DB-SG  
   - Database: `ThreeTierProjDb`  

8. **Launch Web Server EC2**  
   - Public subnet  
   - Security Group: WebServer-SG  

9. **Launch App Server EC2**  
   - Private subnet  
   - Security Group: AppServer-SG  

10. **SSH into App Server**
   ```bash
   vi <YourKey.pem>            # Open your PEM file to verify contents
   chmod 400 <YourKey.pem>     # Set secure permissions
   ssh -i <YourKey.pem> ec2-user@<App-Server-Private-IP>  # Connect to App Server

11. **Setup Database**
bash
Copy code
sudo yum install mysql -y
mysql -h <RDS-Endpoint> -P 3306 -u admin -p
# Use commands.sql to create DB, tables, and insert sample data

12. **Setup App Server**
bash
Copy code
sudo yum install python3 python3-pip -y
pip3 install flask flask-mysql-connector flask-cors
nohup python3 app.py > output.log 2>&1 &
ps -ef | grep app.py
curl http://localhost:5000/login

13. **Setup Web Server**
bash
Copy code
sudo yum install httpd -y
sudo service httpd start
cd /var/www/html/
touch index.html script.js styles.css

14. **Create Application Load Balancers**
Backend LB (App Server)
Target Group: Port 5000, Health check /login
Listener: Port 80

15. **Frontend LB (Web Server)**
Target Group: Port 80, Health check /
Listener: Port 80

16. **Configure Route 53**
Create A-record pointing to Frontend LB (alias)

17. **Attach ACM Certificate**
Apply SSL to Frontend LB for HTTPS support


**Notes**
Replace <YourKey.pem> and <App-Server-Private-IP> with your actual PEM key and private IP
All passwords in commands.sql are for demo purposes only
Security groups follow the least privilege principle
Architecture is highly available, scalable, and modular