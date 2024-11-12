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


