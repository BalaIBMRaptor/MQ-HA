#! /bin/bash
cd deploy
./install_4core.sh
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
./install_4corenativeha.sh

echo "********************NativeHA************************************"
echo "****************************************************************"
cd ../test
./run4CoreTests.sh

cd ../deploy
./cleanup-4core.sh
