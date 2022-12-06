# Usage

VILLAScontroller consist of two parts:

 - A daemon which listens for control commands from an AMQP broker and controls the simulator.
 - A CLI tool for sending commands to the broker

Both parts are accessible from the `villas-controller` command.

## Quick-start

1. Install VILLAScontroller

```bash
git clone https://github.com/VILLASframework/controller.git
sudo python3 setup.py install
```

2. Start RabbitMQ broker

```bash
docker run -p 5672:5672 -p 15672:15672 -d rabbitmq:management
```

3. Create configuration file: `config.json`:

```json
{
	"broker" : {
		"url" : "amqp://guest:guest@localhost/%2F"
	},
	"components" : [
		{
			"name" : "Dummy Simulator #1",
			"type" : "dummy",
			"realm" : "de.rwth-aachen.eonerc.acs",
			"uuid" : "e15f5ad4-041f-11e8-9bf3-23372608bf60",
			"location" : "Steffen's Laptop",
			"owner" : "svo"
		},
		{
			"name" : "Dummy Simulator #2",
			"type" : "dummy",
			"realm" : "de.rwth-aachen.eonerc.acs",
			"uuid" : "ef6f6e46-044e-11e8-812f-17b6617a2f37",
			"location" : "Markus' Laptop",
			"owner" : "mgr"
		}
	]
}
```

4. Start VILLAScontroller daemon:

```bash
villas-controller --config config.json daemon
```

5. Start monitor:

```bash
villas-controller monitor
```

**Note:** If you have `jq` installed, you might want to add `| jq .` to the end for pretty printing the JSON messages.

5. Discover / ping simulators:

```bash
villas-controller simulator ping
```

6. Send commands to VILLAScontroller daemon:

**Note:** Take the UUID from step 5.

```bash
villas-controller simulator --uuid ef6f6e46-044e-11e8-812f-17b6617a2f37 start
villas-controller simulator --uuid ef6f6e46-044e-11e8-812f-17b6617a2f37 pause
villas-controller simulator --uuid ef6f6e46-044e-11e8-812f-17b6617a2f37 resume
villas-controller simulator --uuid ef6f6e46-044e-11e8-812f-17b6617a2f37 stop
```


## Example: Kubernetes

```bash
MANAGER_UUID=614dc3d3-6825-47d3-b991-05d082eb2494
SIMULATOR_UUID=9afeebf4-825a-45cd-bd25-1b6c219ed72a
```

### Create simulator

```bash
villas-controller --config etc/config_k8s.yaml simulator --uuid ${MANAGER_UUID} create --parameters-file etc/params_k8s_create.yaml
```

### Start job/simulation

```bash
villas-controller --config etc/config_k8s.yaml simulator --uuid ${SIMULATOR_UUID} start
```
