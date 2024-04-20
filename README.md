# 次品
简易的大模型聊天软件（pyside6 & qml）

# 特性
- 通过api端点进行聊天
- 编译到android的潜力

# 打包
- 修改pysidedeploy.spec文件(非必须，当第一次运行pyside6-deploy会自动生成一个，打包程序有问题再来修改)
    - 修改图标路径 icon
    - 添加额外依赖 extra_args (例如添加动态库 --include-data-file=动态库本地路径=动态库将来运行路径)
    - 添加第三方jar包 jars_dir
    - 修改sdk路径 sdk_path
    - 修改ndk路径 ndk_path
    - 修改目标架构 arch
- 进入干净的虚拟环境(只安装软件依赖的库)
    - 打包到桌面端 pyside6-deploy main.py
    - 打包到安卓端(暂时只能在linux环境运行) pyside6-android-deploy main.py