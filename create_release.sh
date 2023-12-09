#!/bin/bash

# GitHub API endpoint
API_URL="https://api.github.com/repos/muzafferjoya/eg-website/releases"


# Your GitHub Personal Access Token
TOKEN="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"

# Choose a tag for the release
read -p "Enter a tag for the release: " TAG

# Target commit for the tag
read -p "Enter the target commit (SHA) for the tag: " TARGET_COMMIT

# Generate release notes (replace this with your own logic)
RELEASE_NOTES=$(git log --pretty=format:"- %s" $TARGET_COMMIT..HEAD)

# Create a tag
git tag $TAG $TARGET_COMMIT
git push origin $TAG

# Draft a new release
API_RESPONSE=$(curl -L -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/muzafferjoya/eg-website/releases \
  -d '{
    "tag_name": "'$TAG'",
    "target_commitish": "'$TARGET_COMMIT'",
    "name": "'$TAG'",
    "body": "'$RELEASE_NOTES'",
    "draft": true,
    "prerelease": false,
    "generate_release_notes": true
  }')

echo "API Response:"
echo "$API_RESPONSE"


echo "Release draft created!"
