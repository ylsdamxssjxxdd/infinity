from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtQml import QmlElement
import asyncio
import openai

# 导入将资源文件编译成的py文件，每次有资源更新需要手动执行 pyside6-rcc style.qrc -o style_rc.py
import res.style_rc
# 定义在qml中与python连接的接口的名称
QML_IMPORT_NAME = "io.qt.textproperties"
QML_IMPORT_MAJOR_VERSION = 1

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

    @Slot(str, result=str)
    def stream_Response(self, inputs):
        messages = [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": inputs}
        ]
        stream = self.client.chat.completions.create(
            model='gpt-3.5-turbo',
            messages=messages,
            stream=True,
        )

        response_text = ""

        for chunk in stream:
            stream_response_text = chunk.choices[0].delta.content
            print(stream_response_text)
            if(stream_response_text != None):
                response_text = response_text + chunk.choices[0].delta.content
                self.textChanged.emit(chunk.choices[0].delta.content)  # 发送给qml
        print(response_text)
        return response_text