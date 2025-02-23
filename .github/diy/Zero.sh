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
git clone --depth 1 https://github.com/sbwml/openwrt_helloworld helloworld && mv -n helloworld/* ./;rm -rf helloworld
git clone --depth 1 https://github.com/sbwml/luci-theme-argon argon  && mv -n argon/* ./;rm -rf argon
git clone --depth=1 https://github.com/sirpdboy/luci-app-netwizard
git clone --depth=1 https://github.com/oppen321/luci-app-gpsysupgrade
git clone --depth=1 -b openwrt-24.10 https://github.com/sbwml/default-settings
git clone --depth=1 https://github.com/sbwml/OpenAppFilter
git clone --depth=1 https://github.com/sirpdboy/luci-app-partexp
git clone --depth=1 https://github.com/sbwml/luci-app-webdav
git clone --depth=1 https://github.com/sirpdboy/luci-app-lucky
git clone --depth=1 https://github.com/siropboy/luci-app-bypass
git clone --depth=1 https://github.com/muink/openwrt-fchomo

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
