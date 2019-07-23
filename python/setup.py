# -*- coding: utf-8 -*-
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import json
import os


from setuptools import find_packages, setup

BASE_DIR = os.path.abspath(os.path.dirname(__file__))



setup(
    version='0.0.2',
    name='python-demo',
    description=('python scripts demos'),
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    scripts=[],
    install_requires=[
        'flask',
    ],
    extras_require={
    },
    author='wuqifu',
    author_email='wuqifu@gmail.com',
    url='https://github.com/dennycn/script-lang/',
    classifiers=[
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
    ],
)
