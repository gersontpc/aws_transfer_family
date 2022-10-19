variable "transfer_server_name" {
  description = "Set transfer family server name"
  type        = string
  default     = "transfer_labs"
}


variable "force_destroy" {
  description = "Forces the AWS Transfer Server to be destroyed"
  type        = bool
  default     = false
}

variable "transfer_user" {
  description = "Set list username and ssh_key"
  type = list(object({
    user_name = string
    ssh_key   = string
  }))
}

variable "security_policy_name" {
  description = "Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, and TransferSecurityPolicy-FIPS-2020-06. Default value is: TransferSecurityPolicy-2018-11."
  type        = string
  default     = "TransferSecurityPolicy-2020-06"
}

variable "identity_provider_type" {
  type        = string
  description = "The mode of authentication enabled for this service"
  default     = "SERVICE_MANAGED"
}

variable "protocols" {
  description = "Change list acceptable protocols"
  type        = list(any)
  default     = ["SFTP"]
}

variable "home_directory_type" {
  description = "The type of landing directory (folder) you mapped for your users' home directory."
  type        = string
  default     = "LOGICAL"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
