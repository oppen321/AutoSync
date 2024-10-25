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
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
git clone --depth 1 https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash
git clone --depth 1 https://github.com/immortalwrt/homeproxy luci-app-homeproxy
git clone --depth 1 https://github.com/morytyann/OpenWrt-mihomo OpenWrt-mihomo && mv -n OpenWrt-mihomo/*mihomo ./ ; rm -rf OpenWrt-mihomo
git clone --depth 1 https://github.com/fw876/helloworld && mv -n helloworld/{luci-app-ssr-plus,shadow-tls,redsocks2,lua-neturl} ./ ; rm -rf helloworld
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages  && mv -n openwrt-passwall-packages/* ./ ; rm -rf openwrt-passwall-packages
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/sirpdboy/luci-app-partexp
git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore
git clone --depth 1 -b v5 https://github.com/sbwml/luci-app-mosdns openwrt-mos && mv -n openwrt-mos/luci-app-mosdns ./; rm -rf openwrt-mos
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns openwrt-mos1 && mv -n openwrt-mos1/{mosdns,v2dat} ./; rm -rf openwrt-mos1
git clone --depth 1 https://github.com/sirpdboy/luci-app-netwizard
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset
git clone --depth=1 https://github.com/oppen321/luci-app-adguardhome
git clone --depth 1 https://github.com/yaof2/luci-app-ikoolproxy
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go ddns-go && mv -n ddns-go/{luci-app-ddns-go,ddns-go} ./ ; rm -rf ddns-go
git clone --depth 1 https://github.com/sbwml/luci-app-alist alist && mv -n alist/{luci-app-alist,alist} ./ ; rm -rf alist
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush
git clone --depth 1 https://github.com/destan19/OpenAppFilter OpenAppFilter && mv -n OpenAppFilter/{luci-app-oaf,oaf,open-app-filter} ./ ; rm -rf OpenAppFilter
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata
git clone --depth=1 https://github.com/Lienol/openwrt-package && mv -n  openwrt-package/luci-app-filebrowser openwrt-package/luci-app-ssr-mudb-server ./ ; rm -rf openwrt-package
git clone --depth=1 https://github.com/sirpdboy/sirpdboy-package && mv -n  sirpdboy-package/luci-app-socat ./ ; rm -rf sirpdboy-package
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom
git clone --depth=1 https://github.com/pymumu/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite
git clone --depth=1 https://github.com/oppen321/luci-app-gpsysupgrade
git clone --depth=1 https://github.com/kiddin9/luci-theme-edge
git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus
git clone --depth=1 https://github.com/kiddin9/kwrt-packages kwrt && mv -n kwrt/{wrtbwmon} ./ ; rm -rf kwrt
sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
