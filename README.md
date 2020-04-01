## 说明  
该README目标人群是项目维护人员，只涉及如何维护更新该项目

## 如何更新该文档
项目主页面文档使用 [MkDocs](http://www.mkdocs.org/) 生成
### 环境搭建  
 1. python环境（参考廖雪峰网站）  
	* 通过以下命令检查是否具备python环境
```
$ python --version`  
 Python 2.7.2
```
 2. pip环境（pip属于python包里面的工具） 
	* 通过以下命令检查是否具备pip 
```
$pip --version`  
 pip 1.5.2
```

 3. 使用pip安装mkdocs  
	`$ pip install mkdocs`

>具体环境搭建参见[http://www.mkdocs.org/](http://www.mkdocs.org/ "mkdocs使用")
  
### fork项目到自己的github  
项目地址  
'https://github.com/CardInfoLink/Smart-POS'  
### 修改项目  
遵循markdown的语法规则，修改和更新doc文件夹中的文件，修改后可通过命令  
```
$ mkdocs serve
INFO    -  Building documentation...
INFO    -  Cleaning site directory
[I 160402 15:50:43 server:271] Serving on http://127.0.0.1:8000
[I 160402 15:50:43 handlers:58] Start watching changes
[I 160402 15:50:43 handlers:60] Start detecting changes
```  
在浏览器中输入'http://127.0.0.1:8000'预览修改后的效果。   
### 部署文档  
执行部署发布命令  
`mkdocs gh-deploy`这个命令实际上是执行了三个操作 
```
	* clean site directory  
	
	* build documentation to directory D:\repertory\mkdocstest\site  
	
	* Copying 'D:\repertory\mkdocstest\site' to 'gh-pages' branch and pushing to Github.
```

### 提交自己的修改  
1. 将修改内容提交到自己的git仓库。  
`git add . \git commit -m\git push origin master`    
2. 提交到公司的github账号。
