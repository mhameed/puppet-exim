# == Define: exim::authenticator
#
# This module configures a single authenticator in exims configuration
#
# === Parameters
#
# [*driver*]
#  driver to use for the authenticator
#
# [*public_name*]
#  How to anounce the authenticator to the outside (PLAIN/LOGIN)
#
# [*server_condition*]
#  The authentication check
#
# [*server_set_id*]
#  Set the $authenticated_id variable for later use
#
# [*server_prompts*]
#  Promt used in the smtp session to ask for data  (User: Password:)
#
# [*client_ignore_invalid_base64*]
#  If the client receives a server prompt that is not a valid base64 string, authentication is abandoned by 
#  default. However, if this option is set true, the error in the challenge is ignored and the client 
#  sends the response as usual. 
#
# [*client_send*]
#  Set the string to be sent when acting as a client, i.e. smarthost.
#

define exim::authenticator (
  $driver,
  $public_name,
  $server_condition = undef,
  $server_set_id = undef,
  $server_prompts = undef,
  $client_ignore_invalid_base64 = false,
  $client_send    = undef,
  ){

  if ($client_ignore_invalid_base64 ) { validate_bool($client_ignore_invalid_base64 ) }
  if ($client_send) { validate_array($client_send) }
  concat::fragment { "authenticator-${title}":
    target  => $::exim::config_path,
    content => template("${module_name}/authenticator/authenticator.erb"),
    order   => 5001,
  }
}
