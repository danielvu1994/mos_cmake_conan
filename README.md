#1. Set up my remote artifactory for uploaded package my_print/0.0.1@danie/sample, mos__utils/0.0.1@daniel/sample
conan remote add daniel_conan_server https://danielvu1994.jfrog.io/artifactory/api/conan/default-conan

conan user -p AKCp8mZTDwoPMupqcW86hqJns1CRFuwJeJDmg3xzPwsZLA25FdpjfvcKwT8HzADNvu8SozJBU -r daniel_conan_server vulinhdam1994@gmail.com

#Adding conan revison to conan conf
vi ~/.conan/conan.conf

[general]
revisions_enable=1

# 2. Or install in local conan only those libs
# You can skipp this step if config with step 1
cd libs/my_print; conan create . daniel/sample
cd libs/mos_utils; conan create . daniel/sample
cd ../..

#3.Install mos_client as conan package
cd apps/mos_client

conan create . test/demo -b missing

#Or run with relative path conan profile for cross compiler
conan create . test/demo --profile ../../profiles/linux_aarch64 -b missing

#4. Build mos_client app with specific build_dir
cd apps/mos_client_ld
conan install --install-folder build
cd build
cmake install .. -DCMAKE_INSTALL_PATH=<BUILD_PATH> -DCMAKE_INSTALL_PREFIX=<BUILD_PATH>
cmake --build . --config Release
cmake --install . --config Release

#or just run
sh build.sh

#cross compiler 
sh build.sh ./profiles/linux_aarch64
