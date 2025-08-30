#!/bin/bash

# n8n Workflow Auto-Sync Watcher
# Watches for changes and auto-syncs with GitHub

echo "�� n8n Workflow Auto-Sync Watcher"
echo "=================================="
echo ""
echo "Watching workflows/ directory..."
echo "Press Ctrl+C to stop"
echo ""

# Watch for changes (requires fswatch on macOS)
if command -v fswatch &> /dev/null; then
    fswatch -o workflows/ | while read change; do
        echo ""
        echo "📝 Changes detected, syncing..."
        sleep 2  # Wait a moment for all changes to complete
        ./sync.sh
        echo "✅ Sync complete, watching for more changes..."
    done
else
    echo "⚠️  fswatch not found. Install with: brew install fswatch"
    echo "Falling back to manual polling..."
    
    while true; do
        sleep 5
        if [ -n "$(git status -s workflows/)" ]; then
            echo "📝 Changes detected, syncing..."
            ./sync.sh
            echo "✅ Sync complete"
        fi
    done
fi
