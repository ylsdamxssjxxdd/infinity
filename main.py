import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import bridge # 与qml交互的类

if __name__ == '__main__':
    app = QGuiApplication(sys.argv) # 初始化事件
    engine = QQmlApplicationEngine() # 初始化引擎
    qml_file = Path(__file__).parent / 'main.qml' # 获取主界面文本
    engine.load(qml_file) # 加载主界面
    sys.exit(app.exec()) # 进入事件循环
