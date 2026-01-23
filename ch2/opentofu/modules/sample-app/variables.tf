# If not defaulted, a variable can be set at runtime e.g.check e.g.
#
# tofu apply -var name=some-name
#
# or through a local environment variable
#
# export TF_VAR_name=some-name

variable "name" {
  description = "name of the app"
  type = string
  default = "sample_app_tofu"
}
