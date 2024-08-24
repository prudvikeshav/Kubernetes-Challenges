

# Kubernetes Challenge 4: Highly Available Redis Cluster 🚀

Welcome to the Kubernetes Challenge 4 repository! In this challenge, you'll build a highly available Redis cluster using Kubernetes. Follow the instructions below to set up and verify your Redis cluster.

## 🎯 Objective

Build a highly available Redis cluster based on the provided specifications.

## 📋 Specifications

### ConfigMap

- **Name**: `redis-cluster-configmap`
  - **Purpose**: Holds the configuration data for Redis.

### Service

- **Name**: `redis-cluster-service`
- **Ports**:
  - **Client**: Port `6379`, TargetPort `6379`
  - **Gossip**: Port `16379`, TargetPort `16379`

### StatefulSet

- **Name**: `redis-cluster`
- **Replicas**: `6`
- **Image**: `redis:5.0.1-alpine`
- **Label**: `app: redis-cluster`
- **Container Name**: `redis`
- **Command**: `["/conf/update-node.sh", "redis-server", "/conf/redis.conf"]`
- **Ports**:
  - **Client**: `6379`
  - **Gossip**: `16379`
- **Volume Mounts**:
  - **Conf**: MountPath `/conf`
  - **Data**: MountPath `/data`
- **Volumes**:
  - **Conf**: ConfigMap `redis-cluster-configmap`, DefaultMode `0755`
- **VolumeClaimTemplates**:
  - **Name**: `data`
  - **AccessModes**: `ReadWriteOnce`
  - **Storage Request**: `1Gi`

### PersistentVolumes

- **Names**: `redis01`, `redis02`, `redis03`, `redis04`, `redis05`, `redis06`
- **Access Modes**: `ReadWriteOnce`
- **Size**: `1Gi`
- **HostPaths**:
  - `/redis01`, `/redis02`, `/redis03`, `/redis04`, `/redis05`, `/redis06`

### Redis Cluster Initialization Command

```bash
kubectl exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}')
```

## 🗂️ Files in This Repository

- **`statefulset.yaml`**: StatefulSet configuration for the Redis cluster.
- **`service.yaml`**: Service configuration to expose the Redis cluster.
- **`persistentvolumes.yaml`**: PersistentVolume configurations.
- **`configmap.yaml`**: Configures Redis settings.
- **`deploy.sh`**: Deployment script to automate the creation of resources.
- **`README.md`**: This file, providing challenge details and instructions.

## 🚀 Getting Started

### Prerequisites

- **Kubernetes Cluster**: Ensure you have a running Kubernetes cluster.
- **kubectl**: Install `kubectl` and configure it to interact with your Kubernetes cluster.

### Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/prudvikeshav/Kubernetes-Challenges.git
   cd Kubernetes-Challenges/Challenge-4
   ```

2. **Deploy the Redis Cluster**

   Apply the Kubernetes manifests to set up the Redis cluster:

   ```bash
   kubectl apply -f configmap.yaml
   kubectl apply -f service.yaml
   kubectl apply -f persistentvolumes.yaml
   kubectl apply -f statefulset.yaml
   ```

3. **Run the Deployment Script**

   Make the deployment script executable and run it:

   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```

4. **Verify the Deployment**

   Check the status of the Redis pods and services:

   ```bash
   kubectl get pods
   kubectl get services
   ```

5. **Initialize the Redis Cluster**

   Execute the following command to initialize the Redis cluster:

   ```bash
   kubectl exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}')
   ```

6. **Verify Redis Cluster Initialization**

   Confirm that the Redis cluster is properly initialized:

   ```bash
   kubectl exec -it redis-cluster-0 -- redis-cli cluster info
   ```

## 📦 Deliverables

1. **Kubernetes Configuration Files**: Ensure that the StatefulSet, Service, and PersistentVolume YAML files are correctly implemented.
2. **Deployment Script**: `deploy.sh` automates the creation of resources.
3. **Verification**: Confirm that all pods are running and the Redis cluster is properly initialized.

## 📝 Notes

- Ensure that the PersistentVolume directories (`/redis01`, `/redis02`, etc.) exist on the worker nodes.
- Verify the Redis cluster's status and health using `redis-cli`.

Good luck with your Redis cluster deployment! 🚀

## License

This project is licensed under the [MIT License](LICENSE). See the [LICENSE](LICENSE) file for details.

## Contact

For questions or issues, please open an issue on the repository or contact [Your Name] at [Your Email Address].

