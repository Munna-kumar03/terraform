variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
#  default     = terraform-s3-bucket-for-user
}

variable "folder_name" {
  description = "The folder name in the S3 bucket"
  type        = string
#  default     = path/to/folder
}

variable "user_name" {
  description = "The name of the IAM user"
  type        = string
 # default     = user-name
}

variable "user_arn" {
  description = "The ARN of the IAM user"
  type        = string
}
