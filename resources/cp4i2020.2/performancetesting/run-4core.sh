#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ENV_NAME=${2:-"ibmcloudclassic"}

cd deploy
./install_4core.sh $TARGET_NAMESPACE $ENV_NAME
echo "********************Single instance ****************************"
echo "****************************************************************"
cd ../test
./run4CoreTests.sh

cd ../deploy
./cleanup-4core.sh

cd ../test
./cleanup-4core.sh

cd ..

cd deploy
./install_4corenativeha.sh $TARGET_NAMESPACE $ENV_NAME

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run4CoreTests.sh

cd ../deploy
./cleanup-4core.sh
