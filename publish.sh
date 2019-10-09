#!/usr/bin/env bash
username(){
    git config --get user.name
}
res=`username`
echo "username="${res}

mkdocs build --clean
mkdocs build
javadoc -private -d site/documentation/sdkapi/javadoc -sourcepath ../cil_pos_sdk/src/main/java @../cil_pos_sdk/src/main/java/package.txt
gh-pages -d site -r https://github.com/CardInfoLink/Smart-POS.git -m ${res}" 更新了在线文档"