FROM : 指定基础镜像，要在哪个镜像建立，格式为 FROM <image> 或FROM <image>:<tag> ，第一条指令必须为 FROM 指令。

MAINTAINER：指定维护者信息，格式为 MAINTAINER <name>

RUN：在镜像中要执行的命令，格式为 RUN <command> 或 RUN ["executable", "param1", "param2"]
前者将在 shell 终端中运行命令，即 /bin/bash -c ；后者则使用 exec 执行。指定使用其它终端可以通过第二种方式实现，例如 RUN [“/bin/bash”, “-c”,”echo hello”] 。

EXPOSE：指定容器要打开的端口，格式为 EXPOSE <port> [<port>...]
告诉 Docker 服务端容器暴露的端口号，供互联系统使用。在启动容器时需要通过 -P，Docker 主机会自动分配一个端口转发到指定的端口。

首先将自己的项目打包成jar，并在自己本地先用java -jar xxx.jar启动下，看是否可以启动。
随后将自己的jar包同级目录创建一个Dockerfile文件，并用notepad打开
文件无后缀。
FROM kdvolder/jdk8
VOLUME /tmp  #挂载的docker卷
#xxx.jar 自己的jar包  xxxx.jar 自定义的jar包名
ADD xxx.jar xxxx.jar
#RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/xxxx.jar"] #上面自定义的jar包名称
EXPOSE 项目端口号

将自己的jar包和写好的Dockerfile通过xftp上传到服务器/home路径下。
cd 切换到/home路径，执行打包命令
#最后的点不能少
#-t 给新构建的镜像取名
docker build -f Dockerfile -t 镜像名称:版本名 .
#如果不指定镜像名和版本名
#使用下面的命令指定打包完的镜像
docker tag 镜像id eureka-server:latest

启动镜像
docker run -d -p 主机端口号:项目端口号 镜像id

查看镜像日志
docker logs 容器id
