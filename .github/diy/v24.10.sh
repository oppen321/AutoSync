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

git clone --depth 1 -b js https://github.com/sirpdboy/luci-theme-kucat
git clone --depth 1 https://github.com/sirpdboy/luci-app-kucat-config
git clone --depth 1 https://github.com/sirpdboy/luci-app-partexp
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-lucky
git clone --depth 1 https://github.com/sirpdboy/luci-app-netwizard
git clone --depth 1 -b master https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/destan19/OpenAppFilter
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/sirpdboy/luci-app-parentcontrol
git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset
git clone --depth 1 https://github.com/lisaac/luci-app-diskman
git clone --depth 1 https://github.com/sbwml/luci-app-mentohust
git clone --depth 1 https://github.com/pymumu/luci-app-smartdns
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns
git clone --depth 1 https://github.com/kenzok8/openwrt-packages && mv -n openwrt-packages/{adguardhome,luci-app-adguardhome} ./ && rm -rf openwrt-packages
git clone --depth 1 -b main https://github.com/sbwml/luci-app-alist && mv -n luci-app-alist/{luci-app-alist,alist} ./ && rm -rf luci-app-alist
git clone --depth 1 -b v5 https://github.com/sbwml/luci-app-mosdns && mv -n luci-app-mosdns/{luci-app-mosdns,mosdns,v2dat} ./ && rm -rf luci-app-mosdns
git clone --depth 1 -b main https://github.com/sirpdboy/sirpdboy-package && mv -n sirpdboy-package/luci-app-wolplus ./ && rm -rf sirpdboy-package
git clone --depth 1 https://github.com/sbwml/openwrt_pkgs && mv -n openwrt_pkgs/{luci-app-netspeedtest,bash-completion,speedtest-cli} ./ && rm -rf openwrt_pkgs
git clone --depth 1 https://github.com/immortalwrt/luci && mv -n luci/applications/{luci-app-netdata,luci-app-cpufreq,luci-app-ramfree,luci-app-socat,luci-app-usb-printer,luci-app-zerotier} ./ && rm -rf luci
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/net/{socat,zerotier} ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/immortalwrt && mv -n immortalwrt/package/emortal/cpufreq ./ && rm -rf immortalwrt

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
