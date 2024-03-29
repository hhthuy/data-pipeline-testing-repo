#Creating the S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "thuy-s3bucket-aws" #bucket name automatically created on aws
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

#Configuring BOC to access control and permissions to the bucket
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#Setting Access Control List (ACL)  for the bucket to "private", restricting access to only the owner.
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

