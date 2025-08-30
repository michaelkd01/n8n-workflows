# n8n Workflows Repository

This repository contains n8n workflows for automation and integration tasks.

## Repository Structure

```
n8n-workflows/
├── workflows/          # n8n workflow JSON files
├── credentials/        # Encrypted credentials (if using Git sync)
├── variables/          # Environment variables and configurations
└── README.md          # This file
```

## Workflows

### Team Meeting Prep
- **File**: `workflows/Team meeting prep.json`
- **Description**: Automated workflow for preparing team meeting notes
- **Schedule**: Runs every Monday at 4pm
- **Features**:
  - Fetches previous meeting notes from Google Drive
  - Retrieves pipeline reports
  - Creates consolidated meeting notes
  - Sends email notifications

## Setup Instructions

### 1. Local Development

To work with these workflows locally:

```bash
# Clone the repository
git clone https://github.com/michaelkd01/n8n-workflows.git
cd n8n-workflows

# Make changes to workflow files
# Edit JSON files in the workflows/ directory

# Commit and push changes
git add .
git commit -m "Update workflow"
git push origin main
```

### 2. n8n Cloud Integration

To sync these workflows with your n8n cloud instance:

1. **In n8n Cloud:**
   - Go to Settings → Source Control
   - Click "Connect to Git"
   - Choose GitHub as your provider
   - Authorize n8n to access your GitHub account
   - Select this repository: `michaelkd01/n8n-workflows`
   - Configure the branch: `main`
   - Set the workflow directory: `workflows/`

2. **Syncing Workflows:**
   - **Pull from Git**: Click "Pull" in n8n to fetch latest changes from GitHub
   - **Push to Git**: Click "Push" in n8n to save current workflows to GitHub

3. **Automated Sync (Optional):**
   - Set up webhooks to automatically pull changes when you push to GitHub
   - Use n8n API to trigger pulls programmatically:
   ```bash
   curl --request POST \
     --location '<YOUR-N8N-INSTANCE-URL>/api/v1/source-control/pull' \
     --header 'Content-Type: application/json' \
     --header 'X-N8N-API-KEY: <YOUR-API-KEY>' \
     --data '{"force": true}'
   ```

## Workflow Management

### Adding New Workflows
1. Export workflow from n8n as JSON
2. Save to `workflows/` directory
3. Commit and push to GitHub
4. Pull in n8n cloud to import

### Updating Existing Workflows
1. Edit the JSON file in `workflows/`
2. Commit and push changes
3. Pull in n8n cloud to update

### Best Practices
- Always pull before making changes to avoid conflicts
- Use descriptive commit messages
- Test workflows in development before pushing to production
- Keep sensitive data in n8n variables, not in workflow JSON

## Security Notes

- **Credentials**: Never commit actual credentials to Git
- **API Keys**: Use n8n's credential management system
- **Sensitive Data**: Store in environment variables or n8n variables
- **`.gitignore`**: Ensures sensitive files are not tracked

## Support

For issues or questions about these workflows, please create an issue in this repository.
