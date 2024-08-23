
# Jekyll Static Site Generator Deployment on Kubernetes

## Overview

This guide describes how to deploy a Jekyll Static Site Generator (SSG) on a Kubernetes cluster. The deployment includes setting up Kubernetes resources such as PersistentVolume (PV), PersistentVolumeClaim (PVC), Pod, and Service, and configuring user permissions and contexts in the kubeconfig file.

## Prerequisites

- Kubernetes cluster access
- `kubectl` command-line tool installed and configured
- Access to a kubeconfig file

---

## User and Context Configuration

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

## PersistentVolumeClaim (PVC) Setup

### 1. Define PersistentVolumeClaim

Create a file named `jekyll-pvc.yaml` with the following content:

<details>
<summary>File Content</summary>

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jekyll-site
  namespace: development
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

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

## Pod Configuration

### 1. Define Pod

Create a file named `jekyll-pod.yaml` with the following content:

<details>
<summary>File Content</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: jekyll
  namespace: development
  labels:
    run: jekyll
spec:
  volumes:
    - name: site
      persistentVolumeClaim:
        claimName: jekyll-site
  initContainers:
    - name: copy-jekyll-site
      image: gcr.io/kodekloud/customimage/jekyll
      command: ["jekyll", "new", "/site"]
      volumeMounts:
        - name: site
          mountPath: /site
  containers:
    - name: jekyll
      image: gcr.io/kodekloud/customimage/jekyll-serve
      volumeMounts:
        - name: site
          mountPath: /site
```

</details>

Apply the Pod definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f jekyll-pod.yaml
```

</details>

---

## Service Configuration

### 1. Define Service

Create a file named `jekyll-service.yaml` with the following content:

<details>
<summary>File Content</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: jekyll
  namespace: development
spec:
  ports:
    - port: 8080
      targetPort: 4000
      nodePort: 30097
  selector:
    run: jekyll
  type: NodePort
```

</details>

Apply the Service definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f jekyll-service.yaml
```

</details>

---

## Role and RoleBinding Configuration

### 1. Define Role

Create a file named `developer-role.yaml` with the following content:

<details>
<summary>File Content</summary>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-role
  namespace: development
rules:
  - apiGroups: [""]
    resources: ["services", "persistentvolumeclaims", "pods"]
    verbs: ["*"]
```

</details>

### 2. Define RoleBinding

Create a file named `developer-rolebinding.yaml` with the following content:

<details>
<summary>File Content</summary>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-rolebinding
  namespace: development
subjects:
  - kind: User
    name: martin
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer-role
  apiGroup: rbac.authorization.k8s.io
```

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

## Verification

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

## Summary

You have successfully deployed a Jekyll Static Site Generator on Kubernetes. The deployment includes a PersistentVolumeClaim, Pod, and Service, with proper user permissions and role bindings configured.
