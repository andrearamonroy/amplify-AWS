# amplify AWS

This apps implements Amplify-iOS AWS services to create a to-do list. 
It uses DataStore to persist data locally which users can access when they're offline, and enables cloud syncing with the Amplify API.

The "Todo" model is a graphql schema. Amplify DataStore will use this model to persist data to the local device. 
To connect to AWS and make data available in the cloud, I generated an IAM user, initalized the Amplify backend, and pushed the backend to the cloud.
Then, I enabled cloud syncing and added a subscription to the app to receive any update to the "Todo" Model.
It also enables you to query and create mutations. 
