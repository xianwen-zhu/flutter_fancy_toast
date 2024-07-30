Fancy Toast

Fancy Toast 是一个用于 Android 和 iOS 的 Flutter 插件，提供了丰富的提示弹窗功能，包括文本提示、图标提示和加载提示。

项目简介

Fancy Toast 提供了一组易于使用且高度可定制的提示框，适用于各种移动应用场景。支持显示文本、图标和 GIF 动画，具有友好的用户交互体验。


安装

1. 添加依赖

在你的 pubspec.yaml 文件中添加以下依赖项：

  fancy_toast:
    git:
      url: https://github.com/xianwen-zhu/flutter_fancy_toast.git
      ref: v版本号

2. 获取依赖

运行以下命令来安装包：

使用说明

初始化

在使用 Fancy Toast 之前，你需要先初始化它

  final _fancyToastPlugin = FancyToast();


 显示文本提示
      _fancyToastPlugin.showTextToast('这是一个简单的文字 Toast');


 显示图标提示

你可以根据不同的情境显示不同的图标提示，例如成功、错误和警告：
    _fancyToastPlugin.showIconToast("操作成功", ToastType.success);
    _fancyToastPlugin.showIconToast("操作失败", ToastType.error);
    _fancyToastPlugin.showIconToast("警告信息", ToastType.warning);


显示加载提示

加载提示通常用于表示某个操作正在进行中：
   _fancyToastPlugin.showLoadingToast("加载中...");

隐藏提示

可以使用以下方法手动隐藏正在显示的提示：
  
_fancyToastPlugin.hideToast();


  
