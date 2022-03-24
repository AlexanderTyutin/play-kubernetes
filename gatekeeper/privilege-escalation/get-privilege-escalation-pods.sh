#!/bin/bash

for namespace in $(minikube kubectl get ns | tail -n+2 | awk '{print $1}'); do
	#echo Searching in namespace "${namespace}"
	for pod in $(minikube kubectl -- get pods --namespace "${namespace}" 2>/dev/null 2>/dev/null | tail -n+2 | awk '{print $1}'); do
		minikube kubectl -- \
			get po "${pod}" --namespace "${namespace}" \
			-o json | jq -r '.spec.containers[].securityContext.allowPrivilegeEscalation' | \
			grep -q true && \
			echo "Privilege escalation allowed in pod ${pod} in the namespace ${namespace} based on image" \
			"$(minikube kubectl -- get po "${pod}" --namespace "${namespace}" -o json | jq -r '.spec.containers[].image')"
	done
done	

