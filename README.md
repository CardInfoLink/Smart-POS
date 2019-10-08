## What

项目主页面文档使用 [MkDocs](http://www.mkdocs.org/) 生成


## Usage

安装pip--[下载get-pip.py](https://bootstrap.pypa.io/get-pip.py)
```
python get-pip.py
```

``` 
    // 安装 mkdocs
    $ pip install mkdocs
    pip install mkdocs
    // 进入项目目录
    $ cd website
    
    // 运行项目
    $ mkdocs serve
    Running at: http://127.0.0.1:8000/
```

## Bulid

```
    // clean site/
    $ mkdocs build --clean
    // build site/
    $ mkdocs build
```

## Publish

```
    // install gh-pages
    $ npm install gh-pages -g
    // link gh-pages
    $ npm link gh-pages
    // publish site
    $ ./publish.sh
    
```
需要将 `site/` 发布到 Smart-POS 的 `gh-pages` 分支, 然后访问 [cardinfolink.github.io/Smart-POS/](https://cardinfolink.github.io/Smart-POS)

>[参考](http://www.mkdocs.org/)
