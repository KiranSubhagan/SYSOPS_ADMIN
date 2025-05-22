resource "aws_s3_bucket" "static_site" {
bucket = var.bucket_name
 website {
    index_document = "index.html"
    error_document = "error.html"
  }
}



######################################################
resource aws_s3_bucket_policy "allow_public_read"{
policy = jsonencode({
Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.static_site.arn}/*"
    }]
  })
}

############################################################

resource aws_s3_object "index" {
bucket = aws_s3_bucket.static_site.id
key = "index.html"
source = "IAM/IAM_Project/Files/index.html"
acl = "public-read"
content-type = "text/html"
}




