---
sidebar_position: 6
---

# Installation

To get started quickly, we recommend to run VILLAS in a small Kubernetes cluster.

:::important
There are [dedicated installation instructions for VILLASnode](node/installation.md) in case you only want to use the simulation gateway instead of the full framework.

**For beginners, we recommend to start looking at VILLASnode first.**
:::

You can run the full set of VILLASframework components pre-configured in a Kubernetes cluster using the [Helm chart](https://github.com/VILLASframework/chart).

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

```shell
minikube start
```

4. Enable the Ingress controller in your minikube cluster:

```shell
minikube addons enable ingress
```

## Helm Chart

To deloy the Helm chart you must first add the FEIN e.V. chart repository:

```shell
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

```shell
helm install -f values.yaml villas fein/villas
```

## Access the application {#access}

1. Keep the following command in a terminal running in a background terminal:

```shell
minikube kubectl -- -n ingress-nginx port-forward svc/ingress-nginx-controller 8080:80 --address='0.0.0.0'
```

Once the installation has completed, you can visit the VILLASweb interface at the following address: http://villas.192-168-1-100.nip.io:8080/
Please use the username / password from above (`admin` / `VillasTest1234`) to login.

## Troubleshooting Tips {#troubleshooting}

If the login with the configured admin user credentials is not working, it is most likely caused by some unhealthy components of the VILLASframework setup.
Use the `kubectl` tool to troubleshoot the issue:

```shell
minikube kubectl -- get all
```

This command should list all the micro-services of the framework:

```
NAME                                      READY   STATUS    RESTARTS   AGE
pod/villas-broker-0                       1/1     Running   0          46d
pod/villas-controller-5fd7ffcc94-6wtgk    1/1     Running   3          50d
pod/villas-node-5886d65784-56vkv          1/1     Running   189        50d
pod/villas-pintura-5b4f67b778-nmkp4       1/1     Running   0          50d
pod/villas-relay-68b9bd9749-j6cz8         1/1     Running   6          61d
pod/villas-s3-776d564c7d-7tqdg            1/1     Running   0          50d
pod/villas-signaling-58d9968db8-jtqgg     1/1     Running   1          50d
pod/villas-web-backend-55846fb89f-64f66   1/1     Running   3          2m17s
pod/villas-web-frontend-8544c4c97-bwb85   1/1     Running   4          75d
pod/villas-web-frontend-8544c4c97-qxrz7   1/1     Running   1          50d

NAME                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                                                      AGE
service/villas-broker            NodePort    10.110.19.38     <none>        5672:30809/TCP,4369:31485/TCP,25672:31143/TCP,15672:32192/TCP,1883:30813/TCP                                 299d
service/villas-broker-headless   ClusterIP   None             <none>        4369/TCP,5672/TCP,25672/TCP,15672/TCP                                                                        533d
service/villas-controller        ClusterIP   10.102.148.101   <none>        80/TCP                                                                                                       231d
service/villas-node              ClusterIP   10.98.62.216     <none>        80/TCP,12000/UDP,12001/UDP,12002/UDP,12003/UDP,12004/UDP,12005/UDP,12006/UDP,12007/UDP,12008/UDP,12009/UDP   578d
service/villas-pintura           ClusterIP   10.105.42.155    <none>        80/TCP                                                                                                       148d
service/villas-relay             ClusterIP   10.111.135.48    <none>        80/TCP                                                                                                       578d
service/villas-s3                ClusterIP   10.107.135.160   <none>        9000/TCP                                                                                                     578d
service/villas-signaling         ClusterIP   10.96.113.236    <none>        80/TCP                                                                                                       111d
service/villas-web-backend       ClusterIP   10.105.91.100    <none>        80/TCP                                                                                                       546d
service/villas-web-frontend      ClusterIP   10.96.96.174     <none>        80/TCP                                                                                                       578d

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/villas-controller           1/1     1            1           280d
deployment.apps/villas-node                 1/1     1            1           280d
deployment.apps/villas-pintura              1/1     1            1           148d
deployment.apps/villas-relay                1/1     1            1           280d
deployment.apps/villas-s3                   1/1     1            1           280d
deployment.apps/villas-signaling            1/1     1            1           111d
deployment.apps/villas-web-backend          1/1     1            1           280d
deployment.apps/villas-web-frontend         2/2     2            2           280d
```

Make sure that all deployments are ready and pods (a.k.a containers) are in a running state.
If for some reason a deployment is not ready, you can use the following `kubectl` command to show the log of the respective pod.

```shell
minikube kubectl -- logs pod/villas-web-backend-55846fb89f-64f66
```

For more information on how to troubleshoot the setup with the `kubectl` tool, please consult [the `kubectl` documentation](https://kubernetes.io/docs/reference/kubectl/) and guides about Kubernetes in general.

To gain a deeper understanding of the micro-service architecture, we recommend to also have a closer look at the [VILLAS Helm chart source code](https://git.rwth-aachen.de/acs/public/catalogue/-/tree/master/charts/villas).
