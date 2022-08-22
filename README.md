# 宝塔面板 docker 镜像生成脚本

### 登录信息
```
SSH: 8022
面板端口: 8888
面板访问路径: /btpanel
面板用户名: btadmin
面板密码: btpassword
SSH密码: btpassword
```

### 编译面板
```
# 默认 tag 名字为 local/btpanel
make build
```

### 拷贝面板 www 目录, 到当前目录下的 ./btpanel 文件夹
```
make copy
```

### 运行面板
```
# Host 模式运行, 所有监听端口映射到母机, 并挂载外部的 www 目录
docker run -d --restart unless-stopped \
    --name btpanel \
    --net host \
    -v /docker/btpanel/data:/www \
    local/btpanel

### 正常的端口映射模式运行, 并挂载外部的 www 目录
docker run -d --restart unless-stopped \
    --name btpanel \
    -p 80:80 \
    -p 443:443 \
    -p 3306:3306 \
    -p 8888:8888 \
    -v /docker/btpanel/data:/www \
    local/btpanel
```

### 修改面板参数
```bash
# 修改面板密码
PANEL_USER=btadmin
PANEL_PASSWORD=btpassowrd
docker exec btpanel bash -c "echo ${PANEL_USER} | bt 6"
docker exec btpanel bash -c "echo ${PANEL_PASSWORD} | bt 5"

# 修改面板登录路径
PANEL_PATH=8888
docker exec btpanel bash -c "echo ${PANEL_PATH} > /www/server/panel/data/admin_path.pl"

# 修改面板端口号
PANEL_PORT=8888
docker exec btpanel bash -c "echo ${PANEL_PORT} > /www/server/panel/data/port.pl"
```

### nginx 静态编译参数, 并添加 stream 支持
```markdown
ARG: --with-stream 
SCRIPT: 
    CCFLAGS="-I/usr/include -static -static-libgcc"
    LDFLAGS="-L/usr/lib64 -static"
```