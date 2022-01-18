k get pods -A -o jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.spec.containers[].image}{'\n'}" | column -t
