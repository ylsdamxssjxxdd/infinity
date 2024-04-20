# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial

import sys
import os

from pathlib import Path

from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QmlElement

# 导入将资源文件编译成的py文件，每次有资源更新需要手动执行 pyside6-rcc style.qrc -o style_rc.py
import res.style_rc

# 定义在qml中与python连接的接口的名称
# To be used on the @QmlElement decorator
QML_IMPORT_NAME = "io.qt.textproperties"
QML_IMPORT_MAJOR_VERSION = 1

# 定义可以在qml声明的元素
@QmlElement
class Bridge(QObject):
    # 在python中的qml槽函数，并且返回qml一个值
    @Slot(str, result=str)
    def getColor(self, s):
        if s.lower() == "red":
            return "#ef9a9a"
        elif s.lower() == "green":
            return "#a5d6a7"
        elif s.lower() == "blue":
            return "#90caf9"
        else:
            return "white"
    # 在python中的qml槽函数，并且返回qml一个值
    @Slot(float, result=int)
    def getSize(self, s):
        size = int(s * 34)
        if size <= 0:
            return 1
        else:
            return size
    # 在python中的qml槽函数，并且返回qml一个值
    @Slot(str, result=bool)
    def getItalic(self, s):
        if s.lower() == "italic":
            return True
        else:
            return False
    # 在python中的qml槽函数，并且返回qml一个值
    @Slot(str, result=bool)
    def getBold(self, s):
        if s.lower() == "bold":
            return True
        else:
            return False
    # 在python中的qml槽函数，并且返回qml一个值
    @Slot(str, result=bool)
    def getUnderline(self, s):
        if s.lower() == "underline":
            return True
        else:
            return False


if __name__ == '__main__':
    app = QGuiApplication(sys.argv) # 初始化事件
    engine = QQmlApplicationEngine() # 初始化引擎
    qml_file = Path(__file__).parent / 'main.qml' # 获取主界面文本
    engine.load(qml_file) # 加载主界面
    sys.exit(app.exec()) # 进入事件循环
