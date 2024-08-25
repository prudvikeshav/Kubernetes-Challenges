# Kubernetes Challenge 3: Voting Portal Deployment on Kubernetes 🚀

## Overview

This guide provides a comprehensive walkthrough for deploying a Voting Portal application on a Kubernetes cluster. The deployment involves creating the necessary Kubernetes resources such as Services and Deployments for multiple components: the voting application, Redis, PostgreSQL, a worker for background tasks, and a results display application.

## 🎯 Challenge Objectives

You are tasked with deploying a Voting Portal using Kubernetes. Your deployment includes:

1. **Create a Namespace**: Isolate resources by creating a namespace named `vote`.

2. **Service and Deployment Configuration**:
   - **Vote Service and Deployment**:
     - **Service Name:** `vote-service`
     - **Port:** `5000`
     - **TargetPort:** `80`
     - **NodePort:** `31000`
     - **Deployment Name:** `vote-deployment`
     - **Image:** `kodekloud/examplevotingapp_vote:before`
   - **Redis Service and Deployment**:
     - **Service Name:** `redis`
     - **Port:** `6379`
     - **TargetPort:** `6379`
     - **Type:** `ClusterIP`
     - **Deployment Name:** `redis-deployment`
     - **Image:** `redis:alpine`
     - **Volume Type:** `EmptyDir`
     - **Volume Name:** `redis-data`
     - **Mount Path:** `/data`
   - **Worker Deployment**:
     - **Deployment Name:** `worker`
     - **Image:** `kodekloud/examplevotingapp_worker`
   - **Database Service and Deployment**:
     - **Service Name:** `db`
     - **Port:** `5432`
     - **TargetPort:** `5432`
     - **Type:** `ClusterIP`
     - **Deployment Name:** `db-deployment`
     - **Image:** `postgres:9.4`
     - **Environment Variable:** `POSTGRES_HOST_AUTH_METHOD=trust`
     - **Volume Type:** `EmptyDir`
     - **Volume Name:** `db-data`
     - **Mount Path:** `/var/lib/postgresql/data`
   - **Result Service and Deployment**:
     - **Service Name:** `result-service`
     - **Port:** `5001`
     - **TargetPort:** `80`
     - **NodePort:** `31001`
     - **Deployment Name:** `result-deployment`
     - **Image:** `kodekloud/examplevotingapp_result:before`

## 🛠️ Prerequisites

- **Kubernetes Cluster**: Ensure you have access to a running Kubernetes cluster.
- **`kubectl`**: The command-line tool should be installed and configured.

---

## 🧩 Namespace Creation

### 1. Create Namespace

Create a namespace named `vote`:

<details>
<summary>Command</summary>

```sh
kubectl create namespace vote
```

</details>

---

## 📦 Service and Deployment Setup

### 1. Vote Service and Deployment

#### Vote Service

<details>
<summary>File Path</summary>

- [vote-service.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/vote-service.yaml)

</details>

Apply the service definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f vote-service.yaml
```

</details>

#### Vote Deployment

<details>
<summary>File Path</summary>

- [vote-deployment.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/vote-deployment.yaml)

</details>

Apply the deployment definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f vote-deployment.yaml
```

</details>

### 2. Redis Service and Deployment

#### Redis Service

<details>
<summary>File Path</summary>

- [redis-service.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/redis-service.yaml)

</details>

Apply the service definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f redis-service.yaml
```

</details>

#### Redis Deployment

<details>
<summary>File Path</summary>

- [redis-deployment.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/redis-deployment.yaml)

</details>

Apply the deployment definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f redis-deployment.yaml
```

</details>

### 3. Worker Deployment

<details>
<summary>File Path</summary>

- [worker-deployment.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/worker-deployment.yaml)

</details>

Apply the deployment definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f worker-deployment.yaml
```

</details>

### 4. Database Service and Deployment

#### Database Service

<details>
<summary>File Path</summary>

- [db-service.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/db-service.yaml)

</details>

Apply the service definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f db-service.yaml
```

</details>

#### Database Deployment

<details>
<summary>File Path</summary>

- [db-deployment.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/db-deployment.yaml)

</details>

Apply the deployment definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f db-deployment.yaml
```

</details>

### 5. Result Service and Deployment

#### Result Service

<details>
<summary>File Path</summary>

- [result-service.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/result-service.yaml)

</details>

Apply the service definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f result-service.yaml
```

</details>

#### Result Deployment

<details>
<summary>File Path</summary>

- [result-deployment.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/main/Challange%203/result-deployment.yaml)

</details>

Apply the deployment definition:

<details>
<summary>Command</summary>

```sh
kubectl apply -f result-deployment.yaml
```

</details>

---

## ✅ Verification

1. **Verify Services:**

   <details>
   <summary>Command</summary>

   ```sh
   kubectl get services -n vote
   ```

   </details>

2. **Check Pods Status:**

   <details>
   <summary>Command</summary>

   ```sh
   kubectl get pods -n vote
   ```

   Ensure all pods are running with the appropriate labels.
   </details>

3. **Check Logs:**

   Verify that each component is functioning correctly:

   <details>
   <summary>Command</summary>

   ```sh
   kubectl logs -n vote <pod-name>
   ```

   Replace `<pod-name>` with the actual pod names for each deployment.
   </details>

---

## 📋 Summary

You have successfully deployed a Voting Portal on Kubernetes. The deployment includes:

- **Namespace**: `vote`
- **Services**: `vote-service`, `redis`, `db`, `result-service`
- **Deployments**: `vote-deployment`, `redis-deployment`, `worker`, `db-deployment`, `result-deployment`

Each component is configured with its appropriate settings and exposed via the designated ports.

