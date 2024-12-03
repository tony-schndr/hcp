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


