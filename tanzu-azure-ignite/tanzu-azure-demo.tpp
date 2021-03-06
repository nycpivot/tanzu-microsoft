TELEPROMPTER_SETTINGS:013,072,09,0,0
{\rtf1\fbidis\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Segoe UI;}{\f1\fnil Segoe UI;}}
{\colortbl ;\red0\green0\blue0;\red255\green255\blue0;}
{\*\generator Riched20 10.0.19041}\viewkind4\uc1 
\pard\tx720\cf1\highlight2\b\f0\fs28\par
\par
\par
\par
CLUSTERS\highlight0\f1\par
\par
\b0\f0 In the Tanzu Mission Control portal, we would open the Clusters tab to see all of our workloads across all of our public and private clouds.\par
\par
Now for many organizations in a hybrid cloud topology, of sorts, this grid might list 1000s of clusters from Azure, GCP, AWS, vSphere, OpenShift, or any conformant Kubernetes cluster.\par
\par
We get instant visibility to where all of our workloads are running in a single view. Without a dashboard of this nature, we would rely on different portals or CLIs for every environment.\par
\par
You'll see our "tanzu-azure-ignite" cluster. Clicking into any one of these clusters, consistently shows the same detailed information regardless of its source environment.\par
\par
\highlight2\b NAMESPACES\highlight0\b0\par
\par
Creating namespaces in TMC has the same effect of running a kubectl command. The difference, however, is that they are 1) managed from TMC, and 2) can be grouped into workspaces across clusters, which factors into our policies.\par
\par
\highlight2\b POLICY\highlight0\b0\par
\par
It's on the Policy Assignments tab where we can create a policy that will be applied across all clusters or workspaces at a given scope. In other words, if we create an Access policy at the root Organization level or a Cluster Group level, it would cascade down to all the clusters beneath that level. Those multiple console windows in the slide for each target environment is no longer necessary.\par
\par
There are a variety of policies we can apply, 1) image registry, determines which container registry the organization allows, 2) network, defines ingress/egress rules between pods, 3) security, specifies the level of privileges a container can have in relation to its host, what storage options are allowed, and 4) quota, to be able to set limits on how much CPU and memory resources a team is allocated.\f1\par
}
 