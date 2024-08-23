**Challenge Question:**

You are tasked with deploying a Jekyll Static Site Generator (SSG) using Kubernetes. Your task involves setting up the required Kubernetes resources, including PersistentVolume (PV), PersistentVolumeClaim (PVC), Pod, and Service. Additionally, you need to configure user permissions and contexts in the kubeconfig file. Here's a detailed breakdown of what needs to be done:

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

**Instructions:**

1. Ensure all configurations and Kubernetes resources are correctly defined.
2. Execute the required commands to set up the kubeconfig, PVC, Pod, Service, Role, and RoleBinding.
3. Verify that the Jekyll site is correctly initialized and served by the pod
