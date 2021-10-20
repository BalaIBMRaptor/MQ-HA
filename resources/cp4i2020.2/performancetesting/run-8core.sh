#! /bin/bash
cd deploy
./install_8core.sh
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
./install_8corenativeha.sh

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run8CoreTests.sh

cd ../deploy
./cleanup-8core.sh
