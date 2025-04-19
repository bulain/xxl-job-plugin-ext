# 简介

xxl-job-plugin-ext 是xxl-job适配MSSQL,ORACLE,PGSQL数据源插件。

# 快速使用

### 1.下载xxl-job-plugin-ext插件jar:

可以自行打包：

```sh
git clone https://github.com/bulain/xxl-job-plugin-ext.git
cd xxl-job-plugin-ext/
mvn clean package
echo "打包后的文件位于： ./target/"
ls -al ./target/
```

### 2下载xxl-job

从Github下载xxl-job源码打包:

```sh
git clone https://github.com/xuxueli/xxl-job.git
```

调整打包方式为ZIP，修改文件 ./xxl-job/xxl-job-admin/pom.xml

```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <version>${spring-boot.version}</version>
    <configuration>
        <layout>ZIP</layout>
    </configuration>
    <executions>
        <execution>
            <goals>
                <goal>repackage</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

执行编译打包

```sh
cd xxl-job/
mvn -Dmaven.test.skip=true clean package -U 
echo "打包后的文件位于： ./xxl-job-admin/target/"
ls -al ./xxl-job-admin/target/
```

### 3.插件配置

#### 3.1配置

在xxl-job安装目录下新建plugins目录，并将xxl-job-plugin-ext插件jar放入此目录,目录结构如下:

```
xxl-job/
├── conf/
│   ├── application.properties
│   └── logback.xml
├── plugins/
│   └── xxl-job-plugin-ext-2.5.0.jar
└── xxl-job-admin-2.5.0.jar
```

#### 3.2配置数据库链接信息

编辑conf/application.properties配置文件

```properties
### mybatis
mybatis.mapper-locations=classpath:/mybatis-mapper/pgsql/*Mapper.xml

  ### xxl-job, datasource
spring.datasource.url=jdbc:postgresql://127.0.0.1:5432/xxl_job?tcpKeepAlive=true&reWriteBatchedInserts=true&ApplicationName=xxl_job
spring.datasource.username=xxl_job
spring.datasource.password=******
spring.datasource.driver-class-name=org.postgresql.Driver
```

#### 3.3导入tables_xxl_job.pgsql.sql到PostgreSQL数据库

新建数据库（假如数据库名为xxl_job）：
数据库初始化文件路径：./doc/db/tables_xxl_job.pgsql.sql

```sql
create database xxl_job;
```

执行导入命令

```sql
psql -U postgres -d xxl_job -f ./tables_xxl_job.pgsql.sql
```

#### 3.4启动xxl-job-admin服务

单机模式启动：

```shell
cd xxl-job/
java -Xmx2048m -Dloader.path=./plugins/ -jar xxl-job-admin-2.5.0.jar --spring.config.location=file:./conf/application.properties --logging.config=file:./conf/logback.xml
```

# 4.许可证
GNU GENERAL PUBLIC LICENSE