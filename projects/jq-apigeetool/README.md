Apigeetool and JQ
---

[Apigeetool](https://www.npmjs.com/package/apigeetool) acts as a wrapper around the [Management](https://apidocs.apigee.com/management/apis) API. There are Maven plugins such as the [Apigee Config Maven Plugin](https://github.com/apigee/apigee-config-maven-plugin) that allow environment configuration to be stored in files and deployed.

The same can be achieved with [Apigeetool](https://www.npmjs.com/package/apigeetool) and [JQ](https://stedolan.github.io/jq/).

For example, for `kvms.json` we can use the following script:

```shell
MAP=$(jq -r '.[0].name' kvms.json)
echo "Preparing to update kvm:" $MAP

for k in $(jq '.[0].entry | keys | .[]' kvms.json); do
    NAME=$(jq -r ".[0].entry[$k].name" kvms.json);
    VALUE=$(jq -r ".[0].entry[$k].value" kvms.json);
    echo "Updating key:" $NAME " value:" $VALUE
    apigeetool addEntryToKVM -o $ORG -e test --mapName $MAP --entryName $NAME --entryValue $VALUE
done
```

This uses JQ to iterate the config JSON and make multiple calls.

There isn't currently a tool that does this using `apigeetool`, so similar scripts would need to be written for Caches, Extensions, TargetServers, VHosts, KeyStores etc. This should be considered when deciding whether to use Maven, apigeetool or a different deployment tool.

In addition, at the time of writing `apigeetool` only supports insert and delete on KVM entries, not upsert. This is supported within Maven.
