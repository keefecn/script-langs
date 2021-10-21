# -*- coding: utf-8 -*-
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import os
import json

from setuptools import find_packages, setup
from setuptools import Command


BASE_DIR = os.path.abspath(os.path.dirname(__file__))
INSTALL_PACKAGES = open(os.path.join(BASE_DIR, "requirements.txt")).read().splitlines()

with open(os.path.join(BASE_DIR, "README.md"), encoding="utf-8") as f:
    README = f.read()


class InstallCommand(Command):  # 自定义命令
    description = "Installs the foo."
    user_options = [
        ('foo=', None, 'Specify the foo to bar.'),
    ]
    def initialize_options(self):
        self.foo = None
    def finalize_options(self):
        assert self.foo in (None, 'myFoo', 'myFoo2'), 'Invalid foo!'
    def run(self):
        install_all_the_things()

setup(
    name="python-demo",
    version="0.0.3",
    url="https://github.com/dennycn/script-langs",
    project_urls={
        "Documentation": "https://github.com/dennycn/script-langs",
        "Code": "https://github.com/dennycn/script-langs",
        "Issue tracker": "https://github.com/dennycn/script-langs/issues",
    },
    license="BSD-3-Clause",
    description=("python scripts demos"),
    long_description=README,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    scripts=[],
    install_requires=[
        "flask",
    ],
    extras_require={
    },
    tests_require=[
        "pytest",
        "pytest-cov",
        "pytest-sugar"
    ],
    test_suite="tests",
    author="wuqifu",
    author_email="wuqifu@gmail.com",
    keywords=["python-demo", ],
    classifiers=[
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.5",
        "Programming Language :: Python :: 3.6",
    ],
    python_requires=">=3",
    entry_points={"console_scripts": []},
    cmdclass={  # 自定义命令
        'install': InstallCommand,
    }
)
