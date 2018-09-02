#encoding=utf-8
'''
# step1: 生成po文件 
xgettext -L python -o zh_CN.po demo.py
# step2: 编辑po文件
# step3: 编译PO文件成MO文件
msgfmt -o ~/locale/zh_CN/LC_MESSAGES/demo.mo zh_CN.po
# step4: 输出
python demo.py
'''

import gettext

# demo对应mo文件名，locale为locale目录地址，zh_CN为locale目录下目录名
zh = gettext.translation("demo", "locale", languages=["zh_CN"])
# 激活 _()
zh.install(True)
print _("hello world")
