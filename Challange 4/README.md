# Kubernetes Challenge 4: Highly Available Redis Cluster 🚀

## Overview

This guide details the process for deploying a highly available Redis cluster on a Kubernetes cluster. It includes setting up Kubernetes resources such as ConfigMap, Service, StatefulSet, PersistentVolume, and PersistentVolumeClaim, as well as initializing the Redis cluster.

## 🎯 Challenge Instructions

You are tasked with setting up a highly available Redis cluster using Kubernetes. Your task involves setting up the required Kubernetes resources, including ConfigMap, Service, StatefulSet, PersistentVolume, and PersistentVolumeClaim. Additionally, you need to initialize the Redis cluster. Here’s a detailed breakdown of what needs to be done:

1. **ConfigMap Setup:**
   - **Name:** `redis-cluster-configmap`
   - **Purpose:** This ConfigMap holds the Redis configuration data. Inspect and verify the configuration settings.

2. **Service Configuration:**
   - **Name:** `redis-cluster-service`
   - **Ports:**
     - **Client:** Port `6379`, TargetPort `6379`
     - **Gossip:** Port `16379`, TargetPort `16379`
   - **Purpose:** This service exposes the Redis cluster to other services and clients. Ensure it routes traffic correctly.

3. **StatefulSet Deployment:**
   - **Name:** `redis-cluster`
   - **Replicas:** `6`
   - **Image:** `redis:5.0.1-alpine`
   - **Label:** `app: redis-cluster`
   - **Container Name:** `redis`
   - **Command:** `["/conf/update-node.sh", "redis-server", "/conf/redis.conf"]`
   - **Ports:**
     - **Client:** `6379`
     - **Gossip:** `16379`
   - **Volume Mounts:**
     - **Conf:** MountPath `/conf`
     - **Data:** MountPath `/data`
   - **Volumes:**
     - **Conf:** Use ConfigMap `redis-cluster-configmap`, DefaultMode `0755`
   - **VolumeClaimTemplates:**
     - **Name:** `data`
     - **AccessModes:** `ReadWriteOnce`
     - **Storage Request:** `1Gi`
   - **Purpose:** Deploy the Redis instances with persistent storage and appropriate configurations.

4. **PersistentVolume Configuration:**
   - **Names:** `redis01`, `redis02`, `redis03`, `redis04`, `redis05`, `redis06`
   - **Access Modes:** `ReadWriteOnce`
   - **Size:** `1Gi`
   - **HostPaths:**
     - `/redis01`, `/redis02`, `/redis03`, `/redis04`, `/redis05`, `/redis06`
   - **Purpose:** Provide persistent storage for Redis data. Ensure these paths exist on your worker nodes.

5. **Redis Cluster Initialization:**
   - **Command:**

     ```bash
     kubectl exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}')
     ```

   - **Purpose:** Initialize the Redis cluster with the specified replicas. Ensure that all Redis nodes are correctly connected and form a cluster.

## 🛠️ Prerequisites

- **Kubernetes Cluster:** Ensure you have access to a running Kubernetes cluster.
- **`kubectl`**: The command-line tool should be installed and configured.

---

## 🧑‍💻 Setup Instructions

### 1. ConfigMap Setup

Create a file named `redis-cluster-configmap.yaml` with the Redis configuration.

<details>
<summary>File Path</summary>

- [redis-cluster-configmap.yaml](https://github.com/your-repo/redis-cluster-configmap.yaml)

</details>

Apply the ConfigMap definition:

<details>
<summary>Command</summary>

```bash
kubectl apply -f redis-cluster-configmap.yaml
```

</details>

### 2. Service Configuration

Create a file named `redis-cluster-service.yaml` with the service definition.

<details>
<summary>File Path</summary>

- [redis-cluster-service.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%204/redis-cluster-service.yaml)

</details>

Apply the Service definition:

<details>
<summary>Command</summary>

```bash
kubectl apply -f redis-cluster-service.yaml
```

</details>

### 3. StatefulSet Deployment

Create a file named `redis-cluster-statefulset.yaml` with the StatefulSet definition.

<details>
<summary>File Path</summary>

- [redis-cluster-statefulset.yaml](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%204/redis-cluster-statefulset.yaml)

</details>

Apply the StatefulSet definition:

<details>
<summary>Command</summary>

```bash
kubectl apply -f redis-cluster-statefulset.yaml
```

</details>

### 4. PersistentVolume Configuration

Create PersistentVolumes using the `generate-pv.sh` script.

<details>
<summary>File Path</summary>

- [generate-pv.sh](https://github.com/prudvikeshav/Kubernetes-Challenges/blob/work/Challange%204/generate-pv.sh)

</details>

Run the script to create PersistentVolumes:

<details>
<summary>Command</summary>

```bash
chmod +x generate-pv.sh
./generate-pv.sh
```

</details>

### 5. Redis Cluster Initialization

Initialize the Redis cluster with the provided command:

<details>
<summary>Command</summary>

```bash
kubectl exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}')
```

</details>

### 6. Verify the Deployment

Check the status of the Redis pods and services to ensure they are running correctly:

<details>
<summary>Commands</summary>

```bash
kubectl get pods
kubectl get services
```

</details>

### 7. Verify Redis Cluster Initialization

Confirm that the Redis cluster is properly initialized:

<details>
<summary>Command</summary>

```bash
kubectl exec -it redis-cluster-0 -- redis-cli cluster info
```

</details>

## 📦 Deliverables

1. **Kubernetes Configuration Files:** Ensure the StatefulSet, Service, and PersistentVolume YAML files are correctly implemented.
2. **PersistentVolume Script:** `generate-pv.sh` for creating PersistentVolumes.
3. **Verification:** Confirm that all pods are running and the Redis cluster is properly initialized.

## 📜 License

This project is licensed under the [MIT License](LICENSE). See the [LICENSE](LICENSE) file for details.

## 📞 Contact

For questions or issues, please open an issue on the repository or contact [Your Name] at [Your Email Address].

Good luck with your Redis cluster deployment! 🚀

