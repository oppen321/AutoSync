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
git clone --depth 1 -b istoreos-24.10 https://github.com/istoreos/istoreos && mv -n istoreos/package/istoreos-files ./ && rm -rf istoreos
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/{luci-app-quickstart,luci-app-floatip,luci-app-linkease} ./ && rm -rf nas-packages-luci
git clone --depth 1 -b master https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/{quickstart,floatip,linkease,linkmount} ./ && rm -rf nas-packages
git clone --depth 1 -b master https://github.com/QiuSimons/luci-app-daed && mv -n luci-app-daed/{luci-app-daed,daed} ./ && rm -rf luci-app-daed
git clone --depth 1 -b master https://github.com/gdy666/luci-app-lucky && mv -n luci-app-lucky/{luci-app-lucky,lucky} ./ && rm -rf luci-app-lucky
git clone --depth 1 -b master https://github.com/destan19/OpenAppFilter && mv -n OpenAppFilter/{luci-app-oaf,oaf,open-app-filter} ./ && rm -rf OpenAppFilter
git clone --depth 1 -b main https://github.com/sbwml/luci-app-alist && mv -n luci-app-alist/{luci-app-alist,alist} ./ && rm -rf luci-app-alist
git clone --depth 1 -b v5 https://github.com/sbwml/luci-app-mosdns && mv -n luci-app-mosdns/{luci-app-mosdns,mosdns,v2dat} ./ && rm -rf luci-app-mosdns
git clone --depth=1 -b master https://github.com/pymumu/openwrt-smartdns
git clone --depth=1 -b master https://github.com/pymumu/luci-app-smartdns
git clone --depth 1 -b master https://github.com/sbwml/v2ray-geodata
git clone --depth 1 -b master https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 -b master https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 -b main https://github.com/linkease/istore

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
