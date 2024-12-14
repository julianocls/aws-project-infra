resource "aws_s3_bucket" "terraform-bucket-jcls" {
  bucket = "terraform-bucket-jcls"

  tags = {
    Name = "My bucket"
  }
}

#Politica de acesso
resource "aws_s3_bucket_policy" "terraform-bucket-jcls-policy" {
  bucket = aws_s3_bucket.terraform-bucket-jcls.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyPublicRead"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.terraform-bucket-jcls.bucket}/*"
      },
      {
        Sid       = "DenyPublicWrite"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.terraform-bucket-jcls.bucket}/*"
      }
    ]
  })
}

# Configuração de bloqueio publico
resource "aws_s3_bucket_public_access_block" "terraform-bucket-jcls-access-block" {
  bucket = aws_s3_bucket.terraform-bucket-jcls.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Regras para expirar arquivos
resource "aws_s3_bucket_lifecycle_configuration" "terraform-bucket-jcls-lifecycle" {
  bucket = aws_s3_bucket.terraform-bucket-jcls.id

  rule {
    id     = "expire-objects-1-day"
    status = "Enabled"

    filter {
      prefix = "" # Aplica a regra a todos os objetos no bucket
    }

    expiration {
      days = 1 # Expira os objetos após 1 dia
    }
  }
}
