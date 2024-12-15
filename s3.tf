resource "aws_s3_bucket" "terraform-bucket-jcls" {
  bucket = "terraform-bucket-jcls"

  tags = {
    Name = "My bucket"
  }
}

# Bloqueio de acesso público ao bucket
resource "aws_s3_bucket_public_access_block" "terraform-bucket-jcls-access-block" {
  bucket = aws_s3_bucket.terraform-bucket-jcls.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Configuração de ciclo de vida do bucket
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
