#create S3 bucket
resource "aws_s3_bucket" "create_bucket" {
  bucket = "pkmyweb1234567"
}

#upload index.html file in bucket by object
resource "aws_s3_object" "upload-index" {
  bucket = aws_s3_bucket.create_bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}
#upload style.css file in bucket by object
resource "aws_s3_object" "upload-style"{
    bucket = aws_s3_bucket.create_bucket.bucket
    source = "./style.css"
    key = "style.css"
    content_type = "text/css"
}
#disable block in s3 bucket
resource "aws_s3_bucket_public_access_block" "blocks3" {
  bucket = aws_s3_bucket.create_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
#configure website 
resource "aws_s3_bucket_website_configuration" "website-host" {
  bucket = aws_s3_bucket.create_bucket.id

  index_document {
    suffix = "index.html"
  }
}
#create policy for host website
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.create_bucket.id
  policy = jsonencode(
    {
    Version: "2012-10-17",
    Statement: [
        {
            Sid       = "PublicReadGetObject",
            Effect    = "Allow",
            Principal = "*",
            Action    = "s3:GetObject",
            Resource  = "arn:aws:s3:::${aws_s3_bucket.create_bucket.id}/*"
        }
    ]
}
  )
}

#get website url after apply
output "wesite-url-name" {
  value = aws_s3_bucket_website_configuration.website-host.website_endpoint
}