$PROJECT_ID=$(gcloud config get-value project)
$BUCKET_NAME=$PROJECT_ID
$TOPIC_ID="my-id"
$REGION="australia-southeast1"

gcloud scheduler jobs delete pubsub publisher-job
gcloud pubsub topics delete $TOPIC_ID
#gcloud dataflow jobs cancel $JOB_ID