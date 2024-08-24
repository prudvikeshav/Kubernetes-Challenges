### Problem Statement

#### Overview

Our 2-node Kubernetes cluster is experiencing issues that are preventing the deployment of a new image gallery service. The tasks are to troubleshoot and fix the cluster issues, then deploy the necessary Kubernetes resources to bring the image gallery service online.

#### Objectives

1. **Cluster Health Check and Repair**:
   - Investigate and resolve issues affecting the Kubernetes cluster.
   - Ensure that the `kube-apiserver` is running and healthy.
   - Confirm that node01 is ready and capable of scheduling pods.

2. **Service and Pod Deployment**:
   - Deploy a new service and pod according to the architecture diagram provided.
   - Ensure the proper configuration and functionality of PersistentVolume and PersistentVolumeClaim.

3. **Persistent Storage Configuration**:
   - Create and configure PersistentVolume and PersistentVolumeClaim for the file server.
   - Ensure that the PersistentVolume uses hostPath `/web` and that the storage request is `1Gi`.

4. **File Synchronization**:
   - Copy all images from the directory `/media` on the control plane node to the `/web` directory on node01.

#### Specific Tasks

1. **Fix Cluster Issues**:
   - **kube-apiserver**: Verify that the `kube-apiserver` is running and address any issues if it's not healthy.
   - **Node Readiness**: Ensure that node01 is in a ready state and capable of scheduling pods.

2. **Create and Configure Kubernetes Resources**:
   - **Service**:
     - Name: `gop-fs-service`
     - Port: `8080`
     - TargetPort: `8080`
   - **Pod**:
     - Name: `gop-file-server`
     - Image: `kodekloud/fileserver`
     - Mount Path: `/web`
     - VolumeMount Name: `data-store`
   - **PersistentVolumeClaim**:
     - Name: `data-pvc`
     - AccessModes: `ReadWriteMany`
     - Storage Request: `1Gi`
   - **PersistentVolume**:
     - Name: `data-pv`
     - AccessModes: `ReadWriteMany`
     - HostPath: `/web`
     - Storage: `1Gi`

3. **Data Synchronization**:
   - Copy all images from `/media` on the control plane node to `/web` on node01.

4. **Verification**:
   - Confirm that all deployments are correctly applied and the `gop-file-server` pod is running with the expected configuration.

#### Kubernetes Configuration Details

- **kubeconfig**: `/root/.kube/config`
- **User**: `kubernetes-admin`
- **Cluster Server Port**: `6443`
- **CoreDNS Deployment Image**: `registry.k8s.io/coredns/coredns:v1.8.6`

Ensure that all components are correctly set up and functioning to unlock the Image Gallery.
