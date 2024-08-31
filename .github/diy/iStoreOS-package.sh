#!/bin/bash
function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
git clone --depth 1 -b main https://github.com/linkease/istore-packages istore-packages && mv -n istore-packages/* ./;rm -rf istore-packages
git clone --depth 1 -b dev https://github.com/jjm2473/luci-app-diskman luci-app-diskman && mv -n luci-app-diskman/* ./;rm -rf luci-app-diskman
git clone --depth 1 -b dev4 https://github.com/jjm2473/OpenAppFilter oaf && mv -n oaf/* ./;rm -rf oaf 
git clone --depth 1 -b master https://github.com/linkease/nas-packages nas-packages && mv -n nas-packages/* ./;rm -rf nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci nas-packages-luci && mv -n nas-packages-luci/* ./;rm -rf nas-packages-luci
git clone --depth 1 -b main https://github.com/jjm2473/openwrt-apps openwrt-apps && mv -n openwrt-apps/* ./;rm -rf openwrt-apps

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
