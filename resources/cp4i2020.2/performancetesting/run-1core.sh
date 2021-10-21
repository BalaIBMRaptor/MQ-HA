#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ENV_NAME=${2:-"ibmcloudclassic"}

cd deploy
./install_1core.sh $TARGET_NAMESPACE $ENV_NAME
echo "********************Single instance ****************************"
echo "****************************************************************"
cd ../test
./run1CoreTests.sh

cd ../deploy
./cleanup-1core.sh

cd ../test
./cleanup-1core.sh

cd ..

cd deploy
./install_1corenativeha.sh $TARGET_NAMESPACE $ENV_NAME

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run1CoreTests.sh

cd ../deploy
./cleanup-1core.sh
