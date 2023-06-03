## 自用镜像，本人不保证能在生产环境里稳定使用。

本镜像参考[这里](https://jasper1024.com/jasper/5c96c334/)修改制作

docker-compose.yml 用法示例：

server端：

```yaml
version: "3.9"

services:
  udp2raw:
    image: netdoge/udp2raw:20230206_hw_aes
    container_name: udp2raw
    hostname: udp2raw
    restart: always
    network_mode: bridge
    ports:
      - "3000:3000"
    cap_add:
      - NET_ADMIN
    volumes:
      - ./config.conf:/config.conf
```

client端：

```yaml
version: "3.9"

services:
  udp2raw:
    image: netdoge/udp2raw:20230206_hw_aes
    container_name: udp2raw
    hostname: udp2raw
    restart: always
    network_mode: host
    volumes:
      - ./config.conf:/config.conf
```

config.conf 文件示例：

server 端：

```
-s
# 你可以像这样添加注释
# 注意，只有整行注释才能在配置文件里使用
# 注释必须独占一行
-a
-l 0.0.0.0:3000
-r 127.0.0.1:3001
# 你的密码 password
-k password
--cipher-mode aes128cbc
--auth-mode crc32
--raw-mode faketcp
--seq-mode 3
--lower-level auto
```

client 端：

```
-c
# 你可以像这样添加注释
# 注意，只有整行注释才能在配置文件里使用
# 注释必须独占一行
-a
-l 0.0.0.0:3000
-r 123.123.123.123:3000
# 你的密码 password
-k password
--cipher-mode aes128cbc
--auth-mode crc32
--raw-mode faketcp
--seq-mode 3
--lower-level auto
```

更多配置参见：[这里](https://github.com/wangyu-/udp2raw/blob/unified/doc/README.zh-cn.md)
