# mcsoc
network reference archtitecture

### Starting the Suite

````
cd vagrant
./vagrant_up_all.sh
````

Unfortunately, the routers don't spin up well.

````
http://127.0.0.1:[55433-55436]
````

Using the URL(s) above, from your host,
* login to a router
* Status > Gateways > Restart Service
* System > Routing > Gateways
* Select the default gateway for editing
* Select the [Save] button
* Apply the changes
* Verify default route set at
+ Diagnostics > Route


### Unit Testing the Suite

````
cd test
.\make_unittest_report.sh
````

takes roughly 20 minutes on my machine


### Stopping the Suite


````
cd vagrant
./vagrant_halt_all.sh
````


