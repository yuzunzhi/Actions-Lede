#!/bin/bash

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-design
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-openclash

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 -b main https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale
#git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan
#git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
#git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
#git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
#git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
#git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server
#git_sparse_clone openwrt-23.05 https://github.com/immortalwrt/luci applications/luci-app-eqos
# git_sparse_clone master https://github.com/syb999/openwrt-19.07.1 package/network/services/msd_lite

# 科学上网插件
git clone --depth=1 https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

#lucky
git_sparse_clone main https://github.com/sirpdboy/luci-app-lucky lucky
git_sparse_clone main https://github.com/sirpdboy/luci-app-lucky luci-app-lucky

# SmartDNS
#git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
#git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

# MosDNS
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

# Alist
#git clone --depth=1 https://github.com/sbwml/luci-app-alist package/luci-app-alist

# DDNS.to
#git_sparse_clone main https://github.com/linkease/nas-packages-luci luci/luci-app-ddnsto
#git_sparse_clone master https://github.com/linkease/nas-packages network/services/ddnsto

# iStore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci

# 在线用户
#git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
#sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
#sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
#chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# Themes
#git clone --depth=1 https://github.com/emxiong/luci-theme-argon package/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#git clone --depth=1 https://github.com/emxiong/luci-theme-design package/luci-theme-design

#if [ -d "package/luci-app-argon-config" ]; then
  # 设置Argon主题的登录页面壁纸为内建
#  sed -i "s/option online_wallpaper 'bing'/option online_wallpaper 'none'/" package/luci-app-argon-config/root/etc/config/argon
#  sed -i "s/o\.default = 'bing';/o.default = 'none';/" package/luci-app-argon-config/htdocs/luci-static/resources/view/argon-config.js
  # 设置Argon主题的登录表单模糊度
#  sed -i "s/option blur '[0-9]*'/option blur '0'/" package/luci-app-argon-config/root/etc/config/argon
#  sed -i "s/option blur_dark '[0-9]*'/option blur_dark '0'/" package/luci-app-argon-config/root/etc/config/argon
  # 设置Argon主题颜色
#  sed -i "s/option primary '#[0-9a-fA-F]\{6\}'/option primary '#ADD8E6'/" package/luci-app-argon-config/root/etc/config/argon
#  sed -i "s/option dark_primary '#[0-9a-fA-F]\{6\}'/option dark_primary '#c0c0c0'/" package/luci-app-argon-config/root/etc/config/argon

#  echo "Argon theme has been customized!"
#fi
# 更改 Argon 主题背景
#cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

#修改默认主题
#sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")

# 取消主题默认设置
#find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/luci2/bin/config_generate

# 更改默认 Shell 为 zsh
#sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
#sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# x86 型号只显示 CPU 型号
#sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
#sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改主机名
#sed -i "s/set system.@system\[-1\].hostname='LEDE'/set system.@system\[-1\].hostname='OpenWrt'/" package/base-files/luci2/bin/config_generate

# 修改版本为编译日期
#date_version=$(date +"%y.%m.%d")
#orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
#sed -i "s/${orig_version}/R${date_version} by emxiong/g" package/lean/default-settings/files/zzz-default-settings

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# 调整 V2ray服务器 到 VPN 菜单
# sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
# sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
# sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

./scripts/feeds update -a
./scripts/feeds install -a
