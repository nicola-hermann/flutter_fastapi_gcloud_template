# flutter_fastapi_gcloud_template
This is a template designed to get you up and running as fast as possible with the following techstack:
1) Flutter as a frontend
2) Python (FastAPI) as a Backend
3) Google Cloud as a hosting service

This is not meant for production use and is not optimized for cost or anything. It is meant as a quick way for e.g. students to host their own API or Flutter app for free. Be aware, that this template does not guard from billing costs, if the usage surpasses the free tier from the google cloud.

## Usage
In order to use this template, there are some small steps to make this work.

1) Add a .env (Excluded from the template for accidental push prevention)
2) Edit the `deploy.sh` file as follows:
    - Change the `PROJECT_ID` to your gcp project_id
    - Change your `IMAGE_NAME` to a meaningful name (optional)
    - Change your `REGION` to the region, where you want to deploy your container

3) Make your shell script executable by running `chmod +x deploy.sh` 

With that, you are ready to go and develop. Your python code goes into the `app.py` file and your flutter code goes into the `frontend/lib` folder.

Once you are done developing, just run `deploy.sh` to host your service on Google cloud run


