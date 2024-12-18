resource "aws_s3_bucket" "aws-project_terraform_bucket" {
  bucket = "terraform-bucket-jcls"

  tags = {
    Name = "My bucket"
  }
}

# Bloqueio de acesso público ao bucket
resource "aws_s3_bucket_public_access_block" "aws-project_s3_access_block" {
  bucket = aws_s3_bucket.aws-project_terraform_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Configuração de ciclo de vida do bucket
resource "aws_s3_bucket_lifecycle_configuration" "aws-project_s3_lifecycle" {
  bucket = aws_s3_bucket.aws-project_terraform_bucket.id

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
