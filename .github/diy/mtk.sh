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

git clone --depth 1 https://github.com/sirpdboy/luci-app-taskplan
git clone --depth 1 https://github.com/sirpdboy/luci-app-timecontrol
git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-parentcontrol
git clone --depth 1 -b v5 https://github.com/sbwml/luci-app-mosdns && mv -n luci-app-mosdns/{luci-app-mosdns,mosdns,v2dat} ./ && rm -rf luci-app-mosdns

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
