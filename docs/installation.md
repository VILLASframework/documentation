---
sidebar_position: 6
---

# Installation

To get started quickly, we recommend to run VILLAS in a small Kubernetes cluster.

:::important
There are [dedicated installation instructions for VILLASnode](node/installation.md) in case you only want to use the simulation gateway instead of the full framework.

**For beginners, we recommend to start looking at VILLASnode first.**
:::

You can run the full set of VILLASframework components pre-configured in a Kubernetes cluster using the [Helm chart](https://git.rwth-aachen.de/acs/public/catalogue/-/blob/master/charts/villas/).

## Requirements

- Linux (recommended), Windows or macOS system
- [Kubernetes](https://kubernetes.io) >= v1.18 (tested)
- [Helm (v3)](https://helm.sh/)
- [Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)

## Minikube

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

## Helm Chart

To deloy the Helm chart you must first add the FEIN e.V. chart repository:

```bash
helm repo add fein https://packages.fein-aachen.org/helm/charts/
helm repo update
```

Create a minimal chart configuration file named `values.yaml` with the following contents:
Please have a look at the charts [default values](https://git.rwth-aachen.de/acs/public/catalogue/-/blob/master/charts/villas/values.yaml) for more details about the available configuration options.

:::info
In this guide we assume the host running Minikube is accessible via the local IP address `192.168.1.100`.

Please make sure to update the `ingress.host` setting with a resolvable hostname of the machine running Minikube or update the `nip.io` name it with the real IP address as shown below.
:::

```yaml title="values.yaml"
web:
  auth:
    admin:
      mail: admin@example.com
      username: admin

      # please to change to a secure password
      password: VillasTest1234

ingress:
  port: 8080
  host: villas.192-168-1-100.nip.io 

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

## Access the application {#access}

1. Keep the following command in a terminal running in a background terminal:

```bash
minikube kubectl -- -n ingress-nginx port-forward svc/ingress-nginx-controller 8080:80 --address='0.0.0.0'
```

Once the installation has completed, you can visit the VILLASweb interface at the following address: http://villas.192-168-1-100.nip.io:8080/
Please use the username / password from above (`admin` / `VillasTest1234`) to login.
