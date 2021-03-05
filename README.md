# myopenwrt dragino2

#### 介绍
openwrt newifi dragino2 x86_64
````
screen -S myopenwrt
bash compile.sh
````
触发自动编译
````
git tag 2021-03-5
git push origin main --tags 2021-03-5
````
删除本地tag
````
git tag -d 2021-03-5
````
查看远程所有tag
````
git ls-remote --tags origin
````
删除远程tag
````
git push origin :refs/tags/tag-name
````
