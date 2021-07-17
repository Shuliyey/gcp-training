$PROJECT_ID=$(gcloud config get-value project)
$BUCKET_NAME=$PROJECT_ID
$TOPIC_ID="my-id"
$REGION="australia-southeast1"

gsutil mb gs://$BUCKET_NAME
gcloud pubsub topics create $TOPIC_ID
gcloud scheduler jobs create pubsub publisher-job --schedule="* * * * *" --topic=$TOPIC_ID --message-body="Hello!" --region


#git clone https://github.com/GoogleCloudPlatform/java-docs-samples.git
#cd java-docs-samples/pubsub/streaming-analytics

mvn compile exec:java \
-Dexec.mainClass=com.examples.pubsub.streaming.PubSubToGcs \
-Dexec.cleanupDaemonThreads=false \
-Dexec.args=" \
    --project=$PROJECT_ID \
    --region=$REGION \
    --inputTopic=projects/$PROJECT_ID/topics/$TOPIC_ID \
    --output=gs://$BUCKET_NAME/samples/output \
    --runner=DataflowRunner \
    --windowSize=2"