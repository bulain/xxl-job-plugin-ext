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

### 3.插件配置 - pgsql

#### 3.1配置

在xxl-job安装目录下新建plugins目录，并将xxl-job-plugin-ext插件和驱动jar放入此目录,目录结构如下:

```
xxl-job/
├── conf/
│   ├── application.properties
│   └── logback.xml
├── plugins/
│   ├── checker-qual-3.48.3.jar
│   ├── postgresql-42.7.5.jar
│   └── xxl-job-plugin-ext-2.5.0.jar
└── xxl-job-admin-2.5.0.jar
```

#### 3.2配置数据库链接信息

编辑conf/application.properties配置文件

```properties
### mybatis
mybatis.mapper-locations=classpath:/mybatis-mapper/pgsql/*Mapper.xml

### datasource-pool
spring.datasource.hikari.connection-test-query=SELECT 1

### xxl-job, datasource
spring.datasource.url=jdbc:postgresql://127.0.0.1:5432/xxl_job?tcpKeepAlive=true&reWriteBatchedInserts=true&ApplicationName=xxl_job
spring.datasource.username=xxl_job
spring.datasource.password=******
spring.datasource.driver-class-name=org.postgresql.Driver
```

#### 3.3导入tables_xxl_job.pgsql.sql到PostgreSQL数据库

新建数据库（假如数据库名为xxl_job），执行数据库初始化文件./doc/db/tables_xxl_job.pgsql.sql

#### 3.4启动xxl-job-admin服务

单机模式启动：

```shell
cd xxl-job/
java -Xmx2048m -Dloader.path=./plugins/ -jar xxl-job-admin-2.5.0.jar --spring.config.location=file:./conf/application.properties --logging.config=file:./conf/logback.xml
```


### 4.插件配置 - mssql

#### 4.1配置

在xxl-job安装目录下新建plugins目录，并将xxl-job-plugin-ext插件和驱动jar放入此目录,目录结构如下:

```
xxl-job/
├── conf/
│   ├── application.properties
│   └── logback.xml
├── plugins/
│   ├── mssql-jdbc-12.8.1.jre11.jar
│   └── xxl-job-plugin-ext-2.5.0.jar
└── xxl-job-admin-2.5.0.jar
```

#### 4.2配置数据库链接信息

编辑conf/application.properties配置文件

```properties
### mybatis
mybatis.mapper-locations=classpath:/mybatis-mapper/mssql/*Mapper.xml

### datasource-pool
spring.datasource.hikari.connection-test-query=SELECT 1

### xxl-job, datasource
spring.datasource.url=jdbc:sqlserver://127.0.0.1:1433;databaseName=xxl_job;selectMethod=cursor;integratedSecurity=false;encrypt=false;trustServerCertificate=true
spring.datasource.username=xxl_job
spring.datasource.password=******
spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver
```

#### 4.3导入tables_xxl_job.mssql.sql到MSSQL数据库

新建数据库（假如数据库名为xxl_job），执行数据库初始化文件./doc/db/tables_xxl_job.mssql.sql

#### 4.4启动xxl-job-admin服务

单机模式启动：

```shell
cd xxl-job/
java -Xmx2048m -Dloader.path=./plugins/ -jar xxl-job-admin-2.5.0.jar --spring.config.location=file:./conf/application.properties --logging.config=file:./conf/logback.xml
```

### 5.插件配置 - oracle

#### 5.1配置

在xxl-job安装目录下新建plugins目录，并将xxl-job-plugin-ext插件和驱动jar放入此目录,目录结构如下:

```
xxl-job/
├── conf/
│   ├── application.properties
│   └── logback.xml
├── plugins/
│   ├── ojdbc8-23.5.0.24.07.jar
│   └── xxl-job-plugin-ext-2.5.0.jar
└── xxl-job-admin-2.5.0.jar
```

#### 5.2配置数据库链接信息

编辑conf/application.properties配置文件

```properties
### mybatis
mybatis.mapper-locations=classpath:/mybatis-mapper/oracle/*Mapper.xml

### datasource-pool
spring.datasource.hikari.connection-test-query=SELECT 1 FROM DUAL

### xxl-job, datasource
spring.datasource.url=jdbc:oracle:thin:@127.0.0.1:1521/xe
spring.datasource.username=xxl_job
spring.datasource.password=******
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
```

#### 5.3导入tables_xxl_job.oracle.sql到Oracle数据库

新建数据库（假如数据库名为xxl_job），执行数据库初始化文件./doc/db/tables_xxl_job.oracle.sql

#### 5.4启动xxl-job-admin服务

单机模式启动：

```shell
cd xxl-job/
java -Xmx2048m -Dloader.path=./plugins/ -jar xxl-job-admin-2.5.0.jar --spring.config.location=file:./conf/application.properties --logging.config=file:./conf/logback.xml
```

# 6.许可证
GNU GENERAL PUBLIC LICENSE