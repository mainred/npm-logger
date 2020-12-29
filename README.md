# npm-log-collector

## introduction

Npm logger is a tool to get all logs needed to ts azure npm. It collects diagnostic info by one shot, and send the file to the Azure file share under node resource group with name like _MC_myResourceGroup_myAKSCluster_eastus_

## Detail instructions

1. Git clone the repo to your local pc
2. Run the following command to start to collect diagonstic info
    `kubectl create -f npm-log-collector.yaml`
3. Wait untill the pod reports completed.
    You may find all the zipped files, named by hostnmae, in the Azure file share
4. Download the data and provide to support
5. Delete the daemonset by `kubectl delete -f npm-log-collector.yaml`

## collects

- iptables -L -t filter -n
- ipset list
- iptables-save
- ip route
- ip rule
- npm-logs
- kubectl get pods
- kubectl get networkpolicy
- kubectl get cluster-info
- kubectl version
