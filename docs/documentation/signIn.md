
**签到**

签到其实也就是更新工作密钥的一个过程 (`下载工作密钥+装载工作密钥` ),讯联网关平台要求应用需要每天签到一次。

```
    CILSDK.signIn(new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse cilResponse) {
            //签到成功
        }

        @Override
        public void onError(Parcelable cilRequest, Exception e) {
            //签到出错
        }
    });
```