oc create -f createimagestream.yaml -n mq
oc create -f CustomImagePolicy.yaml -n mq
oc create -f buildconfig.yaml -n mq
oc start-build mqace -n mq
oc create -f mqcert.yaml -n mq
oc create -f route.yaml -n mq
