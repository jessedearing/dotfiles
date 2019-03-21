function use-aws-config() {
  export AWS_CONFIG_FILE=$HOME/.aws/$1
}

function use-kube-config() {
  export KUBECONFIG=$HOME/.kube/$1
}
