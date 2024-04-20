import QtQuick
import QtQuick.Controls // 控件
import QtQuick.Layouts // 布局

// 消息组件
Rectangle {
    id: messageContainer
    width: listView.width // 这里确保宽度匹配父容器的宽度
    height: message_Rectangle.height

    property int toolbar_height: 20

    RowLayout {
        anchors.fill: parent // 尽量充满父窗口
        
        Rectangle {
            id: role_Rectangle
            width: 50
            height: message_Rectangle.height
            border.color: "green"
            border.width: show_rectangle_border
            Layout.alignment: Qt.AlignTop // 置顶
            // 显示角色
            TextArea {
                text: model.name // 确保这里引用的是模型的属性
                font.pixelSize: 16
            }
        }

        Rectangle {
            id: message_Rectangle
            Layout.fillWidth: true // 按照布局伸展
            height: message_text_rectangle.height + toolbar_rectangle.height
            border.color: "pink"
            border.width: show_rectangle_border
            Layout.alignment: Qt.AlignTop // 置顶

            ColumnLayout { // ColumnLayout 的高度本身是由其内部元素的高度和布局决定的不能作为子元素的parent
                anchors.fill: parent // 尽量充满父窗口
                spacing: 0 // 不要间隔
                // 显示消息
                Rectangle {
                    id: message_text_rectangle
                    Layout.fillWidth: true // 按照布局伸展
                    height: message_textArea.height
                    border.color: "coral"
                    border.width: 1
                    Layout.alignment: Qt.AlignTop // 置顶
                    

                    // 显示消息
                    TextArea {
                        id: message_textArea
                        text: model.content // 确保这里引用的是模型的属性
                        font.pixelSize: 16
                        wrapMode: TextArea.Wrap  // 确保文本能够根据宽度自动换行
                        height: contentHeight + 10  // 根据内容自动调整高度

                        // 当文本改变时，更新容器的高度
                        onTextChanged: {
                            messageContainer.height = message_textArea.height
                            message_text_rectangle.height = message_textArea.height

                            console.log("------------------------")
                            console.log("messageContainer " , messageContainer.height , messageContainer.x , messageContainer.y)
                            console.log("role_Rectangle " , role_Rectangle.height)
                            console.log("message_Rectangle " , message_Rectangle.height)
                            console.log("message_text_rectangle " , message_text_rectangle.height)
                            console.log("message_textArea " , message_textArea.height)


                            
                        }
                    }
                }

                // 显示工具条
                Rectangle {
                    id: toolbar_rectangle
                    Layout.fillWidth: true // 按照布局伸展
                    height: toolbar_height
                    border.color: "blue"
                    border.width: show_rectangle_border
                    Layout.alignment: Qt.AlignBottom // 置底

                    RowLayout {
                        anchors.fill: parent // 尽量充满父窗口
                        // 随便用个组件把工具按钮挤到右边
                        Item {
                            Layout.fillWidth: true
                        }
                        
                        Rectangle {

                            width: 20
                            height: toolbar_height
                            border.color: "black"
                            border.width: show_rectangle_border

                            Button {
                                anchors.fill: parent // 尽量充满父窗口
                                text: "c" // 复制
                            }
                        }

                        Rectangle {
                            width: 20
                            height: toolbar_height
                            border.color: "black"
                            border.width: show_rectangle_border

                            Button {
                                anchors.fill: parent // 尽量充满父窗口
                                text: "d" // 删除
                            }
                        }

                    }
                }

            }

        }
    }

}

