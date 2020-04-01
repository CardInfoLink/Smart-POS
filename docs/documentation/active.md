**激活POS机**  
激活环节分为三步，分别是：激活，终端参数下载，终端密钥下载，三步都成功，表示激活成功，激活成功之后才能正常使用后面的交易流程。

**激活**  

* a、新激活接口（推荐）

根据用户反馈，为了简化激活流程，我们新增了激活码的方式激活，当你拿到 POS 机器之后，我们会为这个商户发放激活码，一个激活码可以激活一台 POS 机。
成功激活后，接口会返回商户号，终端号等信息，后续参数下载需要用到。

> 注意:一台终端能且仅能成功激活一次,无法重复进行激活操作。若有多次激活的需求(如debug阶段),请联系讯联客服。

```
    //authCode 激活码（建议用扫码的方式得到激活码，避免让用户手输）
    CILSDK.activeWithCode(authCode, new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse cilResponse) {
            if (cilResponse.getStatus() == 0) {
            //激活成功
            } else {
            //激活失败，失败原因见 cilResponse.getMessage()
            }
        }

        @Override
        public void onError(Parcelable cilRequest, Exception e) {
            //激活出错
        }
    });
```


* b、旧激活接口

第一次使用智能 POS 终端的时候,需要使用讯联下发的商户号 `merCode` 和终端号 `termCode` 激活


> 注意:一台终端能且仅能成功激活一次,无法重复进行激活操作。若有多次激活的需求(如debug阶段),请联系讯联客服。推荐APP本身能够保持设备是否已经激活标志

```
    //merCode  讯联下发的商户号
    //termCode 讯联下发的终端号
    CILSDK.active(merCode, termCode, new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse cilResponse) {
            
            if (cilResponse.getStatus() == 0) {
                //激活成功
            } else {
                //激活失败
            }
        }

        @Override
        public void onError(Parcelable p, Exception e) {
            //激活出错
        }
    });
```


**终端参数下载**

激活成功之后,你的应用还需要下载一些交易时使用的参数,比如`交易地址和端口`、`交易超时时间`、`终端支持的功能`、`TPDU` 等,
在你拿到 POS 终端之前,这些参数都会在讯联后台已经配置好,全部参数见 `CILResponse.Info` 返回值。下载成功之后 SKD 会
以json字符串的形式保存这些参数到 `SharedPreference` (请不要擅自改动这些参数值,以免导致交易失败) 。当然,在 `onResult`
中也会返回,你也可以自己选择性保存一些参数。另外, SDK 保存在 SharedPreference 里的值会提供接口 `CILSDK.getSystemParams()` 获取。

> 注意：正常情况下，此方法只需执行成功一次，但是后台参数配置可能会有改动，APP本身需要调用预留功能调用此方法

```
    //merCode  讯联下发的商户号 激活成功之后可以确定商户号
    //termCode 讯联下发的终端号 激活成功之后可以确定终端号
    CILSDK.downloadParams(merCode, termCode, new com.cardinfolink.pos.listener.Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse response) {
            if (0 == response.getStatus()) {
                //参数下载成功,具体返回的参数见 response.Info
            } else {
                //参数下载错误
            }
        }

        @Override
        public void onError(Parcelable p, Exception e) {
                //下载出错
        }
    });
```

**终端密钥下载**

终端密钥下载只需要成功执行一次就可以,成功下载的密钥会被转载到POS硬件模块里面,后面就不需要再次调用了,建议你的应用可以在成功下载密钥之后持久化一个标志位,
下次进入应用就不再去下载密钥了。整个过程可能会需要1~2分钟左右(依赖当前的网络状况),会经历以下步骤:

> 请求讯联网关 RSA -> 装载 RSA -> 请求主密钥 -> 装载主密钥 -> 启用主密钥 -> 请求工作密钥(签到) -> 装载工作密钥 -> 下载 AID -> 装载 AID -> 下载 IC 公钥 -> 装载 IC 公钥。
建议APP本身存储设备是否已经初始化方法标志。

>注意：此方法一般只需要安装后成功调用一次即可。但银行交互密钥有可能会更新，APP本身需要调用预留功能调用此方法

```
    CILSDK.downloadParamsWithProgress(new ProgressCallback<CILResponse>() {
        @Override
        public void onProgressUpdate(int progress) {
            //progress下载密钥的进度
        }

        @Override
        public void onResult(CILResponse response) {
            
            if (0 == response.getStatus())
                //密钥下载成功。在这里可以持久化一个标志位
        }

        @Override
        public void onError(Parcelable p, Exception e) {
            //下载密钥出错
        }
    });
```