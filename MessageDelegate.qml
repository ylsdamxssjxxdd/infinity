import QtQuick
import QtQuick.Controls // 控件
import QtQuick.Layouts // 布局

// 消息组件
Item {
    id: messageBox
    width: listView.width // 这里确保宽度匹配父容器的宽度
    height: message_TextArea.height + 2*toolButton_size // 确保工具按钮可见

    property int toolButton_size: 20

    // 消息框
    Dialog {
        id: messageDialog
        title: "Message"
        standardButtons: Dialog.NoButton
        x: (page.width - width) / 2

        Label {
            text: "复制成功"
            wrapMode: Label.Wrap
            width: parent.width
        }
        Timer {
            id: closeTimer
            interval: 500
            onTriggered: messageDialog.close()
        }

        onOpened: closeTimer.start()
    }

    // 显示角色
    TextArea {
        id: role_TextArea
        height: message_TextArea.height
        width: 50
        anchors.left: messageBox.left // 锚点很重要

        font.pixelSize: 16
        text: model.role // 确保这里引用的是模型的属性，model对应到listView的model属性
        wrapMode: TextArea.Wrap  // 确保文本能够根据宽度自动换行
        readOnly: true

        // 设置边框
        Rectangle {
            color: "transparent"  // 背景透明
            border.color: "gray"
            border.width: 1
            radius: 5
            anchors.fill: role_TextArea
        }
    }

    // 显示消息
    TextArea {
        id: message_TextArea
        height: contentHeight + 10  // 根据内容自动调整高度
        width: parent.width - role_TextArea.width - 10
        anchors.right: messageBox.right

        text: model.content // 确保这里引用的是模型的属性
        font.pixelSize: 16
        wrapMode: TextArea.Wrap  // 确保文本能够根据宽度自动换行
        readOnly: true

        // 设置边框, 注意根据角色和是否可编辑变色
        Rectangle {
            color: "transparent"  // 背景透明
            border.color: "gray"
            border.width: 1
            radius: 5
            anchors.fill: message_TextArea
        }
    }

    // 删除按钮
    Button {
        id: delete_Button
        height: toolButton_size
        width: toolButton_size
        anchors.top: message_TextArea.bottom
        anchors.right: messageBox.right
        anchors.rightMargin: 5 // 在这里增加了几个像素的右边距
        text: "D"
        onClicked: {
            console.log("delete")
            chatModel.remove(model.index)  // 从模型中删除项, model.index就是当前代理的索引

        }
    }

    // 复制按钮
    Button {
        id: copy_Button
        height: toolButton_size
        width: toolButton_size
        anchors.top: message_TextArea.bottom
        anchors.right: delete_Button.left
        anchors.rightMargin: 5 // 在这里增加了几个像素的右边距

        text: "C"
        onClicked: {
            bridge.copyToClipboard(message_TextArea.text)
            messageDialog.open()
            console.log("copy")
        }
    }

    // 编辑按钮
    Button {
        id: edit_Button
        height: toolButton_size
        width: toolButton_size
        anchors.top: message_TextArea.bottom
        anchors.right: copy_Button.left
        anchors.rightMargin: 5 // 在这里增加了几个像素的右边距

        text: "E"
        onClicked: {
            console.log("edit")
            message_TextArea.readOnly = false
        }
    }

}

