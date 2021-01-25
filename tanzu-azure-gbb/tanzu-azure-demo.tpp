TELEPROMPTER_SETTINGS:013,072,09,0,0
{\rtf1\fbidis\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Segoe UI;}{\f1\fnil Segoe UI;}}
{\colortbl ;\red0\green0\blue0;\red255\green255\blue0;}
{\*\generator Riched20 10.0.19041}\viewkind4\uc1 
\pard\tx720\cf1\highlight2\b\f0\fs28\par
\par
\par
\par
\par
INTRO\highlight0\f1\par
\par
\b0\f0 Before we create our container images, let's just list our clusters as a quick sanity check.\b\par
\par
\b0\i\f1 tkg get clusters\b\i0\par
\par
\b0\i az aks list -g tanzu-azure --query '[].\{name:name, k8s:kubernetesVersion\}' --output table\par
\par
gcloud container clusters list --region us-east1 --format='table(name,master_version())'\par
\par
\i0\f0 Now you'll notice the prompt changes. I thought this might be helpful for us to keep track of which cluster we're in, as we'll be hopping around.\i\f1\par
\b\i0\par
\b0\f0 Next, we'll just query the Azure Container Registry to get a baseline of what's there.\par
\par
\i az acr repository list -n tanzuregistry\par
\par
\i0 Then we'll set our context to build service and list the images we've created so far that TBS has cached.\par
\par
Now, we'll create our two images.\par
\par
.....\par
.....\par
\par
\f1\par
}
 