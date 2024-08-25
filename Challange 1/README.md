# Kubernetes Challenge 1: Jekyll Static Site Generator Deployment on Kubernetes 🚀

## Overview

This guide describes how to deploy a Jekyll Static Site Generator (SSG) on a Kubernetes cluster. The deployment includes setting up Kubernetes resources such as PersistentVolume (PV), PersistentVolumeClaim (PVC), Pod, and Service, as well as configuring user permissions and contexts in the kubeconfig file.

## 🎯 Challenge Question

You are tasked with deploying a Jekyll Static Site Generator (SSG) using Kubernetes. Your task involves setting up the required Kubernetes resources, including PersistentVolume (PV), PersistentVolumeClaim (PVC), Pod, and Service. Additionally, you need to configure user permissions and contexts in the kubeconfig file. Here’s a detailed breakdown of what needs to be done:

1. **User Configuration:**
   - **User Information:** Create a new user named `martin` in the default kubeconfig file with the following details:
     - `client-key`: `/root/martin.key`
     - `client-certificate`: `/root/martin.crt`
   - Ensure that the credentials are not embedded directly within the kubeconfig file.

2. **Context Configuration:**
   - **Create Context:** Set up a new context called `developer` in the default kubeconfig file. This context should use:
     - `user`: `martin`
     - `cluster`: `kubernetes`
   - Set this new context as the current context.

3. **PersistentVolumeClaim (PVC) Setup:**
   - Inspect the existing PersistentVolume (PV) called `jekyll-site` and ensure it is suitable for your needs.
   - **Create a PVC:** Define a PersistentVolumeClaim with the following properties:
     - **Name:** `jekyll-site`
     - **Namespace:** `development`
     - **Storage Request:** `1Gi`
     - **Access Modes:** `ReadWriteMany`
   - Ensure that this PVC is bound to the existing PV named `jekyll-site`.

4. **Pod Configuration:**
   - **Pod Name:** `jekyll`
   - **Init Container:**
     - **Name:** `copy-jekyll-site`
     - **Image:** `gcr.io/kodekloud/customimage/jekyll`
     - **Command:** `["jekyll", "new", "/site"]` (This command initializes a new Jekyll site at `/site`)
     - **Mount Path:** `/site`
   - **Container:**
     - **Name:** `jekyll`
     - **Image:** `gcr.io/kodekloud/customimage/jekyll-serve`
     - **Mount Path:** `/site`
   - **Volume:** Use a volume named `site` that is bound to the `jekyll-site` PVC.
   - **Labels:** Ensure the pod has a label `run=jekyll`.

5. **Service Configuration:**
   - **Service Name:** `jekyll`
   - **Port:** `8080`
   - **Target Port:** `4000`
   - **NodePort:** `30097`
   - **Namespace:** `development`

6. **Role and RoleBinding Configuration:**
   - **Create Role:** Define a `developer-role` with the following permissions:
     - All permissions for `services` in the `development` namespace
     - All permissions for `persistentvolumeclaims` in the `development` namespace
     - All permissions for `pods` in the `development` namespace
   - **Create RoleBinding:** Create a rolebinding named `developer-rolebinding` that:
     - Binds the `developer-role` to the user `martin`
     - Is associated with the `development` namespace

## 🛠️ Prerequisites

- **Kubernetes Cluster**: Ensure you have access to a running Kubernetes cluster.
- **`kubectl`**: The command-line tool should be installed and configured.
- **Kubeconfig File**: Access to a kubeconfig file is required.

---

## 🧑‍💻 User and Context Configuration

### 1. User Configuration

Create a new user named `martin` in your kubeconfig file with the provided credentials.

<details>
<summary>Command</summary>

```sh
kubectl config set-credentials martin --client-key=/root/martin.key --client-certificate=/root/martin.crt
```

</details>

### 2. Context Configuration

Set up a new context called `developer` using the `martin` user and the `kubernetes` cluster. Then, set this context as the current context.

<details>
<summary>Commands</summary>

```sh
kubectl config set-context developer --user=martin --cluster=kubernetes
kubectl config use-context developer
```

</details>

---

## 📦 PersistentVolumeClaim (PVC) Setup

### 1. Define PersistentVolumeClaim

Create a file named `jekyll-pvc.yaml` with the following content:

<details>
<summary>File Path</summary>

- [jekyll-pvc.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%201/jekyll-pvc.yaml)

</details>

Apply the PVC definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f jekyll-pvc.yaml
```

</details>

Ensure that the PVC is bound to the existing PersistentVolume named `jekyll-site`:

<details>
<summary>Command</summary>

```sh
kubectl get pvc -n development
```

</details>

---

## 🛠️ Pod Configuration

### 1. Define Pod

Create a file named `jekyll-pod.yaml` with the following content:

<details>
<summary>File Path</summary>

- [jekyll-pod.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%201/jekyll-pod.yaml)

</details>

Apply the Pod definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f jekyll-pod.yaml
```

</details>

---

## 🌐 Service Configuration

### 1. Define Service

Create a file named `jekyll-service.yaml` with the following content:

<details>
<summary>File Path</summary>

- [jekyll-service.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%201/jekyll-service.yaml)

</details>

Apply the Service definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f jekyll-service.yaml
```

</details>

---

## 🔐 Role and RoleBinding Configuration

### 1. Define Role

Create a file named `developer-role.yaml` with the following content:

<details>
<summary>File Path</summary>

- [developer-role.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%201/developer-role.yaml)

</details>

### 2. Define RoleBinding

Create a file named `developer-rolebinding.yaml` with the following content:

<details>
<summary>File Path</summary>

- [developer-rolebinding.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%201/developer-rolebinding.yaml)

</details>

Apply the Role and RoleBinding definitions:

<details>
<summary>Commands</summary>

```sh
kubectl apply -f developer-role.yaml
kubectl apply -f developer-rolebinding.yaml
```

</details>

---

## ✅ Verification

1. **Verify PVC Binding:**

   <details>
   <summary>Command</summary>

   ```sh
   kubectl get pvc -n development
   ```

   </details>

2. **Check Pod Status:**

   <details>
   <summary>Command</summary>

   ```sh
   kubectl get pods -n development
   ```

   Ensure the pod is running and has the `run=jekyll` label.
   </details>

3. **Check Service:**

   <details>
   <summary>Command</summary>

   ```sh
   kubectl get services -n development
   ```

   Ensure the service is exposed on NodePort `30097`.
   </details>

4. **Check Logs:**

   Verify that the Jekyll site is being served correctly:

   <details>
   <summary>Command</summary>

   ```sh
   kubectl logs -n development jekyll
   ```

   </details>

---

## 📋 Summary

You have successfully deployed a Jekyll Static Site Generator on Kubernetes. The deployment includes:

- **PersistentVolumeClaim**: `jekyll-site`
- **Pod**: Configured with Jekyll image and service
- **Service**: Exposed on NodePort `30097`
- **Role and RoleBinding**: For user permissions and access control


