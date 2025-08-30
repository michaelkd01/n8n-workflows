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

## Automation Scripts

This repository includes automation scripts to streamline your workflow management:

### sync.sh - Interactive Sync Tool
A comprehensive script for managing workflow synchronization:

```bash
# Make the script executable
chmod +x sync.sh

# Run the sync tool
./sync.sh
```

Features:
- Push local changes to GitHub & n8n cloud
- Pull from GitHub to local
- Export workflows from n8n cloud
- Configure n8n cloud connection
- Interactive menu system

### watch-and-sync.sh - Auto-Sync Watcher
Automatically syncs changes when you save workflow files:

```bash
# Make the script executable
chmod +x watch-and-sync.sh

# Start watching for changes
./watch-and-sync.sh
```

Features:
- Watches for changes in workflows/ directory
- Auto-commits and pushes to GitHub
- Triggers n8n cloud pull (if configured)
- Waits 5 seconds after last change before syncing

### Initial Setup

1. **Configure n8n API Access:**
   ```bash
   # Run sync.sh and choose option 5
   ./sync.sh
   # Enter your n8n instance URL and API key
   ```

2. **Get your n8n API Key:**
   - Go to your n8n cloud instance
   - Navigate to Settings → API
   - Generate or copy your API key

3. **Install fswatch (optional, for better performance on macOS):**
   ```bash
   brew install fswatch
   ```

### Workflow Examples

#### Continuous Development Mode
```bash
# In one terminal, start the watcher
./watch-and-sync.sh

# Edit your workflows in another window
# Changes will auto-sync to GitHub and n8n cloud
```

#### Manual Sync Mode
```bash
# Make your changes, then run
./sync.sh
# Choose option 1 to push everything
```

#### Pull Latest from n8n Cloud
```bash
./sync.sh
# Choose option 3 to export from n8n cloud
```
