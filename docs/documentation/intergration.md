
为了方便快速接入，提供了demo供接入参考
[demo下载](http://hd2-prod-smartpos.oss-cn-shanghai.aliyuncs.com/apkMgt/2020-01-07/pos-demo.zip)

1. 本 SDK 已使用 jcenter 托管，配置如下

```gradle
gradle:
    implementation 'com.cardinfolink.smart.pos:PosSDK:2.5.2'
```

or

```maven
maven:
    <dependency>
      <groupId>com.cardinfolink.smart.pos</groupId>
      <artifactId>PosSDK</artifactId>
      <version>2.5.2</version>
      <type>pom</type>
    </dependency>
```

2. 如果想使用讯联集成的结算UI和逻辑，请配置

```gradle
gradle:
    implementation 'com.cardinfolink.smart.pos:SDK-ZaiHui:1.1.1'
```
or

```maven
maven:
    <dependency>
     <groupId>com.cardinfolink.smart.pos</groupId>
     <artifactId>SDK-ZaiHui</artifactId>
     <version>1.1.1</version>
    <type>pom</type>
    </dependency>
```