let
  baseConfig = {
    hostname = "homeserver";
    tools = [ "git" "curl" ];
    monitoring = {
      endpoint = "/metrics";
    };
  };

  localOverrides = {
    hostname = "homeserver-prod";
    tools = [ "jq" ];
  };

  effectiveConfig = baseConfig // localOverrides;
  extraTools = [ "htop" ];
in
{
  hostname = effectiveConfig.hostname;
  tools = effectiveConfig.tools ++ extraTools;
  hasMonitoring = effectiveConfig ? monitoring;
  hasBackupTarget = effectiveConfig ? backupTarget;
  monitoringEndpoint = effectiveConfig.monitoring.endpoint or "/health";
  backupTarget = effectiveConfig.backupTarget or "/srv/backups";
}
