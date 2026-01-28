Serverless computing has some interesting advantages:

* Hardware and the OS are both 100% abstracted away.
* Deployment cycles can be as fast as seconds, compared to minutes for containers or many minutes for VM's.
* Efficient - and the gains from this efficiency are often passed down as cost savings to you.
* Pricing scales perfectly with storage.

And some disadvantages:

* The size of what you can trigger based on an event is often limited.
* Function run time is often limited.
* Disk space is limited and often ephemeral.
* Little control over hardware, and therefore performance tuning is hard.
* There is no host to SSH in to which may limit your debugging.
* Cold starts (a request after a period of no requests) may be slow.
* Long running connections to e.g. a database are often problematic.

Some gotchas I ran in to:

* This didn't work in ap-southeast-4 but worked in ap-southeast-2 - potentially because the newer ap-southeast-4 region doesn't allow function URLs yet.
* Had some odd permission errors that resolved after destroying and re-applying the terraform. Potentially this is because the service role was created too quickly before the lambda function.
