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
git clone --depth 1 -b v5-lua https://github.com/sbwml/luci-app-mosdns mosdns && mv -n mosdns/luci-app-mosdns ./; rm -rf mosdns
git clone --depth 1 -b master https://github.com/kongfl888/luci-app-adguardhome adguardhome && mv -n adguardhome/luci-app-adguardhome ./; rm -rf adguardhome
git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush wechatpush && mv -n wechatpush/luci-app-wechatpush ./; rm -rf wechatpush
git clone --depth=1 -b main https://github.com/ilxp/luci-app-ikoolproxy ikoolproxy && mv -n ikoolproxy/luci-app-ikoolproxy ./; rm -rf ikoolproxy
git clone --depth=1 -b master https://github.com/esirplayground/luci-app-poweroff poweroff && mv -n poweroff/luci-app-poweroff ./; rm -rf poweroff
git clone --depth=1 -b master https://github.com/destan19/OpenAppFilter OpenAppFilter && mv -n OpenAppFilter/OpenAppFilter ./; rm -rf OpenAppFilter
git clone --depth=1 -b main https://github.com/Jason6111/luci-app-netdata netdata && mv -n netdata/luci-app-netdata ./; rm -rf netdata
git clone --depth=1 -b main https://github.com/Lienol/openwrt-package && mv -n openwrt-package/* ./ ; rm -rf openwrt-package
git clone --depth 1 -b master https://github.com/fw876/helloworld && mv -n helloworld/{luci-app-ssr-plus,shadow-tls} ./ ; rm -rf helloworld
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall-packages && mv -n openwrt-passwall-packages/* ./ ; rm -rf {.github} && rm -rf openwrt-passwall-packages


sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +
exit 0
