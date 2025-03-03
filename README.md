# Infrastructure CI/CD Pipeline

This repository contains the infrastructure-as-code for our application stack, using Docker Compose to define and run multi-container Docker applications.

## Infrastructure Overview

The infrastructure consists of three PostgreSQL databases:

1. **KeyCloak Database** - Authentication and authorization service
2. **Member Database** - User management service 
3. **Drive Database** - Personal drive for the team

## CI/CD Pipeline

The CI/CD pipeline is implemented using GitHub Actions and automates the following:

1. Validates docker-compose configuration
2. Lints YAML files to ensure they follow best practices
3. Deploys to the target server using SSH
4. Notifies the team about deployment status

## Setup Instructions

### 1. Configure GitHub Secrets

Add the following secrets to your GitHub repository:

- `SSH_PRIVATE_KEY`: The private SSH key to access the server
- `KNOWN_HOSTS`: SSH known hosts file content for your server
- `SERVER_HOST`: The hostname or IP address of your server
- `SERVER_USER`: The username for SSH login
- `SLACK_WEBHOOK_URL`: (Optional) Webhook URL for Slack notifications

### 2. Generate an SSH Key Pair

If you don't already have an SSH key for CI/CD:

```bash
ssh-keygen -t ed25519 -C "github-actions-cicd"
```

Add the public key to your server's `~/.ssh/authorized_keys` file:

```bash
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
```

Add the private key content to your GitHub repository as the `SSH_PRIVATE_KEY` secret.

### 3. Generate Known Hosts Content

To get the known hosts content:

```bash
ssh-keyscan -H your-server-ip > known_hosts
```

Add the content of this file to your GitHub repository as the `KNOWN_HOSTS` secret.

### 4. Create Server Directory Structure

On your server, make sure to create the directory structure for the deployment:

```bash
mkdir -p ~/infrastructure/backups
```

### 5. Configure Server for Docker

Ensure Docker and Docker Compose are installed on your server:

```bash
sudo apt update
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
```

### 6. Manual Deployment Steps

For the first deployment, you may want to manually deploy to ensure everything is set up correctly:

```bash
cd ~/infrastructure
docker-compose -f docker-compose.local.yml up -d
```

## Usage

### Automatic Deployments

The workflow will automatically trigger when:

- Code is pushed to the `main` or `master` branch
- A pull request targeting the `main` or `master` branch is created

### Manual Deployments

You can also manually trigger the deployment by:

1. Going to the "Actions" tab in your GitHub repository
2. Selecting the "Deploy Infrastructure" workflow
3. Clicking "Run workflow"
4. Selecting the environment (production or staging)
5. Clicking "Run workflow"

## Extending the Pipeline

### Adding More Services

To add more services to your infrastructure:

1. Update the docker-compose file with the new services
2. Commit and push the changes
3. The CI/CD pipeline will automatically validate and deploy the changes

### Customizing Deployment Steps

To customize the deployment steps, edit the `.github/workflows/deploy-infrastructure.yml` file.

## Troubleshooting

### Common Issues

1. **SSH Connection Failures**: Ensure the SSH key and known hosts are configured correctly
2. **Docker Compose Validation Errors**: Validate your docker-compose file locally before pushing
3. **Failed Container Startup**: Check container logs using `docker logs container_name`

### Viewing Logs

To view logs of the deployed containers:

```bash
docker-compose -f docker-compose.local.yml logs -f
```