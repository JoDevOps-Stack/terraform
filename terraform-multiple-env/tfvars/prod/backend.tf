bucket = "tf-remotestate-prod1"
key    = "expense-infra-prod" # you should have unique keys with in the bucket, same key should not be used in
    #  other repos or tf projects
region = "us-east-1"
dynamodb_table = "tf-remotestate-prod"