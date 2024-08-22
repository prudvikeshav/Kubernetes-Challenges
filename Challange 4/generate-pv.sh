#!/bin/bash

for i in {1..6}
do
  cat <<EOF > redis0$i-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: redis0$i
spec:
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - node01
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /redis0$i
  storageClassName: slow
EOF
done
