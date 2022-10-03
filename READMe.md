


https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx

kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
# should output "foo"
curl localhost/foo
# should output "bar"
curl localhost/bar




kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: skooner-sa-secret
  namespace: default
  annotations:
    kubernetes.io/service-account.name: skooner-sa
type: kubernetes.io/service-account-token
EOF

-- admin access
describe secret skooner-sa-secret

eyJhbGciOiJSUzI1NiIsImtpZCI6Ik1DVHREd1dCTUFDbVVkREdCR3BDN0xIM19jcURabjRwOGctU0FxVldDejgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InNrb29uZXItc2Etc2VjcmV0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6InNrb29uZXItc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJmMDM4YmJkMC1jYTBhLTQ0M2YtYjZmMC00MmU5ZGRmNzVjMjAiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpza29vbmVyLXNhIn0.eIr4iKlPTZjDEMAElHAES5nIdbJq4nprkRkD99PGtEJip2k4Wm6p3LPlN6J_sqBvWOFRFsR1v8WfSvFlwANjktKJ57ZgfScn4NeEnx9V98lzRYT9VWQhJ_2VrxpeCqZdmBwKggO6eueDh1mSJGXlSl7GkNB8FfWJmjpzHoTx78QXs_U5rau0UWws-5kucwwiHAPMhXd1C9yf8SCMafydxmtOr-zlneTHi80tcubYYHZ6fzutL-7nixa4HABBBhDCTQuomYok6F7X2rn0wGVKpMH44ptVwC6m2B7blKIVAQ2eakd1VCXLR3MEbGPXdIxS0TqS8A4L6Kexjc8L0VrfHg




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
	      oidc-groups-claim: groups
EOF




0oa9d5rofkNd3AOV44x7


wYz5I-1l_sXOKH-SQ3FZna4o3BUgSfgHnx4UJA2i


https://dev-836757-admin.okta.com



OIDC_URL=https://dev-836757-admin.okta.com
OIDC_ID=0oa9d5rofkNd3AOV44x7
OIDC_SECRET=wYz5I-1l_sXOKH-SQ3FZna4o3BUgSfgHnx4UJA2i

kubectl create secret -n kube-system generic skooner \
--from-literal=url="$OIDC_URL" \
--from-literal=id="$OIDC_ID" \
--from-literal=secret="$OIDC_SECRET"

kubectl apply -f https://raw.githubusercontent.com/skooner-k8s/skooner/master/kubernetes-skooner-oidc.yaml

# kubernetes
# kubernetes
# kubernetes
# kubernetes
# kubernetes
