#! /bin/bash
cd deploy
./install_1core.sh
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
./install_1corenativeha.sh

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run1CoreTests.sh

cd ../deploy
./cleanup-1core.sh
