## install
python setup.py sdist

## pypi
### 配置文件 ~/.pypirc
``` ~/.pypirc
[distutils]
index-servers = localhost pypi
 
[localhost]
repository: http://localhost:8080
username: keefe
password: 123456

[pypi]
repository: https://upload.pypi.org/legacy/
username: keefe
password: 
```

### 上传到pypi
```
# 上传到pypi官服 https://upload.pypi.org/legacy/
python setup.py sdist upload 

# 上传到私服
python setup.py sdist upload -r localhost

```