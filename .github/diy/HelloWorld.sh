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

git clone --depth 1 -b v5 https://github.com/sbwml/openwrt_helloworld && mv -n openwrt_helloworld/{chinadns-ng,dns2socks,dns2tcp,daed,geoview,hysteria,ipt2socks,lua-neturl,luci-app-homeproxy,luci-app-daed,luci-app-nikki,luci-app-openclash,luci-app-passwall,luci-app-passwall2,luci-app-ssr-plus,microsocks,naiveproxy,nikki,pdnsd,redsocks2,shadow-tls,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,sing-box,tcping,trojan-plus,trojan,tuic-client,v2ray-core,v2ray-geodata,v2ray-plugin,xray-core,xray-plugin} ./ && rm -rf openwrt_helloworld

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
