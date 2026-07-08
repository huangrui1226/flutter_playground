# GitHub Actions 构建发布使用文档

本文档说明 `.github/workflows/build.yml` 的使用方式。该 workflow 名称为 `build`，用于手动触发 Flutter 项目的 iOS TestFlight 上传、安装包上传蒲公英，以及飞书构建结果通知。

## 功能概览

当前 workflow 包含 3 个 job：

| Job | 作用 | 运行环境 |
| --- | --- | --- |
| `build-ios` | 构建 iOS IPA，并上传到 TestFlight | `self-hosted` |
| `build-android` | 将指定 APK 或 IPA 上传到蒲公英 | `self-hosted` |
| `notify-feishu` | 汇总 iOS、Android 结果并发送飞书通知 | `self-hosted` |

触发方式只有一种：在 GitHub Actions 页面手动运行 `workflow_dispatch`。

## 使用前准备

### 1. 自托管 Runner

3 个 job 都使用 `runs-on: self-hosted`，因此仓库或组织下必须配置可用的 GitHub self-hosted runner。

iOS 构建 runner 需要是 macOS，并提前安装：

- Xcode 和命令行工具
- Flutter SDK
- FVM
- Ruby
- Python 3
- `curl`
- 可用的 iOS 签名配置

Android 上传 job 当前不会执行 `flutter build apk`。它只会检查并上传 `pgyer_file_path` 指定的本地文件。因此运行该 job 的 runner 工作目录中必须已经存在要上传的 APK 或 IPA；否则会报错：

```text
Package file not found: <path>
```

### 2. Flutter 版本

项目 `pubspec.yaml` 要求：

```yaml
environment:
  sdk: ^3.10.0
  flutter: ^3.38.0
```

runner 上的 FVM 配置需要能提供兼容的 Flutter 版本。workflow 中使用的命令是：

```bash
fvm flutter pub get
fvm flutter build ipa --release --export-method app-store
```

### 3. iOS 版本号

`pubspec.yaml` 的 `version` 必须包含 build number，格式如下：

```yaml
version: 1.0.0+7
```

iOS 上传前会读取：

- `1.0.0` 作为 TestFlight 版本号
- `7` 作为 build number

workflow 会查询 App Store Connect 上同版本已上传的最大 build number。只有当前 build number 更大时才上传，否则会失败并提示跳过上传。

## GitHub Secrets

进入 GitHub 仓库：

`Settings` -> `Secrets and variables` -> `Actions` -> `Repository secrets`

配置以下 secrets。

### 必填：iOS TestFlight

| Secret | 说明 |
| --- | --- |
| `ASC_API_KEY_ID` | App Store Connect API Key ID |
| `ASC_API_ISSUER_ID` | App Store Connect Issuer ID |
| `ASC_API_PRIVATE_KEY_BASE64` | App Store Connect `.p8` 私钥的 Base64 内容 |

`ASC_API_PRIVATE_KEY_BASE64` 生成示例：

```bash
base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy
```

### 可选：iOS 上传 Apple ID

| Secret | 说明 |
| --- | --- |
| `ASC_APPLE_ID` | App 的 Apple ID。配置后会传给 `xcrun altool --apple-id` |

### 可选：蒲公英

| Secret | 说明 |
| --- | --- |
| `PGYER_API_KEY` | 蒲公英 API Key。为空时跳过蒲公英上传步骤 |

### 可选：飞书通知

| Secret | 说明 |
| --- | --- |
| `FEISHU_BOT_WEBHOOK` | 飞书机器人 Webhook。为空时跳过通知 |
| `FEISHU_BOT_SECRET` | 飞书机器人签名密钥 |

注意：当前飞书通知脚本会读取 `FEISHU_BOT_SECRET`。如果配置了 `FEISHU_BOT_WEBHOOK`，建议同时配置 `FEISHU_BOT_SECRET`。

## 手动触发构建

1. 打开 GitHub 仓库页面。
2. 进入 `Actions`。
3. 选择左侧的 `build` workflow。
4. 点击 `Run workflow`。
5. 选择分支。
6. 填写输入参数。
7. 点击绿色的 `Run workflow` 按钮。

### 输入参数

| 参数 | 必填 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `changelog` | 是 | `- 功能优化和问题修复` | 发布更新说明，会传给蒲公英和飞书通知 |
| `pgyer_file_path` | 是 | `build/app/outputs/flutter-apk/app-debug.apk` | 上传到蒲公英的安装包路径，只支持 `.apk` 或 `.ipa` |

示例：

```text
changelog:
- 修复蓝牙连接稳定性
- 优化首页加载速度

pgyer_file_path:
build/app/outputs/flutter-apk/app-release.apk
```

## 执行流程

### iOS：构建并上传 TestFlight

`build-ios` 会执行：

1. 拉取代码。
2. 清理旧的 `build/ios/archive` 和 `build/ios/ipa`。
3. 执行 `fvm flutter pub get`。
4. 执行 `fvm flutter build ipa --release --export-method app-store`。
5. 检查 `build/ios/ipa` 下是否有且仅有一个 `.ipa`。
6. 解码 App Store Connect `.p8` 私钥。
7. 读取 iOS bundle id。
8. 读取 `pubspec.yaml` 中的版本号和 build number。
9. 查询 App Store Connect 上同版本已上传的 build number。
10. 当前 build number 更大时，使用 `xcrun altool` 上传到 TestFlight。

### 蒲公英：上传指定安装包

`build-android` 会执行：

1. 拉取代码。
2. 检查 `pgyer_file_path` 文件是否存在。
3. 根据文件后缀判断上传类型：
   - `.apk` -> `apk`
   - `.ipa` -> `ipa`
4. 调用蒲公英接口获取 COS 上传 token。
5. 上传安装包。
6. 轮询发布结果，最多等待 30 次，每次间隔 5 秒。
7. 输出蒲公英安装地址和二维码地址，供飞书通知使用。

### 飞书：发送构建结果

`notify-feishu` 会在前两个 job 结束后运行，即使构建失败也会执行。

通知内容包含：

- 仓库
- 分支
- 触发人
- iOS job 结果
- Android job 结果
- 蒲公英安装地址
- 更新说明
- GitHub Actions 构建详情链接

## 常见问题

### Android job 报 `Package file not found`

原因：当前 workflow 没有构建 Android 包，只上传 `pgyer_file_path` 指定的已有文件。

处理方式：

- 确认 runner 工作目录中存在该文件。
- 或先在 workflow 中增加 Android 构建步骤，例如 `fvm flutter build apk --release`。
- 或把 `pgyer_file_path` 改成实际存在的 `.apk` 或 `.ipa` 路径。

### iOS 报 `Missing App Store Connect secrets`

原因：缺少以下任一 secret：

- `ASC_API_KEY_ID`
- `ASC_API_ISSUER_ID`
- `ASC_API_PRIVATE_KEY_BASE64`

处理方式：到 GitHub Actions secrets 中补齐。

### iOS 报 build number 不够大

原因：`pubspec.yaml` 中的 build number 不大于 TestFlight 同版本已上传的最大 build number。

处理方式：递增 `pubspec.yaml`：

```yaml
version: 1.0.0+8
```

### 蒲公英上传被跳过

原因：`PGYER_API_KEY` 没有配置或为空。

处理方式：配置 `PGYER_API_KEY`。

### 飞书通知没有发送

原因：`FEISHU_BOT_WEBHOOK` 没有配置或为空。

处理方式：配置飞书机器人 webhook。若机器人开启签名校验，还需要配置 `FEISHU_BOT_SECRET`。

## 当前限制

- workflow 只能手动触发，没有配置 push、tag 或 PR 自动触发。
- Android job 当前不构建 Android 包，只上传指定路径的安装包。
- iOS build number 必须是纯数字。
- iOS 上传依赖自托管 macOS runner 的本地 Xcode、FVM 和签名环境。
- 如果 iOS 或 Android 任一 job 失败，飞书通知会标记整体构建失败。
