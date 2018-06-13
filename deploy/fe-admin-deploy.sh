# @Author: viivLgr
# @Date: 2018-06-08 16:25:44
# @Last Modified by:   viivLgr
# @Last Modified time: 2018-06-08 16:25:44
#!/bin/sh

GIT_HOME=/developer/git-repository/
DEST_PATH=/product/frontend/

#cd dir
if [ ! -n "$1" ];
    then
    echo -e "Please input a project name! You can input as follows:"
    echo -e "./fe-damin-deploy.sh admin-fe"
    exit
fi

if [ $1 = "admin-fe" ];
    then
    echo -e "--------------- Enter Project -------------------"
    cd $GIT_HOME$1
else
    echo -e "Invalid Project Name!"
    exit
fi

# clear dist
echo -e "--------------- Clear Dist -------------------"
rm -rf ./dist

# git pull
echo -e "--------------- Git Pull -------------------"
git pull

# initall
echo -e "--------------- Yarn Initall -------------------"
yarn

# run dist
echo -e "--------------- Yarn Run Dist -------------------"
yarn run dist

if [ -d "./dist" ];
    then
    echo -e  "--------------- Clean Dest -------------------"
    rm -rf $DEST_PATH/dist

    echo -e  "--------------- Copy Dest -------------------"
    cp -R ./dist $DEST_PATH/$1/

    echo -e  "--------------- Deploy Success -------------------"
else
    echo -e  "--------------- Deploy Fail -------------------"
fi

