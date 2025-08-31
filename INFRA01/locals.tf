locals {
  formatted_user_prefix = "${lower(random_string.root_random_string.result)}"
  # formatted_user_prefix = "${lower(var.user_prefix)}"
}