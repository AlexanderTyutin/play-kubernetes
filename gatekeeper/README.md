# Fast check commands

Apply allowed exclusions:

```
for manifest in $(find . -name '*-allowed.yaml'); do kubectl apply -f $manifest --dry-run=server; done
```

Apply denied:

```
for  manifest in $(find . -name '*-denied.yaml'); do kubectl apply -f $manifest --dry-run=server; done
```

Apply allowed:

```
for manifest in $(find . -name 'non-*.yaml'); do kubectl apply -f $manifest --dry-run=server; done
```
