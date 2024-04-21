import QtQuick // qml核心
import QtQuick.Layouts // 布局
import QtQuick.Controls // 控件
import QtQuick.Window // 窗口

import io.qt.textproperties 1.0 // 导入预设的和python的接口

// 主窗口
ApplicationWindow {
    id: page
    width: 400
    height: 800
    minimumWidth: 300 // 最小宽度
    minimumHeight: 400 // 最小高度
    visible: true

    property int show_rectangle_border: 0 // 是否显示布局用的矩形框边界

    // python中定义的qml对象
    Bridge {
        id: bridge
    }

    //定义快捷键
    Action {
        id: buttonAction
        shortcut: "Ctrl+Return" // Return就是回车
        onTriggered: send_button.clicked()
    }

    // 外层套一个Rectangle作为背景和轮廓
    Rectangle {
        anchors.fill: parent // 尽量充满父窗口
        anchors.margins: 1 // 设置所有边的边距

        ColumnLayout {
            id: columnlayout1
            anchors.fill: parent // 尽量充满父窗口
            spacing: 5 // 列布局中每组元素的上下间距

            // 第一行
            RowLayout {
                id: rowlayout1
                Layout.fillWidth: true // 按照布局伸展

                // 历史按钮
                Rectangle {
                    id: old_rectangle
                    width: 50
                    height: 50
                    border.color: "black"
                    border.width: show_rectangle_border

                    Button {
                        id: old_button
                        anchors.fill: parent // 尽量充满父窗口
                        highlighted: true // 按钮高亮
                        text: "历史"
                        onClicked: {
                            console.log("old_button")
                        }
                    }

                }

                // 标题文本栏
                Rectangle {
                    id: title_rectangle
                    Layout.fillWidth: true // 按照布局伸展
                    height: 50


                    border.color: "black"
                    border.width: show_rectangle_border
                    Button {
                        id: title_button
                        anchors.fill: parent // 尽量充满父窗口
                        highlighted: true // 按钮高亮
                        text: "装载模型"
                        onClicked: {
                            console.log("title_button")
                        }
                    }
                }

                // 设置按钮
                Rectangle {
                    id: settings_rectangle
                    width: 50
                    height: 50
                    border.color: "black"
                    border.width: show_rectangle_border

                    Button {
                        id: new_button
                        anchors.fill: parent // 尽量充满父窗口
                        highlighted: true // 按钮高亮
                        text: "新建"
                        onClicked: {
                            chatModel.clear() // 删除输出区所有内容
                        }
                    }

                }

            }

            // 第二行
            RowLayout {
                id: rowlayout2

                // 聊天内容
                Rectangle {
                    id: output_rectangle
                    Layout.fillWidth: true // 按照布局伸展
                    Layout.fillHeight: true // 按照布局伸展
                    border.color: "black"
                    border.width: show_rectangle_border

                    ScrollView {
                        anchors.fill: parent // 尽量充满父窗口
                        clip: true // 这个属性能确保子元素不会在父元素的边界之外绘制
                        // 列视图
                        ListView {
                            id: listView
                            anchors.fill: parent // 尽量充满父窗口
                            spacing: 30 // 每个元素的垂直方向间距
                            // 需要显示的列模型，模型中的内容会被及时显示
                            model: ListModel {
                                id: chatModel
                            }
                            // 代理，每个元素的显示方式
                            delegate: MessageDelegate {}
                        }
                    }


                }
            }

            // 第三行
            RowLayout {
                id: rowlayout3
                Layout.fillWidth: true // 按照布局伸展
                Layout.alignment: Qt.AlignBottom // 置底
                // Layout.bottomMargin: 5 // 底部留出5单位的空间

                // 上传按钮
                Rectangle {
                    id: upload_rectangle
                    width: 50
                    height: 50
                    border.color: "black"
                    border.width: show_rectangle_border


                    Button {
                        id: upload_button
                        anchors.fill: parent // 尽量充满父窗口
                        highlighted: true // 按钮高亮
                        text: "上传"
                        onClicked: {
                            console.log("upload_button")
                        }
                    }

                }

                // 输入框
                Rectangle {
                    id: input_rectangle
                    Layout.fillWidth: true // 按照布局伸展
                    height: 50
                    border.color: "blue"
                    border.width: 1
                    radius: 5

                    ScrollView {
                        anchors.fill: parent // 尽量充满父窗口
                        TextArea {
                            id: input_TextArea
                            placeholderText: qsTr("请输入聊天内容")
                            wrapMode: TextArea.Wrap            // 自动换行
                            font.pixelSize: 16

                            // 设置边框
                            Rectangle {
                                color: "transparent"  // 背景透明
                                border.color: "gray"

                            }
                        }
                    }

                }

                // 发送按钮
                Rectangle {
                    id: send_rectangle
                    width: 50
                    height: 50
                    border.color: "black"
                    border.width: show_rectangle_border


                    Button {
                        id: send_button
                        anchors.fill: parent // 尽量充满父窗口
                        highlighted: true // 按钮高亮
                        text: "发送"
                        onClicked: {
                            if(input_TextArea.text !== "")
                            {
                                chatModel.append({"name":"user","content": input_TextArea.text})
                                input_TextArea.text = ""
                            }

                        }

                        action: buttonAction // 添加快捷键
                        // 提示条
                        ToolTip {
                            visible: send_button.hovered // ToolTip 可见性与按钮是否被鼠标悬停相关联
                            text: "ctrl+enter"
                            delay: 500 // 延迟500毫秒后显示提示
                            // 配置提示样式和位置等
                        }
                    }

                }


            }

        }

    }

}
