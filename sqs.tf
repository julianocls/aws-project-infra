# Main SQS Queue com DLQ configurada
resource "aws_sqs_queue" "note_queue" {
  name                       = "${var.app_name}-note-queue"
  message_retention_seconds  = 345600 # 4 dias
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  fifo_queue                 = false # Fila padrão para maior taxa de performance. O controle de duplicidade deve ser feito na app.
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.note_queue_dlq.arn
    maxReceiveCount     = 5
  })
}

# Dead Letter Queue (DLQ)
resource "aws_sqs_queue" "note_queue_dlq" {
  name                      = "${var.app_name}-note_queue-dlq"
  message_retention_seconds = 1209600 # 14 dias, máximo permitido
}

# Política de acesso para a fila SQS com "restrição" por IP
resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.note_queue.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Envio de mensagens
      {
        Sid       = "AllowSendMessage"
        Effect    = "Allow"
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.note_queue.arn
        Principal = "*" # Permite todos os usuarios, mas pode ser usando para restringir um ARN
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "0.0.0.0/24" # Para restringir por origem, aqui aceita qualquer uma.
          }
        }
      },

      # Leitura de mensagens
      {
        Sid       = "AllowReceiveMessage"
        Effect    = "Allow"
        Action    = "sqs:ReceiveMessage"
        Resource  = aws_sqs_queue.note_queue.arn
        Principal = "*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "0.0.0.0/24" # Para restringir por origem, aqui aceita qualquer uma.
          }
        }
      }
    ]
  })
}