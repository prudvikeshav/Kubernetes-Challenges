# Jekyll Static Site Generator Deployment on Kubernetes 🚀

## Overview

This guide describes how to deploy a Jekyll Static Site Generator (SSG) on a Kubernetes cluster. The deployment includes setting up Kubernetes resources such as PersistentVolume (PV), PersistentVolumeClaim (PVC), Pod, and Service, as well as configuring user permissions and contexts in the kubeconfig file.

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

- `jekyll-pvc.yaml`

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

- `jekyll-pod.yaml`

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

- `jekyll-service.yaml`

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

- `developer-role.yaml`

</details>

### 2. Define RoleBinding

Create a file named `developer-rolebinding.yaml` with the following content:

<details>
<summary>File Path</summary>

- `developer-rolebinding.yaml`

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

## 📜 License

This project is licensed under the [MIT License](LICENSE). See the [LICENSE](LICENSE) file for details.

## 📞 Contact

For questions or issues, please open an issue on the repository or contact [Your Name] at [Your Email Address].

