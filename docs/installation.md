---
sidebar_position: 6
---

# Installation {#installation}

To get started quickly, we recommend to run VILLAS in a small Kubernetes cluster.

You can run the full set of VILLASframework components pre-configured in a Kubernetes cluster using the [Helm chart](https://git.rwth-aachen.de/acs/public/catalogue/-/blob/master/charts/villas/).

## Requirements {#installation-prereq}

- Linux (recommended), Windows or macOS system
- [Kubernetes](https://kubernetes.io) >= v1.18 (tested)
- [Helm (v3)](https://helm.sh/)
- [Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)

## Minikube {#installation-minikube}

For small tests and beginners we recommend a local Minikube setup.

1. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)
2. [Install Helm](https://helm.sh/docs/intro/quickstart/)
3. Start Minikube:

```bash
minikube start
```

4. Enable the Ingress controller in your minikube cluster:

```bash
minikube addons enable ingress
```

## Helm chart {#installation-helm}

To deloy the Helm chart you must first add the FEIN e.V. chart repository:

```bash
helm repo add fein https://packages.fein-aachen.org/helm/charts/
helm repo update
```

Create a minimal chart configuration file named `values.yaml` with the following contents:
Please have a look at the charts [default values](https://git.rwth-aachen.de/acs/public/catalogue/-/blob/master/charts/villas/values.yaml) for more details about the available configuration options.

```yaml
web:
  auth:
    admin:
      mail: admin@example.com
      username: admin

	  # please to change to a secure password
      password: VillasTest1234

ingress:
  port: 8080
  host: localhost

broker:
  auth:
    username: admin
    password: vieQuoo2sieDahHee8ohM5aThaibiPei
    erlangCookie: iKpbgHPsHAj8x58kzFWVT23xahSQ03Vw
```

Once the configuration file has been prepared, start the installation with the following command: 

```bash
helm install -f values.yaml villas fein/villas
```

## Access the application {#installation-access}

1. Keep the following command in a terminal running in a background terminal:

```bash
kubectl -n ingress-nginx port-forward svc/ingress-nginx-controller 8080:80
```

Once the installation has completed, you can visit the VILLASweb interface at the following address: http://localhost:8080/
Please use the username / password from above (`admin` / `VillasTest1234`) to login.
