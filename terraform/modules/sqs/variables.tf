variable "name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "max_receive_count" {
  description = "Number of times a message can be received before moving to the DLQ"
  type        = number
  default     = 3
}

variable "visibility_timeout_seconds" {
  description = "How long a received message remains invisible"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags applied to the queues"
  type        = map(string)
  default     = {}
}