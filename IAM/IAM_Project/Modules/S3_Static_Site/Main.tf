resource "aws_s3_bucket" "static_site" {
bucket = var.bucket_name
 website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
###################################################

resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "null_resource" "wait_30_seconds" {
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [aws_s3_bucket_public_access_block.static_site]
}



######################################################
resource "aws_s3_bucket_policy" "allow_public_read" {
depends_on = [null_resource.wait_30_seconds]
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      },
      {
        Sid       = "AllowTerraform"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::941377118076:user/Github-Terraform-user"
        }
        Action   = "s3:*"
        Resource = [
          "${aws_s3_bucket.static_site.arn}/*",
          "${aws_s3_bucket.static_site.arn}"
        ]
      }
    ]
  })
}

############################################################

resource aws_s3_object "index" {
bucket = aws_s3_bucket.static_site.id
key = "index.html"
source = "./Files/index.html"

content_type = "text/html"
}




