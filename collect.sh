#!/bin/sh
BASEDIR=/mnt/npmlogs
LOGDIRNAME=$HOSTNAME
LOGDIR=$BASEDIR/$LOGDIRNAME
COMPRESSEDLOGFILE=${LOGDIR}.tar.gz
mkdir -p $LOGDIR

echo "logs will be stored in $LOGDIR"
echo "start to collect log: $(date)" >> $LOGDIR/date.txt

echo "Dumping Azure Npm Logs begin"
cat /var/log/azure-npm.log >> $LOGDIR/azure-npm.log

echo "Dumping IPTABLES-RULES"
iptables -vnL >> $LOGDIR/iptables.txt
echo "Dumping IPTABLES-SAVE"
iptables-save >> $LOGDIR/iptables.txt
echo "Dumping IPSET LISTS"
ipset list > $LOGDIR/ipsetlist.txt
echo "Dumping ROUTE LISTS"
ip route list >> $LOGDIR/iproute.txt
ip rule >> $LOGDIR/ipsetlist.txt

echo "Dumping kubectl network policy all name-spaces"
kubectl get networkpolicy --all-namespaces >> $LOGDIR/all-networkpolicies.txt
echo "" >> $LOGDIR/all-networkpolicies.txt
kubectl get networkpolicy --all-namespaces -o yaml >> $LOGDIR/all-networkpolicies.txt

echo "Dumping kubectl get pods -o wide"
kubectl get pods --all-namespaces -o wide >> $LOGDIR/all-pods.txt
echo "" >> $LOGDIR/all-pods.txt
kubectl get pods --all-namespaces -o yaml >> $LOGDIR/all-pods.txt

echo "Dumping kubectl cluster-info"
kubectl cluster-info >> $LOGDIR/cluserinfo.txt
kubectl version >> $LOGDIR/cluserinfo.txt

echo "finished to collect log: $(date)" >> $LOGDIR/date.txt

echo "compress log into $COMPRESSEDLOGFILE"
tar -czvf $COMPRESSEDLOGFILE -C $BASEDIR $LOGDIRNAME
rm -rf $LOGDIR

while $(true)
do 
echo "completed collecting logs, do not delete the logger till you copied the files"
sleep 40
done

