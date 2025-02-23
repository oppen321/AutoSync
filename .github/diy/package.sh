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
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci && mv -n luci/applications/{luci-app-cpufreq,luci-app-diskman,luci-app-netdata,luci-app-ramfree,luci-app-socat,luci-app-syncdial,luci-app-usb-printer,luci-app-openvpn-server} ./ && rm -rf luci
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/net/socat ./ && rm -rf packages
git clone --depth 1 -b main https://github.com/linkease/openwrt-app-actions && mv -n openwrt-app-actions/applications/luci-app-ap-modem ./ && rm -rf openwrt-app-actions
git clone --depth 1 -b master https://github.com/coolsnowwolf/lede && mv -n lede/package/lean/ipv6-helper ./ && rm -rf lede
git clone --depth 1 -b openwrt-23.05 https://github.com/coolsnowwolf/luci && mv -n luci/applications/luci-app-zerotier ./ && rm -rf luci
git clone --depth 1 -b openwrt-23.05 https://github.com/coolsnowwolf/luci && mv -n luci/themes/luci-theme-design ./ && rm -rf luci
git clone --depth 1 -b master https://github.com/coolsnowwolf/packages && mv -n packages/net/zerotier ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/admin/netdata ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages && mv -n packages/utils/parted ./ && rm -rf packages
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/immortalwrt && mv -n immortalwrt/package/emortal/cpufreq ./ && rm -rf immortalwrt
git clone --depth 1 -b main https://github.com/sbwml/openwrt_pkgs && mv -n openwrt_pkgs/{luci-app-ota,fw_download_tool,ddns-scripts-aliyun,bash-completion,luci-app-netspeedtest,speedtest-cli} ./ && rm -rf openwrt_pkgs
git clone --depth 1 -b main https://github.com/Lienol/openwrt-package && mv -n openwrt-package/luci-app-guest-wifi ./ && rm -rf openwrt-package
git clone --depth 1 -b istoreos-24.10 https://github.com/istoreos/istoreos && mv -n istoreos/package/istoreos-files ./ && rm -rf istoreos
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/{luci-app-quickstart,luci-app-floatip,luci-app-linkease} ./ && rm -rf nas-packages-luci
git clone --depth 1 -b master https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/{quickstart,floatip,linkease,linkmount} ./ && rm -rf nas-packages
git clone --depth 1 -b master https://github.com/QiuSimons/luci-app-daed && mv -n luci-app-daed/{luci-app-daed,daed} ./ && rm -rf luci-app-daed
git clone --depth 1 -b main https://github.com/linkease/istore

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
