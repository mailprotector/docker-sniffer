# sniffer
Docker build of sniffer (aka snf-server) spam filtering engine.

It should be noted that snf-server will ONLY ever listen for xci on localhost, and can not be configured to do otherwise.

## Configured paths
```
Log Path: /var/log/snf-server/
Rulebase Path: /usr/share/snf-server/
Workspace Path: /usr/share/snf-server/
RuleFilePath: /usr/share/snf-server/<license>.snf
```

## Environment Variables
`LICENSE`: sniffer vendor-provided license code for rulebase sync
`AUTH`: sniffer vendor-provided auth token for rulebast sync