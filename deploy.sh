#!/bin/bash

# Exit immediately if any command fails
# set -e

trap 'echo "Error occurred at line $LINENO while executing: $BASH_COMMAND"' ERR

# Set variables
PROJECT_ID="project_id"  # Replace with your GCP project ID
IMAGE_NAME="fastapi-app"
REGION="region"          # https://cloud.google.com/compute/docs/regions-zones
TIMESTAMP=$(date +%Y%m%d-%H%M%S)  # Generate a unique timestamp for each build
IMAGE_TAG="gcr.io/$PROJECT_ID/$IMAGE_NAME:$TIMESTAMP"

# Build the Flutter web app
echo "Building Flutter web app..."
cd frontend
flutter build web 
cd ..

cp -r frontend/build/web/* ./frontend_build

# Authenticate with Google Cloud (ensure gcloud CLI is already set up)
echo "Authenticating with Google Cloud..."
# gcloud auth login

# Set the active project
echo "Setting project to $PROJECT_ID..."
gcloud config set project $PROJECT_ID

# Build a fresh Docker image and push it to Container Registry
echo "Building and pushing Docker image: $IMAGE_TAG..."
gcloud builds submit --tag $IMAGE_TAG

# Deploy the newly built image to Cloud Run
echo "Deploying to Cloud Run..."
gcloud run deploy $IMAGE_NAME \
    --image $IMAGE_TAG \
    --platform managed \
    --region $REGION \
    --allow-unauthenticated \
    --env-vars-file .env

# Output the service URL
SERVICE_URL=$(gcloud run services describe $IMAGE_NAME --region $REGION --format="value(status.url)")
echo "Deployment successful! Your service is running at: $SERVICE_URL"
