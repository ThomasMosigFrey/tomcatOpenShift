appName=coba
projectName=coba
deploymentDir=/Users/thomas/IdeaProjects/SimpleWebApp/deployment

oc delete project $projectName 2>/dev/null
while oc project coba 2>/dev/null; do sleep 1; done

is=$(oc get is --all-namespaces | grep tomcat9 | grep rhel7 | grep jdk11 | awk '{print $3,$4}' | sed -e 's/ /:/' -e 's/,.*//')

oc new-project coba
oc project coba

oc new-build $is --name=$appName --binary=true
mv $deploymentDir/SimpleWebApp.war $deploymentDir/ROOT.war
oc start-build $appName --from-dir=$deploymentDir --follow=true --wait=true

cd src/main/resources
for item in deployment_coba.yaml route_coba.yaml service_coba.yaml
do
	oc apply -f $item
done
cd -

#oc new-app $appName
#oc expose service/$appName

