# Jenkins on Kubernetes with Terraform (JCasC + Persistent Storage)

Provision a fully configured **Jenkins** instance on Kubernetes using **Terraform**.

This project deploys:

* A dedicated namespace per environment
* Jenkins Deployment (prebuilt image with plugins)
* JCasC (Jenkins Configuration as Code) via ConfigMap
* Persistent storage (local PV + PVC)
* RBAC (ServiceAccount, Role, RoleBinding)
* NodePort Service for UI + agents

Everything is managed declaratively. No manual setup inside the Jenkins UI.

---

## Architecture Overview

Terraform provisions Kubernetes resources using:

* `hashicorp/kubernetes`
* `gavinbunney/kubectl`
* `kreuzwerker/docker`
* `hashicorp/random`

Jenkins runs:

* 1 replica
* Backed by a PersistentVolume
* Configured automatically via JCasC
* Exposed via NodePort

---

## What Gets Created

### 1. Namespace

Namespace pattern:

```
ci-cd-${var.environment}
```

Default:

```
ci-cd-dev
```

---

### 2. Jenkins Deployment

* Image: `ken0k/jenkins_with_plugins:1.0.0`
* CPU request: 500m
* Memory request: 1Gi
* CPU limit: 1
* Memory limit: 2Gi
* Runs with a dedicated ServiceAccount
* Mounts:

  * Persistent volume at `/var/jenkins_home`
  * JCasC config at `/var/jenkins_home/casc`

JCasC is enabled using:

```
CASC_JENKINS_CONFIG=/var/jenkins_home/casc/jenkins.yaml
```

---

### 3. Jenkins Configuration (JCasC)

Defined in `configmap.tf`.

Key configuration:

* System message set
* `numExecutors: 0`
* `mode: EXCLUSIVE`
* Local security realm
* Default user:

  * Username: `admin`
  * Password: `admin`
* Logged-in users can do anything
* Kubernetes cloud configured

  * Namespace: `ci-cd-dev`
  * Jenkins URL: `http://jenkins-svc:8080`
  * Agent tunnel: `jenkins:50000`

⚠️ UI changes will not persist. All configuration must be managed through Terraform/JCasC.

---

### 4. Storage

#### Storage Class

* Name: `local-storage`
* Provisioner: `kubernetes.io/no-provisioner`
* Binding mode: Immediate

#### Persistent Volume

* Local path: `var.mounted_logical_volume`
* Size: `var.pv_storage_size` (default 30Gi)
* Access mode: `ReadWriteOnce`
* Node affinity:

  * `node1-hp`
  * `node2-hp`

#### Persistent Volume Claim

* Size: `var.pvc_storage_size` (default 10Gi)
* Bound automatically (`wait_until_bound = true`)

---

### 5. RBAC

* ServiceAccount: `jenkins-svc-acc`
* Role permissions:

  * Pods (create, delete, get, list, watch)
  * Pod logs
  * Jobs (batch API)
  * Read specific secret: `reigstry-credentials`
* RoleBinding attaches role to ServiceAccount

This allows Jenkins to spawn and manage Kubernetes build agents.

---

### 6. Service

Type: `NodePort`

| Port Type | Port  | NodePort |
| --------- | ----- | -------- |
| HTTP      | 8080  | 30080    |
| Agent     | 50000 | 30050    |

Access Jenkins UI:

```
http://<node-ip>:30080
```

---

## Variables

### Required

You must provide:

```
host
client_certificate
client_key
cluster_ca_certificate
mounted_logical_volume
```

These connect Terraform to your Kubernetes cluster.

---

### Optional / Defaults

| Variable               | Default                                                    |
| ---------------------- | ---------------------------------------------------------- |
| environment            | dev                                                        |
| pvc_storage_size       | 10Gi                                                       |
| pv_storage_size        | 30Gi                                                       |
| docker_registry        | [https://index.docker.io/v1/](https://index.docker.io/v1/) |
| additional_casc_config | ""                                                         |

Sensitive variables:

* dockerhub_username
* dockerhub_password
* git_username
* git_password

---

## Usage

### 1. Initialize

```bash
terraform init
```

### 2. Provide Variables

Example `terraform.tfvars`:

```hcl
environment               = "dev"
host                      = "https://your-cluster-endpoint"
client_certificate        = "<base64-cert>"
client_key                = "<base64-key>"
cluster_ca_certificate    = "<base64-ca>"
mounted_logical_volume    = "/mnt/jenkins"
```

### 3. Apply

```bash
terraform plan
terraform apply
```

---

## Access Jenkins

After deployment:

```
http://<node-ip>:30080
```

Login:

```
admin / admin
```

Change credentials immediately in production.

---

## Design Decisions

### Why local PV?

* Simple
* Predictable
* Suitable for homelab or small clusters

Not suitable for:

* Multi-node dynamic scheduling
* Cloud-native HA setups

### Why JCasC?

* Immutable configuration
* GitOps-friendly
* Reproducible environments
* No manual UI drift

---

## Limitations

* Hardcoded node affinity (`node1-hp`, `node2-hp`)
* Static NodePort exposure
* Default admin credentials
* Single replica (no HA)
* Local storage only

This is ideal for:

* Homelab
* Learning Kubernetes
* Controlled CI environments

---

## Future Improvements

* Replace NodePort with Ingress
* Externalize admin credentials into Kubernetes Secrets
* Use dynamic storage provisioner
* Implement Helm-based modularization
* Enable HA (Jenkins with external DB)
* Harden RBAC and security context

---

## Summary

This project delivers:

* Fully declarative Jenkins on Kubernetes
* Persistent storage
* RBAC-controlled agent execution
* Configuration-as-Code enforcement
* Environment-based namespace isolation

No manual setup. No click-ops. Fully reproducible.

If you destroy it and reapply — you get the exact same Jenkins instance.
