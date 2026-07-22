let
  server = {
    hostname = "homeserver";
    role = "lab";
    tools = [ "curl" "git" "jq" ];
  };
in
{
  message = "${server.hostname} es un servidor de tipo ${server.role}";
  inherit (server) tools;
}
