
# Kubernetes Challenge: Image Gallery Service Deployment 🚀

## Overview

This challenge involves troubleshooting and fixing a 2-node Kubernetes cluster to deploy an image gallery service. You’ll need to address cluster issues, configure Kubernetes resources, and synchronize data to ensure the image gallery is operational.

## 🎯 Challenge Instructions

Your task is to fix the Kubernetes cluster and deploy the necessary resources to bring the image gallery service online. Here’s a detailed breakdown of what needs to be done:

1. **Cluster Health Check and Repair:**
   - Investigate and resolve issues affecting the Kubernetes cluster.
   - Ensure the `kube-apiserver` is running and healthy.
   - Confirm that node01 is ready and capable of scheduling pods.

2. **Service and Pod Deployment:**
   - Deploy a new service and pod according to the provided architecture diagram.
   - Ensure the proper configuration and functionality of PersistentVolume and PersistentVolumeClaim.

3. **Persistent Storage Configuration:**
   - Create and configure PersistentVolume and PersistentVolumeClaim for the file server.
   - Ensure that the PersistentVolume uses `hostPath /web` and the storage request is `1Gi`.

4. **File Synchronization:**
   - Copy all images from the directory `/media` on the control plane node to the `/web` directory on node01.

## 🛠️ Prerequisites

- **Kubernetes Cluster:** Ensure you have access to a running 2-node Kubernetes cluster.
- **`kubectl`**: The command-line tool should be installed and configured.

---

## 🧩 Setup Instructions

### 1. Cluster Health Check and Repair

#### Fix API Server

1. **Update `kubeconfig`:**
   - Edit the `kubeconfig` file to ensure the server port is correctly set.

   <details>
   <summary>Command</summary>

   ```bash
   vi /root/.kube/config
   ```

   - Change the server port from `6433` to `6443`.

   </details>

2. **Fix `kube-apiserver`:**
   - Edit the `kube-apiserver` manifest to correct the certificate name.

   <details>
   <summary>Command</summary>

   ```bash
   cd /etc/kubernetes/manifests
   vi kube-apiserver.yaml
   ```

   - Update the `--client-ca-file` path:
     - **Incorrect:** `--client-ca-file=/etc/kubernetes/pki/ca-authority.crt`
     - **Correct:** `--client-ca-file=/etc/kubernetes/pki/ca.crt`

   - Restart the kubelet to apply changes:

   ```bash
   systemctl restart kubelet
   ```

   </details>

3. **Verify CoreDNS Deployment:**
   - Check if CoreDNS is running and update the image if necessary.

   <details>
   <summary>Command</summary>

   ```bash
   kubectl get all -n kube-system
   ```

   - Update the CoreDNS image:

   ```bash
   kubectl set image deployment/coredns -n kube-system coredns=registry.k8s.io/coredns/coredns:v1.8.6
   ```

   </details>

4. **Ensure Node Readiness:**
   - Verify the status of nodes and uncordon node01 if necessary.

   <details>
   <summary>Command</summary>

   ```bash
   kubectl get nodes
   kubectl uncordon node01
   ```

   </details>

### 2. Persistent Storage Configuration

1. **Copy Images to node01:**
   - Transfer images from `/media` on the control plane node to `/web` on node01.

   <details>
   <summary>Command</summary>

   ```bash
   scp /media/* node01:/web
   ```

   </details>

2. **Create PersistentVolume and PersistentVolumeClaim:**
   - Apply configurations for PersistentVolume and PersistentVolumeClaim.

   - **PersistentVolume [data-pv.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%202/data-pv.yaml)**

   - **PersistentVolumeClaim [data-pvc.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%202/data-pvc.yaml)**

   <details>
   <summary>Commands</summary>

   ```bash
   kubectl apply -f data-pv.yaml
   kubectl apply -f data-pvc.yaml
   ```

   </details>

### 3. Service and Pod Deployment

1. **Deploy the Service:**
   - Create the service definition.

   - **Service [gop-fs-service.yaml](https://github.com/your-repo/image-gallery-service/blob/main/service.yaml)**

   <details>
   <summary>Command</summary>

   ```bash
   kubectl apply -f gop-fs-service.yaml
   ```

   </details>

2. **Deploy the Pod:**
   - Create the pod definition.

   - **Pod [gop-file-server.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%202/gop-file-server.yaml)**

   <details>
   <summary>Command</summary>

   ```bash
   kubectl apply -f gop-file-server.yaml
   ```

   </details>

### 4. Verification

1. **Verify Deployment:**
   - Check that the `gop-file-server` pod and the `gop-fs-service` are running and correctly configured.

   <details>
   <summary>Commands</summary>

   ```bash
   kubectl get all
   kubectl get pv
   ```

   </details>

---

## 📦 Deliverables

1. **Kubernetes Configuration Files:**
   - PersistentVolume (`data-pv.yaml`)
   - PersistentVolumeClaim (`data-pvc.yaml`)
   - Service (`gop-fs-service.yaml`)
   - Pod (`gop-file-server.yaml`)

2. **Verification:**
   - Confirm that all pods and services are running as expected.

