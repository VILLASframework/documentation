# Installation {#installation}

To get started quickly, we recommend to run VILLAS in a small Kubernetes cluster.

You can run the full set of VILLASframework components pre-configured in a Kubernetes cluster using the [Helm chart](https://git.rwth-aachen.de/acs/public/catalogue/-/blob/master/charts/villas/).

# Requirements {#installation-prereq}

- Linux (recommended), Windows or macOS system
- [Kubernetes](https://kubernetes.io) >= v1.18 (tested)
- [Helm (v3)](https://helm.sh/)
- [Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)

# Minikube {#installation-minikube}

For small tests and beginners we recommend a local Minikube setup.

1. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)
2. [Install Helm](https://helm.sh/docs/intro/quickstart/)
3. Enable the Ingress controller in your minikube cluster:

	minikube addons enable ingress

# Helm chart {#installation-helm}

To deloy the Helm chart you must first add the FEIN e.V. chart repository:

```bash
helm repo add fein https://packages.fein-aachen.org/helm/charts/
helm repo update
```

After adjusting your configuration settings (see next section) you can deploy the chart with the following command:

```bash
helm install -f values.yaml villas fein/villas
```

# Configuration {#installation-config}

Please have a look at the charts [default values](https://git.rwth-aachen.de/acs/public/catalogue/-/blob/master/charts/villas/values.yaml).

Also have a look at the [Helm charts Git repo](https://git.rwth-aachen.de/acs/public/catalogue) for more details.

# Admin Password {#installation-admin-pass}

Run the following kubectl commands to retrieve the initial admin credentials:

```
echo ADMIN_USER: admin
echo ADMIN_PASS: $(kubectl get secret --namespace villas villas-web -o jsonpath="{.data.password}" | base64 --decode)
```

# Access the application {#installation-access}

@todo Add explanation how to access Ingress
