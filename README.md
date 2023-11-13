# docker-sniffer
Docker build of sniffer (aka snf-server) spam filtering engine.

It should be noted that snf-server will ONLY ever listen for xci on localhost, and can not be configured to do otherwise.

## Run
```
docker build --platform linux/amd64 -t sniffer:latest .
docker run --platform linux/amd64 -e LICENSE=<license_key> -e AUTH=<license_auth> sniffer:latest
```

## Configured paths
| Name         | Path                                |
| ------------ | ----------------------------------- |
| Log          | /var/log/snf-server/                |
| Rulebase     | /usr/share/snf-server/              |
| Workspace    | /usr/share/snf-server/              |
| RuleFilePath | /usr/share/snf-server/<license>.snf |

## Environment Variables
| Name    | Description                                            |
| ------- | ------------------------------------------------------ |
| LICENSE | sniffer vendor-provided license code for rulebase sync |
| AUTH    | sniffer vendor-provided auth token for rulebase sync   |
