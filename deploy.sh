#!/bin/bash

# Exit immediately if any command fails
set -e

# Set variables
PROJECT_ID="YOUR_PROJECT_ID"  # Replace with your GCP project ID
IMAGE_NAME="fastapi-app"
REGION="YOUR_REGION"          # https://cloud.google.com/compute/docs/regions-zones

# Authenticate with Google Cloud (ensure gcloud CLI is already set up)
echo "Authenticating with Google Cloud..."
gcloud auth login

# Set the active project
echo "Setting project to $PROJECT_ID..."
gcloud config set project $PROJECT_ID

# Build the Docker image and push it to Container Registry
echo "Building Docker image..."
gcloud builds submit --tag gcr.io/$PROJECT_ID/$IMAGE_NAME

# Deploy the image to Cloud Run
echo "Deploying to Cloud Run..."
gcloud run deploy $IMAGE_NAME \
    --image gcr.io/$PROJECT_ID/$IMAGE_NAME \
    --platform managed \
    --region $REGION \
    --allow-unauthenticated \
    --env-vars-file .env

# Output the service URL
SERVICE_URL=$(gcloud run services describe $IMAGE_NAME --region $REGION --format="value(status.url)")
echo "Deployment successful! Your service is running at: $SERVICE_URL"
