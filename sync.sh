#!/bin/bash

# n8n Workflow Sync Script
# This script syncs your local workflow changes with GitHub and optionally triggers n8n cloud pull

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration (you can modify these)
N8N_INSTANCE_URL=""  # Your n8n cloud instance URL (e.g., https://your-instance.n8n.cloud)
N8N_API_KEY=""       # Your n8n API key (get from Settings -> API in n8n)

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Function to sync with GitHub
sync_github() {
    echo "🔄 Syncing with GitHub..."
    
    # Add all workflow changes
    git add workflows/*.json README.md .gitignore 2>/dev/null || true
    
    if [[ -z $(git status -s) ]]; then
        print_warning "No local changes to commit"
    else
        # Show what's changed
        echo "📝 Changed files:"
        git status -s
        
        # Get commit message
        echo -n "Enter commit message (or press Enter for default): "
        read commit_msg
        if [ -z "$commit_msg" ]; then
            commit_msg="Update workflows $(date '+%Y-%m-%d %H:%M:%S')"
        fi
        
        # Commit changes
        git commit -m "$commit_msg"
        print_status "Changes committed"
    fi
    
    # Pull and push
    echo "⬇️  Pulling latest from GitHub..."
    git pull --rebase origin main
    
    echo "⬆️  Pushing to GitHub..."
    git push origin main
    print_status "Synced with GitHub"
}

# Main execution
echo "🚀 n8n Workflow Sync Tool"
echo "========================"
sync_github

if [ -n "$N8N_INSTANCE_URL" ] && [ -n "$N8N_API_KEY" ]; then
    echo "☁️  Triggering n8n cloud pull..."
    curl -s --request POST \
        --location "${N8N_INSTANCE_URL}/api/v1/source-control/pull" \
        --header 'Content-Type: application/json' \
        --header "X-N8N-API-KEY: ${N8N_API_KEY}" \
        --data '{"force": true}'
    print_status "n8n cloud updated"
else
    print_warning "n8n cloud sync not configured"
    echo "To enable: Edit sync.sh and add N8N_INSTANCE_URL and N8N_API_KEY"
fi
