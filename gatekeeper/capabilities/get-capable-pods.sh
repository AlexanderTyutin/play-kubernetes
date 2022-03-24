#!/bin/bash

for namespace in $(minikube kubectl get ns | tail -n+2 | awk '{print $1}'); do
	#echo Searching in namespace "${namespace}"
	for pod in $(minikube kubectl -- get pods --namespace "${namespace}" 2>/dev/null 2>/dev/null | tail -n+2 | awk '{print $1}'); do
		minikube kubectl -- \
			get po "${pod}" --namespace "${namespace}" \
			-o json | jq -c '.spec.containers[].securityContext.capabilities.add' | \
			grep -q null || \
			echo "Capable pod ${pod}  ("\
			"$(minikube kubectl -- get po "${pod}" --namespace "${namespace}" -o json | jq -c '.spec.containers[].securityContext.capabilities.add')" \
			") in the namespace ${namespace} based on image" \
			"$(minikube kubectl -- get po "${pod}" --namespace "${namespace}" -o json | jq -r '.spec.containers[].image')"
	done
done	

