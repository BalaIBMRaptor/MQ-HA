#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ENV_NAME=${2:-"ibmcloudclassic"}

cd deploy
./install_2core.sh $TARGET_NAMESPACE $ENV_NAME
echo "********************Single instance ****************************"
echo "****************************************************************"
cd ../test
./run2CoreTests.sh

cd ../deploy
./cleanup-2core.sh

cd ../test
./cleanup-2core.sh

cd ..

cd deploy
./install_2corenativeha.sh $TARGET_NAMESPACE $ENV_NAME

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run2CoreTests.sh

cd ../deploy
./cleanup-2core.sh
