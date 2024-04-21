from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtQml import QmlElement
from PySide6.QtWidgets import QApplication
# 导入将资源文件编译成的py文件，每次有资源更新需要手动执行 pyside6-rcc style.qrc -o style_rc.py
import res.style_rc
# 定义在qml中与python连接的接口的名称
QML_IMPORT_NAME = "io.qt.textproperties"
QML_IMPORT_MAJOR_VERSION = 1

import openai
import threading
import json


# 可以在qml中使用的类，继承QObject
@QmlElement
class Bridge(QObject):
    textChanged = Signal(str)

    def __init__(self):
        super().__init__()
        self.client = openai.OpenAI(
            base_url="http://localhost:8080/v1",
            api_key="sk-no-key-required"
        )

    # 访问模型
    @Slot(list)
    def Response(self, inputs):
        # 新开一个线程运行
        threading.Thread(target=self.stream_Response, args=(inputs,), daemon=True).start()
        
    def stream_Response(self, messages):
        stream = self.client.chat.completions.create(
            model='gpt-3.5-turbo',
            messages=messages,
            stream=True,
        )

        response_text = ""

        # 获取流式输出内容
        for chunk in stream:
            stream_response_text = chunk.choices[0].delta.content
            if(stream_response_text != None):
                self.textChanged.emit(stream_response_text)  # 发送给qml

    # 复制内容到剪切板
    @Slot(str)
    def copyToClipboard(self,text):
        QApplication.clipboard().setText(text)