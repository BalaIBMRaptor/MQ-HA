#! /bin/bash
cd deploy
./install_2core.sh
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
./install_2corenativeha.sh

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run2CoreTests.sh

cd ../deploy
./cleanup-2core.sh
