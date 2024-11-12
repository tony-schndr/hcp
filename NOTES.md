# Notes

## Node pool creation

## Node pool mgmt cluster resource

Nodepool object created my manifest works component ?
Nodepool object lives in ocm-<cluster-name>-<hcp-id> namespace
contains statuses that assist in debug
for example:
```
$ kubectl get nodepool -n ocm-aro-hcp-dev-2espb9a22t95s10l2t0qepra8ok2406t  
NAME                        CLUSTER        DESIRED NODES   CURRENT NODES   AUTOSCALING   AUTOREPAIR   VERSION   UPDATINGVERSION   UPDATINGCONFIG   MESSAGE
tschneid-hcp-dev-nodepool   tschneid-hcp   2               2               False         False        4.17.0    False             False
```


## admin kubeconfig

Admin kubeconfig exists as a secret in the ocm-<cluster-name>-<hcp-id> namespace
```
$ kubectl get secrets -n ocm-aro-hcp-dev-2espb9a22t95s10l2t0qepra8ok2406t 
NAME                             TYPE     DATA   AGE
tschneid-hcp-admin-kubeconfig    Opaque   1      19h
tschneid-hcp-cloud-credentials   Opaque   4      19h
tschneid-hcp-pull                Opaque   1      19h
```
Grab the secret base64 and decode it to use it.


## Templatize

# 1. we need to provide a {{ config.<whatever> }} schema that templatize can take as input, which would contain things like the regional short name
# 2. Red Hat needs to use that for generated bits
3. templatize needs to allow --stamp flag as input for {{ ctx.stamp }}
4. Red Hat needs to use that for svc and mgmt clusters
5. no more functions
6. need to determine minimal schema for configuring ServiceModel.json and RolloutSpec.json
7. Red Hat needs to use the source-of-truth file for ServiceModel.json to actually run the correct make commands with the right mapping of .bicep to .bicepparam and in the right resourceGroup
