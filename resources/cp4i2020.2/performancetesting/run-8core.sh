#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ENV_NAME=${2:-"ibmcloudclassic"}

cd deploy
./install_8core.sh $TARGET_NAMESPACE $ENV_NAME
echo "********************Single instance ****************************"
echo "****************************************************************"
cd ../test
./run8CoreTests.sh

cd ../deploy
./cleanup-8core.sh

cd ../test
./cleanup-8core.sh

cd ..

cd deploy
./install_8corenativeha.sh $TARGET_NAMESPACE $ENV_NAME

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run8CoreTests.sh

cd ../deploy
./cleanup-8core.sh
