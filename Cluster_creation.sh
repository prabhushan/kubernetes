cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: worker
- role: control-plane
  kubeadmConfigPatches:
    - |
      kind: ClusterConfiguration
      apiServer:
        extraArgs:
          oidc-issuer-url: https://dev-836757-admin.okta.com
          oidc-client-id: 0oa9d5rofkNd3AOV44x7
          oidc-username-claim: email

    - |
      kind: InitConfiguration
      nodeRegistration:
        kubeletExtraArgs:
          node-labels: "ingress-ready=true"
          authorization-mode: "AlwaysAllow"

  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
  - containerPort: 30000
    hostPort: 30000
    protocol: TCP

EOF

##Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml


##skooner
kubectl apply -f https://raw.githubusercontent.com/skooner-k8s/skooner/master/kubernetes-skooner.yaml
kubectl apply -f /Users/pshanmughapriyan/Desktop/learning/k8s/ingress.yaml


export OIDC_URL=https://dev-836757-admin.okta.com
export OIDC_ID=0oa9d5rofkNd3AOV44x7
export OIDC_SECRET=wYz5I-1l_sXOKH-SQ3FZna4o3BUgSfgHnx4UJA2i

kubectl create secret -n kube-system generic skooner \
--from-literal=url="$OIDC_URL" \
--from-literal=id="$OIDC_ID" \
--from-literal=secret="$OIDC_SECRET"


kubectl apply -f https://raw.githubusercontent.com/skooner-k8s/skooner/master/kubernetes-skooner-oidc.yaml
# kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
# # should output "foo"
# curl localhost/foo
# # should output "bar"
# curl localhost/bar


kubectl apply -f - <<EOF
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: oidc-cluster-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: User
  name: pshanmughapriyan@tistatech.com
EOF