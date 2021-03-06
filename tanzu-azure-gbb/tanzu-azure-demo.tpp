TELEPROMPTER_SETTINGS:013,072,09,0,0
{\rtf1\fbidis\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Segoe UI;}{\f1\fnil Segoe UI;}}
{\colortbl ;\red0\green0\blue0;\red255\green255\blue0;\red255\green215\blue0;}
{\*\generator Riched20 10.0.19041}\viewkind4\uc1 
\pard\tx720\cf1\highlight2\b\f0\fs27\par
\par
\par
\par
\par
INTRO\highlight0\f1\par
\par
\b0\f0 First we'll establish context with our Tanzu Build Service, which is running on our AKS cluster.\b\par
\f1\par
\b0\f0 Before we create our container images, I will list the repositories we have in our Azure Container Registry.\par
\par
\i az acr repository list -n tanzuregistry\i0\par
\par
You'll notice the buildpacks and stacks we imported when Build Service was installed and setup.\par
\par
Next, we'll list our running clusters.\b\par
\par
\b0\i\f1 tkg get clusters\b\i0\par
\par
\b0\i az aks list -g tanzu-azure --query '[].\{name:name, k8s:kubernetesVersion\}' --output table\par
\par
gcloud container clusters list --region us-east1 --format='table(name,master_version())'\par
\par
\i0\f0 You'll notice the prompt changes. I thought this might be helpful for us to keep track of which cluster we're in or the context as we're hopping around.\i\par
\par
\highlight2\b\i0 TBS\highlight0\b0\i\par
\par
\i0 Now we'll list the images that TBS keeps track of.\par
\par
Let's create our two images.\par
\par
.....\par
.....\par
\par
\par
This can take a minute or so, but we can check the status...\par
\par
...or view the build in process.\par
\par
Finally, we'll refresh our container registry to see our newly created images.\par
\par
\highlight1\ulth SUMMARY \highlight0\ulnone - Docker files not included. The buildpack scripts compile and build the code and bake those binaries and dependencies into the image. This greatly improves our velocity for DevOps teams.\par
\par
\highlight2\b TKG\highlight0\b0\par
\par
We'll push those images now to our clusters.\par
\par
\highlight2\b TMC\highlight0\b0\par
\par
\highlight1\ulth SUMMARY \highlight0\ulnone - In a single, centralized dashboard, operators can provision or attach Kubernetes clusters, manage lifecycle workloads across a variety of different hybrid scenarios, both on-premises and public cloud. Clusters across these different environments can be treated as a group and have policy applied and enforced across all clusters across environments.\par
\par
\par
\highlight3\b WRAP\highlight0\b0\par
\par
That's a wrap for today. Just a quick recap...\par
\par
We built container images out of a spring boot app and an ASP.NET Core app and showed \ulth\b TBS \ulnone\b0 hosted on Azure Container Registry.\par
\par
We deployed these images on to three clusters, 1) a native AKS cluster, 2) a TKG cluster hosted on Azure, and 3) a GKE cluster for good measure.\par
\par
Finally, we attached these clusters to \ulth\b TMC \ulnone\b0 and grouped them accordingly into cluster groups, created namespaces, and created an image registry policy and reviewed both OPA and PSP policies TMC supports.\par
\par
Again, thanks for your time today!\f1\par
}
 