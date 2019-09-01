
## install
``` install
python3 -m pip install --user --upgrade setuptools wheel twine
python setup.py sdist
twine check dist/*
```

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
# 上传到pypi官服 https://upload.pypi.org/legacy/  bdist_wheel~whl包
python setup.py bdist_wheel upload 
或者
twine upload dist/*

# 上传到私服, sdist~源码包
python setup.py sdist upload -r localhost

```