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
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci && mv -n luci/applications/{luci-app-cpufreq,luci-app-diskman,luci-app-netdata,luci-app-ramfree,luci-app-socat,luci-app-syncdial,luci-app-airplay2,luci-app-usb-printer,luci-app-openvpn-server} ./ && rm -rf luci
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/net/socat ./ && rm -rf packages
git clone --depth 1 -b openwrt-23.05 https://github.com/coolsnowwolf/luci && mv -n luci/applications/luci-app-zerotier ./ && rm -rf luci
git clone --depth 1 -b master https://github.com/coolsnowwolf/packages && mv -n packages/net/zerotier ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/admin/netdata ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/utils/parted ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/immortalwrt && mv -n immortalwrt/package/emortal/cpufreq ./ && rm -rf immortalwrt
git clone --depth 1 -b main https://github.com/sbwml/openwrt_pkgs && mv -n openwrt_pkgs/{luci-app-ota,fw_download_tool,ddns-scripts-aliyun,bash-completion,luci-app-netspeedtest,speedtest-cli} ./ && rm -rf openwrt_pkgs
git clone --depth 1 -b main https://github.com/siropboy/luci-app-bypass && mv -n luci-app-bypass ./ && rm -rf luci-app-bypass

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
