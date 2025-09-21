import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case system = "system"
    case english = "en"
    case simplifiedChinese = "zh-Hans"
    case japanese = "ja"
    case french = "fr"
    case spanish = "es"
    case german = "de"
    case russian = "ru"
    case hindi = "hi"

    var id: String { rawValue }

    static func resolveSystemDefault() -> AppLanguage {
        guard let preferred = Locale.preferredLanguages.first else { return .english }
        let lower = preferred.lowercased()
        if lower.hasPrefix("zh") { return .simplifiedChinese }
        if lower.hasPrefix("ja") { return .japanese }
        if lower.hasPrefix("fr") { return .french }
        if lower.hasPrefix("es") { return .spanish }
        if lower.hasPrefix("de") { return .german }
        if lower.hasPrefix("ru") { return .russian }
        if lower.hasPrefix("hi") { return .hindi }
        return .english
    }
}

enum LocalizationKey: String {
    case noAppsFound
    case searchPlaceholder
    case appTitle
    case modifiedFrom
    case backgroundHint
    case classicMode
    case iconSize
    case iconsPerRow
    case rowsPerPage
    case iconHorizontalSpacing
    case iconVerticalSpacing
    case labelFontSize
    case pageIndicatorHint
    case rememberPageTitle
    case globalShortcutTitle
    case shortcutSetButton
    case shortcutSaveButton
    case shortcutClearButton
    case shortcutNotSet
    case shortcutListening
    case shortcutCapturePrompt
    case shortcutNoModifierWarning
    case smaller
    case larger
    case predictDrop
    case showLabels
    case useLocalizedThirdPartyTitles
    case enableAnimations
    case hoverMagnification
    case hoverMagnificationScale
    case activePressEffect
    case activePressScale
    case animationDurationLabel
    case gridSizeChangeWarning
    case viewOnGitHub
    case scrollSensitivity
    case low
    case high
    case importSystem
    case importLegacy
    case importTip
    case exportData
    case importData
    case refresh
    case resetLayout
    case resetAlertTitle
    case resetAlertMessage
    case resetConfirm
    case cancel
    case quit
    case languagePickerTitle
    case appearanceModeTitle
    case appearanceModeFollowSystem
    case appearanceModeLight
    case appearanceModeDark
    case versionPrefix
    case settingsSectionPerformance
    case settingsSectionTitles
    case settingsSectionDevelopment
    case settingsSectionAbout
    case settingsSectionGeneral
    case settingsSectionAppearance
    case developmentPlaceholderTitle
    case developmentPlaceholderSubtitle
    case performancePlaceholderTitle
    case performancePlaceholderSubtitle
    case renameSearchPlaceholder
    case customTitlePlaceholder
    case customTitleHint
    case customTitleDefaultFormat
    case customTitleReset
    case customTitleAddButton
    case customTitleEmptyTitle
    case customTitleEmptySubtitle
    case customTitleNoResults
    case customTitlePickerMessage
    case customTitleEdit
    case customTitleSave
    case customTitleCancel
    case customTitleDelete
    case loadingApplications
    case showFPSOverlay
    case showFPSOverlayDisclaimer
    case customIconTitle
    case customIconChoose
    case customIconReset
    case customIconHint
    case customIconError
    case pageIndicatorOffsetLabel
    case folderWindowWidth
    case folderWindowHeight
    case folderWindowSizeHint
    case languageNameSystem
    case languageNameEnglish
    case languageNameChinese
    case languageNameJapanese
    case languageNameFrench
    case languageNameSpanish
    case languageNameGerman
    case languageNameRussian
    case languageNameHindi
    case folderNamePlaceholder
    case chooseButton
    case exportPanelMessage
    case importPrompt
    case importPanelMessage
    case legacyArchivePanelMessage
    case importSuccessfulTitle
    case importFailedTitle
    case okButton

    // 更新检查相关
    case checkForUpdates
    case checkForUpdatesButton
    case checkingForUpdates
    case upToDate
    case updateAvailable
    case newVersion
    case downloadUpdate
    case updateCheckFailed
    case tryAgain
    case autoCheckForUpdates
    case versionParseError
}

final class LocalizationManager {
    static let shared = LocalizationManager()

    private let translations: [AppLanguage: [LocalizationKey: String]]

    private init() {
        var builder: [AppLanguage: [LocalizationKey: String]] = [
            .english: [
                .noAppsFound: "No apps found",
                .searchPlaceholder: "Search",
                .renameSearchPlaceholder: "Search apps",
                .customTitlePlaceholder: "Enter a custom name",
                .customTitleHint: "Rename apps here. Custom titles persist across imports and localization changes.",
                .customTitleDefaultFormat: "Default: %@",
                .customTitleReset: "Restore default",
                .customTitleAddButton: "Add application",
                .customTitleEmptyTitle: "No custom titles yet",
                .customTitleEmptySubtitle: "Choose an app to start renaming. Custom titles stay even after imports or localization changes.",
                .customTitleNoResults: "No matches",
                .customTitlePickerMessage: "Select an application to manage its title.",
                .customTitleEdit: "Edit",
                .customTitleSave: "Save",
                .customTitleCancel: "Cancel",
                .customTitleDelete: "Remove",
                .loadingApplications: "Loading applications…",
                .showFPSOverlay: "Show FPS overlay",
                .showFPSOverlayDisclaimer: "Approximate measurement; may not reflect actual frame pacing.",
                .customIconTitle: "Application icon",
                .customIconChoose: "Choose…",
                .customIconReset: "Restore default",
                .customIconHint: "PNG/ICNS files at 512×512 work best. Changes apply instantly.",
                .customIconError: "Could not load the selected image.",
                .pageIndicatorOffsetLabel: "Page indicator spacing",
                .folderWindowWidth: "Folder window width",
                .folderWindowHeight: "Folder window height",
                .folderWindowSizeHint: "Applies to windowed mode only; classic fullscreen uses a fixed layout.",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Modified from LaunchNow version 1.3.1",
                .backgroundHint: "Automatically run on background: add LaunchNext to dock or use keyboard shortcuts to open the application window",
                .classicMode: "Classic Launchpad (Fullscreen)",
                .iconSize: "Icon size",
                .iconsPerRow: "Icons per row",
                .rowsPerPage: "Rows per page",
                .iconHorizontalSpacing: "Horizontal spacing",
                .iconVerticalSpacing: "Vertical spacing",
                .labelFontSize: "Label font size",
                .smaller: "Smaller",
                .larger: "Larger",
                .predictDrop: "Predict drop position",
                .showLabels: "Show labels under icons",
                .useLocalizedThirdPartyTitles: "Use localized app names",
                .enableAnimations: "Enable slide animation",
                .hoverMagnification: "Hover magnification",
                .hoverMagnificationScale: "Hover scale",
                .activePressEffect: "Press feedback",
                .activePressScale: "Press scale",
                .animationDurationLabel: "Slide animation duration",
                .gridSizeChangeWarning: "Changing the grid size may reposition some icons.",
                .pageIndicatorHint: "If vertical spacing feels subtle, adjust the page indicator offset below.",
                .rememberPageTitle: "Remember last opened page",
                .globalShortcutTitle: "Global shortcut",
                .shortcutSetButton: "Set shortcut",
                .shortcutSaveButton: "Save",
                .shortcutClearButton: "Clear",
                .shortcutNotSet: "Not set",
                .shortcutListening: "Listening…",
                .shortcutCapturePrompt: "Press the desired key combination. Press Esc to cancel.",
                .shortcutNoModifierWarning: "Using no modifier may clash with other apps.",
                .scrollSensitivity: "Scrolling sensitivity",
                .low: "Low",
                .high: "High",
                .importSystem: "Import System Launchpad",
                .importLegacy: "Import Legacy (.lmy)",
                .importTip: "Tip: Click ‘Import System Launchpad’ to import directly from the system Launchpad.",
                .exportData: "Export Data",
                .importData: "Import Data",
                .refresh: "Refresh",
                .resetLayout: "Reset Layout",
                .resetAlertTitle: "Confirm to reset layout?",
                .resetAlertMessage: "This will completely reset the layout: remove all folders, clear saved order, and rescan all applications. All customizations will be lost.",
                .resetConfirm: "Reset",
                .cancel: "Cancel",
                .quit: "Quit",
                .languagePickerTitle: "Language",
                .appearanceModeTitle: "Appearance",
                .appearanceModeFollowSystem: "Follow system",
                .appearanceModeLight: "Light",
                .appearanceModeDark: "Dark",
                .versionPrefix: "v",
                .languageNameSystem: "Follow System",
                .languageNameEnglish: "英语",
                .languageNameChinese: "中文",
                .languageNameJapanese: "日语",
                .languageNameFrench: "法语",
                .languageNameSpanish: "西班牙语",
                .languageNameGerman: "德语",
                .languageNameRussian: "俄语",
                .languageNameHindi: "Hindi",
                .folderNamePlaceholder: "Folder Name",
                .viewOnGitHub: "Open project link",
                .chooseButton: "Choose",
                .exportPanelMessage: "Choose a destination folder to export LaunchNext data",
                .importPrompt: "Import",
                .importPanelMessage: "Choose a folder previously exported from LaunchNext",
                .legacyArchivePanelMessage: "Choose a legacy Launchpad archive (.lmy/.zip) or a db file",
                .importSuccessfulTitle: "Import Successful",
                .importFailedTitle: "Import Failed",
                .okButton: "OK",

                // 更新检查相关
                .checkForUpdates: "Check for Updates",
                .checkForUpdatesButton: "Check for Updates",
                .checkingForUpdates: "Checking for updates...",
                .upToDate: "You're up to date",
                .updateAvailable: "Update Available",
                .newVersion: "New version:",
                .downloadUpdate: "Download Update",
                .updateCheckFailed: "Update check failed",
                .tryAgain: "Try Again",
                .autoCheckForUpdates: "Check for updates automatically",
                .versionParseError: "Version parsing error"
            ],
            .simplifiedChinese: [
                .noAppsFound: "未找到任何应用",
                .searchPlaceholder: "搜索",
                .renameSearchPlaceholder: "搜索应用",
                .customTitlePlaceholder: "输入自定义名称",
                .customTitleHint: "在这里为任意应用重命名；即使重新导入或切换本地化也会保留。",
                .customTitleDefaultFormat: "默认：%@",
                .customTitleReset: "恢复默认",
                .customTitleAddButton: "添加应用",
                .customTitleEmptyTitle: "当前没有自定义名称",
                .customTitleEmptySubtitle: "点击按钮选择应用即可开始重命名；重新导入或切换语言都会保留这些设置。",
                .customTitleNoResults: "没有匹配项",
                .customTitlePickerMessage: "选择一个应用来管理显示名称。",
                .customTitleEdit: "编辑",
                .customTitleSave: "保存",
                .customTitleCancel: "取消",
                .customTitleDelete: "删除",
                .loadingApplications: "正在加载应用…",
                .showFPSOverlay: "显示 FPS",
                .showFPSOverlayDisclaimer: "当前数值仅供参考，可能与实际帧率存在差异。",
                .customIconTitle: "应用图标",
                .customIconChoose: "选择…",
                .customIconReset: "恢复默认图标",
                .customIconHint: "建议使用 512×512 的 PNG/ICNS 文件，修改会立即生效。",
                .customIconError: "无法加载所选图像。",
                .pageIndicatorOffsetLabel: "页面指示器间距",
                .appTitle: "LaunchNext",
                .modifiedFrom: "基于 LaunchNow 1.3.1 修改",
                .backgroundHint: "保持后台运行：可将 LaunchNext 固定在 Dock 或使用快捷键打开窗口",
                .classicMode: "经典 Launchpad（全屏）",
                .iconSize: "图标大小",
                .iconsPerRow: "每行图标数量",
                .rowsPerPage: "每页行数",
                .iconHorizontalSpacing: "横向间距",
                .iconVerticalSpacing: "纵向间距",
                .labelFontSize: "标签字体大小",
                .smaller: "更小",
                .larger: "更大",
                .predictDrop: "启用落点预判",
                .showLabels: "显示图标文字",
                .useLocalizedThirdPartyTitles: "使用本地化应用名称",
                .enableAnimations: "启用滑动动画",
                .hoverMagnification: "悬停放大效果",
                .hoverMagnificationScale: "悬停放大倍率",
                .activePressEffect: "按下缩放反馈",
                .activePressScale: "按下缩放倍率",
                .animationDurationLabel: "滑动动画时长",
                .gridSizeChangeWarning: "调整网格设置可能导致部分图标位置发生变化。",
                .pageIndicatorHint: "若间距变化不明显，可下调页面指示点的位置。",
                .rememberPageTitle: "记住上次打开的页面",
                .globalShortcutTitle: "全局快捷键",
                .shortcutSetButton: "设置快捷键",
                .shortcutSaveButton: "保存",
                .shortcutClearButton: "清除",
                .shortcutNotSet: "未设置",
                .shortcutListening: "等待按键…",
                .shortcutCapturePrompt: "按下想要的快捷键组合，按 Esc 取消。",
                .shortcutNoModifierWarning: "未使用修饰键可能与其他应用冲突。",
                .scrollSensitivity: "滚动灵敏度",
                .low: "低",
                .high: "高",
                .importSystem: "导入系统 Launchpad",
                .importLegacy: "导入 Legacy (.lmy)",
                .importTip: "提示：点击“导入系统 Launchpad”即可直接导入原生布局。",
                .exportData: "导出数据",
                .importData: "导入数据",
                .refresh: "刷新",
                .resetLayout: "重置布局",
                .resetAlertTitle: "确认要重置布局？",
                .resetAlertMessage: "这将完全重置布局：删除所有文件夹、清除保存顺序并重新扫描应用。所有自定义都会丢失。",
                .resetConfirm: "重置",
                .cancel: "取消",
                .quit: "退出",
                .languagePickerTitle: "语言",
                .appearanceModeTitle: "外观模式",
                .appearanceModeFollowSystem: "跟随系统",
                .appearanceModeLight: "浅色",
                .appearanceModeDark: "暗色",
                .folderWindowWidth: "文件夹窗口宽度",
                .folderWindowHeight: "文件夹窗口高度",
                .folderWindowSizeHint: "仅在非经典模式下生效；经典全屏使用固定布局。",
                .versionPrefix: "版本 ",
                .languageNameSystem: "跟随系统",
                .languageNameEnglish: "英語",
                .languageNameChinese: "中国語",
                .languageNameJapanese: "日本語",
                .languageNameFrench: "フランス語",
                .languageNameSpanish: "スペイン語",
                .languageNameGerman: "ドイツ語",
                .languageNameRussian: "ロシア語",
                .languageNameHindi: "ヒンディー語",
                .folderNamePlaceholder: "文件夹名称",
                .viewOnGitHub: "打开项目链接",
                .chooseButton: "选择",
                .exportPanelMessage: "选择一个目标文件夹导出 LaunchNext 数据",
                .importPrompt: "导入",
                .importPanelMessage: "请选择之前由 LaunchNext 导出的文件夹",
                .legacyArchivePanelMessage: "请选择 Legacy Launchpad 归档（.lmy/.zip）或 db 文件",
                .importSuccessfulTitle: "导入成功",
                .importFailedTitle: "导入失败",
                .okButton: "确定",

                // 更新检查相关
                .checkForUpdates: "检查更新",
                .checkForUpdatesButton: "检查更新",
                .checkingForUpdates: "正在检查更新...",
                .upToDate: "已是最新版本",
                .updateAvailable: "发现新版本",
                .newVersion: "新版本：",
                .downloadUpdate: "下载更新",
                .updateCheckFailed: "更新检查失败",
                .tryAgain: "重试",
                .autoCheckForUpdates: "自动检查更新",
                .versionParseError: "版本解析错误"
            ],
            .japanese: [
                .noAppsFound: "アプリが見つかりません",
                .searchPlaceholder: "検索",
                .renameSearchPlaceholder: "アプリを検索",
                .customTitlePlaceholder: "カスタム名を入力",
                .customTitleHint: "ここでアプリ名を自由に変更できます。再インポートやローカライズ設定を切り替えても保持されます。",
                .customTitleDefaultFormat: "デフォルト: %@",
                .customTitleReset: "デフォルトに戻す",
                .customTitleAddButton: "アプリを追加",
                .customTitleEmptyTitle: "カスタム名はまだありません",
                .customTitleEmptySubtitle: "ボタンを押してアプリを選べばリネームを始められます。再インポートや言語変更後も保持されます。",
                .customTitleNoResults: "一致する項目がありません",
                .customTitlePickerMessage: "表示名を管理したいアプリを選択してください。",
                .customTitleEdit: "編集",
                .customTitleSave: "保存",
                .customTitleCancel: "キャンセル",
                .customTitleDelete: "削除",
                .loadingApplications: "アプリを読み込み中…",
                .showFPSOverlay: "FPS オーバーレイを表示",
                .showFPSOverlayDisclaimer: "簡易的な計測値であり、実際のフレームタイミングとは異なる場合があります。",
                .customIconTitle: "アプリのアイコン",
                .customIconChoose: "選択…",
                .customIconReset: "デフォルトに戻す",
                .customIconHint: "512×512 の PNG/ICNS ファイルが推奨です。変更はすぐに反映されます。",
                .customIconError: "選択した画像を読み込めませんでした。",
                .pageIndicatorOffsetLabel: "ページインジケーターの距離",
                .appTitle: "LaunchNext",
                .modifiedFrom: "LaunchNow 1.3.1 をベースに改良",
                .backgroundHint: "バックグラウンドで実行するには、LaunchNext を Dock に追加するかショートカットで開いてください",
                .classicMode: "クラシック Launchpad（フルスクリーン）",
                .iconSize: "アイコンサイズ",
                .iconsPerRow: "1 行あたりのアイコン数",
                .rowsPerPage: "ページあたりの行数",
                .iconHorizontalSpacing: "横方向の間隔",
                .iconVerticalSpacing: "縦方向の間隔",
                .labelFontSize: "ラベルの文字サイズ",
                .smaller: "小さく",
                .larger: "大きく",
                .predictDrop: "ドロップ位置を予測",
                .showLabels: "アイコン名を表示",
                .useLocalizedThirdPartyTitles: "アプリ名をローカライズ",
                .enableAnimations: "スライドアニメーションを有効化",
                .hoverMagnification: "ホバー拡大",
                .hoverMagnificationScale: "ホバー倍率",
                .activePressEffect: "押下時の縮小",
                .activePressScale: "押下時の倍率",
                .animationDurationLabel: "スライドアニメーション時間",
                .gridSizeChangeWarning: "グリッドサイズを変更すると、アイコンの配置が変わる場合があります。",
                .pageIndicatorHint: "変化が分かりにくいときは、ページインジケーターの位置を調整してください。",
                .rememberPageTitle: "最後に開いたページを記憶",
                .globalShortcutTitle: "グローバルショートカット",
                .shortcutSetButton: "ショートカットを設定",
                .shortcutSaveButton: "保存",
                .shortcutClearButton: "クリア",
                .shortcutNotSet: "未設定",
                .shortcutListening: "入力待ち…",
                .shortcutCapturePrompt: "希望するキーを押してください。Esc でキャンセルできます。",
                .shortcutNoModifierWarning: "修飾キーなしの設定は他のアプリと競合する可能性があります。",
                .scrollSensitivity: "スクロール感度",
                .low: "低",
                .high: "高",
                .importSystem: "システム Launchpad をインポート",
                .importLegacy: "Legacy (.lmy) をインポート",
                .importTip: "ヒント：『システム Launchpad をインポート』をクリックすると既存レイアウトを直接取り込めます。",
                .exportData: "データをエクスポート",
                .importData: "データをインポート",
                .refresh: "リフレッシュ",
                .resetLayout: "レイアウトをリセット",
                .resetAlertTitle: "レイアウトをリセットしますか？",
                .resetAlertMessage: "すべてのフォルダを削除し、順序をリセットしてアプリを再スキャンします。カスタマイズは失われます。",
                .resetConfirm: "リセット",
                .cancel: "キャンセル",
                .quit: "終了",
                .languagePickerTitle: "言語",
                .appearanceModeTitle: "外観モード",
                .appearanceModeFollowSystem: "システムに合わせる",
                .appearanceModeLight: "ライト",
                .appearanceModeDark: "ダーク",
                .folderWindowWidth: "フォルダーウィンドウの幅",
                .folderWindowHeight: "フォルダーウィンドウの高さ",
                .folderWindowSizeHint: "ウィンドウモードでのみ有効。クラシック全画面では固定サイズです。",
                .versionPrefix: "v",
                .languageNameSystem: "システムに従う",
                .languageNameEnglish: "Anglais",
                .languageNameChinese: "Chinois",
                .languageNameJapanese: "Japonais",
                .languageNameFrench: "Français",
                .languageNameSpanish: "Espagnol",
                .languageNameGerman: "Allemand",
                .languageNameRussian: "Russe",
                .languageNameHindi: "Hindi",
                .folderNamePlaceholder: "フォルダ名",
                .viewOnGitHub: "プロジェクトリンクを開く",
                .chooseButton: "選択",
                .exportPanelMessage: "LaunchNext のデータを書き出す保存先フォルダを選択してください",
                .importPrompt: "インポート",
                .importPanelMessage: "以前 LaunchNext から書き出したフォルダを選択してください",
                .legacyArchivePanelMessage: "Legacy Launchpad アーカイブ（.lmy/.zip）または db ファイルを選択してください",
                .importSuccessfulTitle: "インポート成功",
                .importFailedTitle: "インポート失敗",
                .okButton: "OK",

                // 更新検査関連
                .checkForUpdates: "アップデートを確認",
                .checkForUpdatesButton: "アップデートを確認",
                .checkingForUpdates: "アップデートを確認中...",
                .upToDate: "最新版です",
                .updateAvailable: "アップデートが利用可能",
                .newVersion: "新しいバージョン：",
                .downloadUpdate: "アップデートをダウンロード",
                .updateCheckFailed: "アップデート確認に失敗",
                .tryAgain: "再試行",
                .autoCheckForUpdates: "自動でアップデートを確認",
                .versionParseError: "バージョン解析エラー"
            ],
            .french: [
                .noAppsFound: "Aucune application trouvée",
                .searchPlaceholder: "Recherche",
                .renameSearchPlaceholder: "Rechercher une application",
                .customTitlePlaceholder: "Saisir un nom personnalisé",
                .customTitleHint: "Renommez vos applications ici. Les noms personnalisés restent même après réimportation ou changement de langue.",
                .customTitleDefaultFormat: "Nom par défaut : %@",
                .customTitleReset: "Restaurer le nom par défaut",
                .customTitleAddButton: "Ajouter une application",
                .customTitleEmptyTitle: "Aucun nom personnalisé",
                .customTitleEmptySubtitle: "Sélectionnez une application pour commencer à la renommer. Les noms personnalisés restent après réimportation ou changement de langue.",
                .customTitleNoResults: "Aucun résultat",
                .customTitlePickerMessage: "Choisissez l’application dont vous souhaitez modifier le nom",
                .customTitleEdit: "Modifier",
                .customTitleSave: "Enregistrer",
                .customTitleCancel: "Annuler",
                .customTitleDelete: "Supprimer",
                .loadingApplications: "Chargement des applications…",
                .showFPSOverlay: "Afficher le nombre d'image par seconde",
                .showFPSOverlayDisclaimer: "Valeur indicative qui peut ne pas refléter précisément le rafraîchissement réel.",
                .customIconTitle: "Icône de l’application",
                .customIconChoose: "Choisir…",
                .customIconReset: "Réinitialiser l’icône",
                .customIconHint: "Utilisez de préférence un fichier PNG/ICNS 512×512. Les changements sont appliqués immédiatement.",
                .customIconError: "Impossible de charger l’image sélectionnée.",
                .pageIndicatorOffsetLabel: "Espacement des points de pages",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Basé sur LaunchNow 1.3.1",
                .backgroundHint: "Pour exécuter LaunchNext en arrière-plan, épinglez l'application au Dock ou utilisez un raccourci clavier pour ouvrir la fenêtre.",
                .classicMode: "Plein écran",
                .iconSize: "Taille des icônes",
                .iconsPerRow: "Icônes par ligne",
                .rowsPerPage: "Lignes par page",
                .iconHorizontalSpacing: "Espacement horizontal",
                .iconVerticalSpacing: "Espacement vertical",
                .labelFontSize: "Taille de la police des noms des applications",
                .smaller: "Petites",
                .larger: "Grandes",
                .predictDrop: "Prédire la position de placement",
                .showLabels: "Afficher les noms des applications",
                .useLocalizedThirdPartyTitles: "Afficher les noms des applications dans la langue du système",
                .enableAnimations: "Activer l’animation de transition",
                .hoverMagnification: "Agrandissement au survol",
                .hoverMagnificationScale: "Facteur d’agrandissement",
                .activePressEffect: "Réaction à l’appui",
                .activePressScale: "Facteur d’appui",
                .animationDurationLabel: "Durée de l’animation de transition",
                .gridSizeChangeWarning: "Modifier la taille de la grille peut déplacer certaines icônes.",
                .pageIndicatorHint: "Si le changement semble faible, ajustez l’espacement de l’indicateur ci-dessous.",
                .rememberPageTitle: "Mémoriser la dernière page ouverte",
                .globalShortcutTitle: "Raccourci global",
                .shortcutSetButton: "Définir le raccourci",
                .shortcutSaveButton: "Enregistrer",
                .shortcutClearButton: "Effacer",
                .shortcutNotSet: "Aucun",
                .shortcutListening: "En écoute…",
                .shortcutCapturePrompt: "Appuyez sur le raccourci souhaité. Échap pour annuler.",
                .shortcutNoModifierWarning: "Sans modificateur, le raccourci risque d’entrer en conflit.",
                .scrollSensitivity: "Sensibilité de défilement",
                .low: "Faible",
                .high: "Élevée",
                .importSystem: "Importer le Launchpad système",
                .importLegacy: "Importer un fichier .lmy",
                .importTip: "Astuce : cliquez sur « Importer le Launchpad système » pour récupérer la disposition d’origine.",
                .exportData: "Exporter les données",
                .importData: "Importer des données",
                .refresh: "Actualiser",
                .resetLayout: "Réinitialiser la disposition",
                .resetAlertTitle: "Confirmer la réinitialisation ?",
                .resetAlertMessage: "La disposition des icônes sera réinitialisée, les dossiers supprimés et les applications rescannées. Toutes les personnalisations seront donc perdues.",
                .resetConfirm: "Réinitialiser",
                .cancel: "Annuler",
                .quit: "Quitter",
                .languagePickerTitle: "Langue",
                .appearanceModeTitle: "Apparence",
                .appearanceModeFollowSystem: "Suivre le système",
                .appearanceModeLight: "Clair",
                .appearanceModeDark: "Sombre",
                .folderWindowWidth: "Largeur de la fenêtre de dossier",
                .folderWindowHeight: "Hauteur de la fenêtre de dossier",
                .folderWindowSizeHint: "S’applique uniquement en mode fenêtre ; le plein écran classique utilise une taille fixe.",
                .versionPrefix: "v",
                .languageNameSystem: "Suivre le système",
                .languageNameEnglish: "English",
                .languageNameChinese: "中文",
                .languageNameJapanese: "日本語",
                .languageNameFrench: "Français",
                .languageNameSpanish: "Español",
                .languageNameGerman: "Deutsch",
                .languageNameRussian: "Русский",
                .languageNameHindi: "Hindi",
                .folderNamePlaceholder: "Nom du dossier",
                .viewOnGitHub: "Ouvrir le lien du projet",
                .chooseButton: "Choisir",
                .exportPanelMessage: "Choisissez un dossier de destination pour exporter les données de LaunchNext",
                .importPrompt: "Importer",
                .importPanelMessage: "Sélectionnez un dossier précédemment exporté depuis LaunchNext",
                .legacyArchivePanelMessage: "Sélectionnez une archive Launchpad Legacy (.lmy/.zip) ou un fichier db",
                .importSuccessfulTitle: "Import réussi",
                .importFailedTitle: "Import échoué",
                .okButton: "OK",

                // Vérification des mises à jour
                .checkForUpdates: "Vérifier les mises à jour",
                .checkForUpdatesButton: "Vérifier les mises à jour",
                .checkingForUpdates: "Vérification en cours...",
                .upToDate: "Vous êtes à jour",
                .updateAvailable: "Mise à jour disponible",
                .newVersion: "Nouvelle version :",
                .downloadUpdate: "Télécharger la mise à jour",
                .updateCheckFailed: "Échec de la vérification",
                .tryAgain: "Réessayer",
                .autoCheckForUpdates: "Vérification automatique",
                .versionParseError: "Erreur d'analyse de version"
            ],
            .spanish: [
                .noAppsFound: "No se encontraron apps",
                .searchPlaceholder: "Buscar",
                .renameSearchPlaceholder: "Buscar app",
                .customTitlePlaceholder: "Escribe un nombre personalizado",
                .customTitleHint: "Renombra cualquier app aquí. Los nombres personalizados se conservan tras volver a importar o cambiar la localización.",
                .customTitleDefaultFormat: "Predeterminado: %@",
                .customTitleReset: "Restaurar predeterminado",
                .customTitleAddButton: "Agregar aplicación",
                .customTitleEmptyTitle: "Aún no hay nombres personalizados",
                .customTitleEmptySubtitle: "Elige una app para empezar a renombrarla. Los nombres personalizados se conservan aunque reimportes o cambies de idioma.",
                .customTitleNoResults: "Sin coincidencias",
                .customTitlePickerMessage: "Selecciona la aplicación cuyo título quieres gestionar.",
                .customTitleEdit: "Editar",
                .customTitleSave: "Guardar",
                .customTitleCancel: "Cancelar",
                .customTitleDelete: "Eliminar",
                .loadingApplications: "Cargando aplicaciones…",
                .showFPSOverlay: "Mostrar overlay de FPS",
                .showFPSOverlayDisclaimer: "Medición aproximada; puede no coincidir con la cadencia real de cuadros.",
                .customIconTitle: "Icono de la aplicación",
                .customIconChoose: "Elegir…",
                .customIconReset: "Restaurar icono predeterminado",
                .customIconHint: "Se recomienda un archivo PNG/ICNS de 512×512. Los cambios se aplican al instante.",
                .customIconError: "No se pudo cargar la imagen seleccionada.",
                .pageIndicatorOffsetLabel: "Separación del indicador de página",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Modificado a partir de LaunchNow versión 1.3.1",
                .backgroundHint: "Para ejecutarlo en segundo plano, fija LaunchNext en el Dock o usa atajos de teclado para abrir la ventana",
                .classicMode: "Launchpad clásico (pantalla completa)",
                .iconSize: "Tamaño de iconos",
                .iconsPerRow: "Iconos por fila",
                .rowsPerPage: "Filas por página",
                .iconHorizontalSpacing: "Espaciado horizontal",
                .iconVerticalSpacing: "Espaciado vertical",
                .labelFontSize: "Tamaño de fuente de las etiquetas",
                .smaller: "Más pequeño",
                .larger: "Más grande",
                .predictDrop: "Predecir posición de caída",
                .showLabels: "Mostrar nombres de iconos",
                .useLocalizedThirdPartyTitles: "Usar nombres localizados",
                .enableAnimations: "Activar la animación de deslizamiento",
                .hoverMagnification: "Ampliación al pasar el cursor",
                .hoverMagnificationScale: "Factor de ampliación",
                .activePressEffect: "Retroalimentación al pulsar",
                .activePressScale: "Factor de pulsación",
                .animationDurationLabel: "Duración de la animación de deslizamiento",
                .gridSizeChangeWarning: "Cambiar el tamaño de la cuadrícula puede recolocar algunos iconos.",
                .pageIndicatorHint: "Si notas poco cambio, ajusta el indicador de página más abajo.",
                .rememberPageTitle: "Recordar la última página abierta",
                .globalShortcutTitle: "Atajo global",
                .shortcutSetButton: "Definir atajo",
                .shortcutSaveButton: "Guardar",
                .shortcutClearButton: "Limpiar",
                .shortcutNotSet: "Sin definir",
                .shortcutListening: "Escuchando…",
                .shortcutCapturePrompt: "Pulsa la combinación deseada. Esc para cancelar.",
                .shortcutNoModifierWarning: "Sin modificadores puede entrar en conflicto con otras apps.",
                .scrollSensitivity: "Sensibilidad de desplazamiento",
                .low: "Baja",
                .high: "Alta",
                .importSystem: "Importar Launchpad del sistema",
                .importLegacy: "Importar Legacy (.lmy)",
                .importTip: "Consejo: haz clic en «Importar Launchpad del sistema» para traer directamente tu disposición actual.",
                .exportData: "Exportar datos",
                .importData: "Importar datos",
                .refresh: "Actualizar",
                .resetLayout: "Reiniciar diseño",
                .resetAlertTitle: "¿Reiniciar el diseño?",
                .resetAlertMessage: "Esto restablecerá por completo el diseño: eliminará carpetas, limpiará el orden y volverá a escanear las apps. Se perderán todas las personalizaciones.",
                .resetConfirm: "Reiniciar",
                .cancel: "Cancelar",
                .quit: "Salir",
                .languagePickerTitle: "Idioma",
                .appearanceModeTitle: "Apariencia",
                .appearanceModeFollowSystem: "Seguir al sistema",
                .appearanceModeLight: "Claro",
                .appearanceModeDark: "Oscuro",
                .folderWindowWidth: "Ancho de la ventana de carpetas",
                .folderWindowHeight: "Alto de la ventana de carpetas",
                .folderWindowSizeHint: "Solo se aplica en modo ventana; el modo clásico a pantalla completa usa un tamaño fijo.",
                .versionPrefix: "v",
                .languageNameSystem: "Seguir sistema",
                .languageNameEnglish: "English",
                .languageNameChinese: "中文",
                .languageNameJapanese: "日本語",
                .languageNameFrench: "Français",
                .languageNameSpanish: "Español",
                .languageNameGerman: "Deutsch",
                .languageNameRussian: "Русский",
                .folderNamePlaceholder: "Nombre de la carpeta",
                .viewOnGitHub: "Abrir enlace del proyecto",
                .chooseButton: "Elegir",
                .exportPanelMessage: "Elige una carpeta de destino para exportar los datos de LaunchNext",
                .importPrompt: "Importar",
                .importPanelMessage: "Selecciona una carpeta previamente exportada desde LaunchNext",
                .legacyArchivePanelMessage: "Elige un archivo de Launchpad Legacy (.lmy/.zip) o un archivo db",
                .importSuccessfulTitle: "Importación completada",
                .importFailedTitle: "Importación fallida",
                .okButton: "OK",

                // Verificación de actualizaciones
                .checkForUpdates: "Buscar actualizaciones",
                .checkForUpdatesButton: "Buscar actualizaciones",
                .checkingForUpdates: "Buscando actualizaciones...",
                .upToDate: "Estás actualizado",
                .updateAvailable: "Actualización disponible",
                .newVersion: "Nueva versión:",
                .downloadUpdate: "Descargar actualización",
                .updateCheckFailed: "Error al buscar actualizaciones",
                .tryAgain: "Intentar de nuevo",
                .autoCheckForUpdates: "Buscar actualizaciones automáticamente",
                .versionParseError: "Error de análisis de versión"
            ],
            .german: [
                .noAppsFound: "Keine Apps gefunden",
                .searchPlaceholder: "Suchen",
                .renameSearchPlaceholder: "Apps durchsuchen",
                .customTitlePlaceholder: "Eigenen Namen eingeben",
                .customTitleHint: "Hier kannst du jeder App einen eigenen Namen geben. Bleibt auch nach erneutem Import oder Sprachwechsel erhalten.",
                .customTitleDefaultFormat: "Standard: %@",
                .customTitleReset: "Standard wiederherstellen",
                .customTitleAddButton: "App hinzufügen",
                .customTitleEmptyTitle: "Noch keine eigenen Namen",
                .customTitleEmptySubtitle: "Wähle eine App aus, um sie umzubenennen. Eigene Namen bleiben auch nach erneutem Import oder Sprachwechsel erhalten.",
                .customTitleNoResults: "Keine Treffer",
                .customTitlePickerMessage: "Wähle die App, deren Namen du verwalten möchtest.",
                .customTitleEdit: "Bearbeiten",
                .customTitleSave: "Speichern",
                .customTitleCancel: "Abbrechen",
                .customTitleDelete: "Entfernen",
                .loadingApplications: "Apps werden geladen…",
                .showFPSOverlay: "FPS-Overlay anzeigen",
                .showFPSOverlayDisclaimer: "Nur ein Näherungswert, kann vom tatsächlichen Frame-Pacing abweichen.",
                .customIconTitle: "App-Symbol",
                .customIconChoose: "Auswählen…",
                .customIconReset: "Standard-Symbol wiederherstellen",
                .customIconHint: "Empfohlen sind PNG/ICNS-Dateien mit 512×512 Pixel. Änderungen wirken sofort.",
                .customIconError: "Das ausgewählte Bild konnte nicht geladen werden.",
                .pageIndicatorOffsetLabel: "Abstand der Seitenanzeige",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Basierend auf LaunchNow Version 1.3.1",
                .backgroundHint: "Für den Hintergrundbetrieb LaunchNext im Dock behalten oder mit Tastenkürzeln das Fenster öffnen",
                .classicMode: "Klassischer Launchpad (Vollbild)",
                .iconSize: "Symbolgröße",
                .iconsPerRow: "Symbole pro Zeile",
                .rowsPerPage: "Zeilen pro Seite",
                .iconHorizontalSpacing: "Horizontaler Abstand",
                .iconVerticalSpacing: "Vertikaler Abstand",
                .labelFontSize: "Schriftgröße der Beschriftung",
                .smaller: "Kleiner",
                .larger: "Größer",
                .predictDrop: "Ablageposition vorhersagen",
                .showLabels: "Beschriftungen unter Symbolen anzeigen",
                .useLocalizedThirdPartyTitles: "Lokalisierte App-Namen verwenden",
                .enableAnimations: "Slide-Animation aktivieren",
                .hoverMagnification: "Vergrößern beim Überfahren",
                .hoverMagnificationScale: "Vergrößerungsfaktor",
                .activePressEffect: "Verkleinern beim Klicken",
                .activePressScale: "Klick-Faktor",
                .animationDurationLabel: "Dauer der Slide-Animation",
                .gridSizeChangeWarning: "Das Ändern der Rastergröße kann einige Symbole neu anordnen.",
                .pageIndicatorHint: "Wirkt der Effekt gering, passe den Seitenindikator darunter an.",
                .rememberPageTitle: "Letzte geöffnete Seite merken",
                .globalShortcutTitle: "Globaler Kurzbefehl",
                .shortcutSetButton: "Kurzbefehl setzen",
                .shortcutSaveButton: "Speichern",
                .shortcutClearButton: "Löschen",
                .shortcutNotSet: "Nicht gesetzt",
                .shortcutListening: "Warten…",
                .shortcutCapturePrompt: "Drücke die gewünschte Tastenkombination. Esc zum Abbrechen.",
                .shortcutNoModifierWarning: "Ohne Modifikatortaste kann es zu Konflikten mit Apps kommen.",
                .scrollSensitivity: "Scroll-Empfindlichkeit",
                .low: "Niedrig",
                .high: "Hoch",
                .importSystem: "System-Launchpad importieren",
                .importLegacy: "Legacy (.lmy) importieren",
                .importTip: "Tipp: Klicken Sie auf „System-Launchpad importieren“, um das Layout direkt zu übernehmen.",
                .exportData: "Daten exportieren",
                .importData: "Daten importieren",
                .refresh: "Aktualisieren",
                .resetLayout: "Layout zurücksetzen",
                .resetAlertTitle: "Layout wirklich zurücksetzen?",
                .resetAlertMessage: "Dies setzt das Layout vollständig zurück: Alle Ordner werden entfernt, die gespeicherte Reihenfolge gelöscht und alle Apps neu eingelesen. Anpassungen gehen verloren.",
                .resetConfirm: "Zurücksetzen",
                .cancel: "Abbrechen",
                .quit: "Beenden",
                .languagePickerTitle: "Sprache",
                .appearanceModeTitle: "Darstellung",
                .appearanceModeFollowSystem: "System folgen",
                .appearanceModeLight: "Hell",
                .appearanceModeDark: "Dunkel",
                .folderWindowWidth: "Ordnerfenster-Breite",
                .folderWindowHeight: "Ordnerfenster-Höhe",
                .folderWindowSizeHint: "Gilt nur im Fenstermodus; der klassische Vollbildmodus nutzt eine feste Größe.",
                .versionPrefix: "v",
                .languageNameSystem: "Systemsprache",
                .languageNameEnglish: "Englisch",
                .languageNameChinese: "Chinesisch",
                .languageNameJapanese: "Japanisch",
                .languageNameFrench: "Französisch",
                .languageNameSpanish: "Spanisch",
                .languageNameGerman: "Deutsch",
                .languageNameRussian: "Russisch",
                .languageNameHindi: "Hindi",
                .folderNamePlaceholder: "Ordnername",
                .viewOnGitHub: "Projektlink öffnen",
                .chooseButton: "Auswählen",
                .exportPanelMessage: "Wählen Sie einen Zielordner, um die LaunchNext-Daten zu exportieren",
                .importPrompt: "Importieren",
                .importPanelMessage: "Wählen Sie einen zuvor aus LaunchNext exportierten Ordner",
                .legacyArchivePanelMessage: "Wählen Sie ein Legacy-Launchpad-Archiv (.lmy/.zip) oder eine DB-Datei",
                .importSuccessfulTitle: "Import erfolgreich",
                .importFailedTitle: "Import fehlgeschlagen",
                .okButton: "OK",

                // Update-Überprüfung
                .checkForUpdates: "Nach Updates suchen",
                .checkForUpdatesButton: "Nach Updates suchen",
                .checkingForUpdates: "Suche nach Updates...",
                .upToDate: "Sie sind auf dem neuesten Stand",
                .updateAvailable: "Update verfügbar",
                .newVersion: "Neue Version:",
                .downloadUpdate: "Update herunterladen",
                .updateCheckFailed: "Update-Prüfung fehlgeschlagen",
                .tryAgain: "Erneut versuchen",
                .autoCheckForUpdates: "Automatisch nach Updates suchen",
                .versionParseError: "Versions-Parsing-Fehler"
            ],
            .russian: [
                .noAppsFound: "Приложения не найдены",
                .searchPlaceholder: "Поиск",
                .renameSearchPlaceholder: "Поиск приложений",
                .customTitlePlaceholder: "Введите своё название",
                .customTitleHint: "Переименовывайте приложения здесь. Пользовательские названия сохраняются даже после повторного импорта или смены локализации.",
                .customTitleDefaultFormat: "По умолчанию: %@",
                .customTitleReset: "Сбросить название",
                .customTitleAddButton: "Добавить приложение",
                .customTitleEmptyTitle: "Пользовательских названий пока нет",
                .customTitleEmptySubtitle: "Выберите приложение, чтобы начать переименование. Названия сохранятся после повторного импорта или смены языка.",
                .customTitleNoResults: "Совпадений нет",
                .customTitlePickerMessage: "Выберите приложение, название которого хотите настроить.",
                .customTitleEdit: "Редактировать",
                .customTitleSave: "Сохранить",
                .customTitleCancel: "Отмена",
                .customTitleDelete: "Удалить",
                .loadingApplications: "Загрузка приложений…",
                .showFPSOverlay: "Показывать FPS",
                .showFPSOverlayDisclaimer: "Показатель приблизительный и может отличаться от фактической частоты кадров.",
                .customIconTitle: "Значок приложения",
                .customIconChoose: "Выбрать…",
                .customIconReset: "Вернуть стандартный значок",
                .customIconHint: "Рекомендуется PNG/ICNS 512×512. Изменения применяются сразу.",
                .customIconError: "Не удалось загрузить выбранное изображение.",
                .pageIndicatorOffsetLabel: "Отступ индикатора страниц",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Основано на LaunchNow версии 1.3.1",
                .backgroundHint: "Чтобы работать в фоне, закрепите LaunchNext в Dock или откройте окно сочетанием клавиш",
                .classicMode: "Классический Launchpad (на весь экран)",
                .iconSize: "Размер значков",
                .iconsPerRow: "Иконок в строке",
                .rowsPerPage: "Строк на страницу",
                .iconHorizontalSpacing: "Горизонтальный промежуток",
                .iconVerticalSpacing: "Вертикальный промежуток",
                .labelFontSize: "Размер шрифта подписи",
                .smaller: "Меньше",
                .larger: "Больше",
                .predictDrop: "Предсказывать позицию размещения",
                .showLabels: "Показывать подписи под значками",
                .useLocalizedThirdPartyTitles: "Использовать локализованные названия",
                .enableAnimations: "Включить анимацию перелистывания",
                .hoverMagnification: "Увеличение при наведении",
                .hoverMagnificationScale: "Коэффициент увеличения",
                .activePressEffect: "Уменьшение при нажатии",
                .activePressScale: "Коэффициент нажатия",
                .animationDurationLabel: "Длительность анимации перелистывания",
                .gridSizeChangeWarning: "Изменение размера сетки может изменить расположение некоторых значков.",
                .pageIndicatorHint: "Если изменения едва заметны, настройте положение индикатора страниц ниже.",
                .rememberPageTitle: "Запоминать последнюю открытую страницу",
                .globalShortcutTitle: "Глобальное сочетание клавиш",
                .shortcutSetButton: "Назначить",
                .shortcutSaveButton: "Сохранить",
                .shortcutClearButton: "Очистить",
                .shortcutNotSet: "Не задано",
                .shortcutListening: "Ожидание…",
                .shortcutCapturePrompt: "Нажмите нужное сочетание клавиш. Esc — отмена.",
                .shortcutNoModifierWarning: "Без модификатора сочетание может конфликтовать с другими приложениями.",
                .scrollSensitivity: "Чувствительность прокрутки",
                .low: "Низкая",
                .high: "Высокая",
                .importSystem: "Импортировать системный Launchpad",
                .importLegacy: "Импортировать Legacy (.lmy)",
                .importTip: "Подсказка: нажмите «Импортировать системный Launchpad», чтобы сразу загрузить текущее расположение.",
                .exportData: "Экспортировать данные",
                .importData: "Импортировать данные",
                .refresh: "Обновить",
                .resetLayout: "Сбросить раскладку",
                .resetAlertTitle: "Сбросить раскладку?",
                .resetAlertMessage: "Раскладка будет полностью сброшена: папки удалятся, порядок очистится, приложения будут просканированы заново. Все настройки будут потеряны.",
                .resetConfirm: "Сбросить",
                .cancel: "Отмена",
                .quit: "Выйти",
                .languagePickerTitle: "Язык",
                .appearanceModeTitle: "Оформление",
                .appearanceModeFollowSystem: "Как в системе",
                .appearanceModeLight: "Светлая",
                .appearanceModeDark: "Тёмная",
                .folderWindowWidth: "Ширина окна папки",
                .folderWindowHeight: "Высота окна папки",
                .folderWindowSizeHint: "Работает только в оконном режиме; классический полноэкранный режим использует фиксированный размер.",
                .versionPrefix: "v",
                .languageNameSystem: "Следовать системе",
                .languageNameEnglish: "Английский",
                .languageNameChinese: "Китайский",
                .languageNameJapanese: "Японский",
                .languageNameFrench: "Французский",
                .languageNameSpanish: "Испанский",
                .languageNameGerman: "Немецкий",
                .languageNameRussian: "Русский",
                .languageNameHindi: "Хинди",
                .folderNamePlaceholder: "Название папки",
                .viewOnGitHub: "Открыть ссылку проекта",
                .chooseButton: "Выбрать",
                .exportPanelMessage: "Выберите папку назначения для экспорта данных LaunchNext",
                .importPrompt: "Импортировать",
                .importPanelMessage: "Выберите папку, ранее экспортированную из LaunchNext",
                .legacyArchivePanelMessage: "Выберите архив Legacy Launchpad (.lmy/.zip) или файл db",
                .importSuccessfulTitle: "Импорт завершён",
                .importFailedTitle: "Импорт не выполнен",
                .okButton: "OK",

                // Проверка обновлений
                .checkForUpdates: "Проверить обновления",
                .checkForUpdatesButton: "Проверить обновления",
                .checkingForUpdates: "Проверка обновлений...",
                .upToDate: "У вас последняя версия",
                .updateAvailable: "Доступно обновление",
                .newVersion: "Новая версия:",
                .downloadUpdate: "Скачать обновление",
                .updateCheckFailed: "Ошибка проверки обновлений",
                .tryAgain: "Попробовать снова",
                .autoCheckForUpdates: "Автоматически проверять обновления",
                .versionParseError: "Ошибка разбора версии"
            ]
        ]

        builder[.english]?.merge([
            .settingsSectionGeneral: "General",
            .settingsSectionAppearance: "Appearance",
            .settingsSectionTitles: "App titles",
            .settingsSectionPerformance: "Performance",
            .settingsSectionDevelopment: "Development",
            .settingsSectionAbout: "About",
            .developmentPlaceholderTitle: "Development playground",
            .developmentPlaceholderSubtitle: "Reserved for future tools and experimental features.",
            .performancePlaceholderTitle: "Performance dashboard",
            .performancePlaceholderSubtitle: "Monitoring metrics will appear here soon."
        ]) { _, new in new }

        builder[.simplifiedChinese]?.merge([
            .settingsSectionGeneral: "通用",
            .settingsSectionAppearance: "外观与行为",
            .settingsSectionTitles: "应用名称",
            .settingsSectionPerformance: "性能",
            .settingsSectionDevelopment: "开发",
            .settingsSectionAbout: "关于",
            .developmentPlaceholderTitle: "开发功能预留",
            .developmentPlaceholderSubtitle: "未来将用于调试工具或实验功能。",
            .performancePlaceholderTitle: "性能面板",
            .performancePlaceholderSubtitle: "性能指标将很快展示在此。"
        ]) { _, new in new }

        builder[.japanese]?.merge([
            .settingsSectionGeneral: "一般",
            .settingsSectionAppearance: "外観と動作",
            .settingsSectionTitles: "アプリ名",
            .settingsSectionPerformance: "パフォーマンス",
            .settingsSectionDevelopment: "開発",
            .settingsSectionAbout: "情報",
            .developmentPlaceholderTitle: "開発者プレイグラウンド",
            .developmentPlaceholderSubtitle: "将来的なツールや実験機能のためのスペースです。",
            .performancePlaceholderTitle: "パフォーマンスダッシュボード",
            .performancePlaceholderSubtitle: "ここに指標が表示されます。"
        ]) { _, new in new }

        builder[.french]?.merge([
            .settingsSectionGeneral: "Général",
            .settingsSectionAppearance: "Apparence",
            .settingsSectionTitles: "Noms des applications",
            .settingsSectionPerformance: "Performances",
            .settingsSectionDevelopment: "Développement",
            .settingsSectionAbout: "À propos",
            .developmentPlaceholderTitle: "Espace développeur",
            .developmentPlaceholderSubtitle: "Réservé aux outils et fonctionnalités expérimentales à venir.",
            .performancePlaceholderTitle: "Tableau de bord des performances",
            .performancePlaceholderSubtitle: "Les indicateurs apparaîtront ici prochainement."
        ]) { _, new in new }

        builder[.spanish]?.merge([
            .settingsSectionGeneral: "General",
            .settingsSectionAppearance: "Apariencia y comportamiento",
            .settingsSectionTitles: "Nombres de apps",
            .settingsSectionPerformance: "Rendimiento",
            .settingsSectionDevelopment: "Desarrollo",
            .settingsSectionAbout: "Acerca de",
            .developmentPlaceholderTitle: "Zona de desarrollo",
            .developmentPlaceholderSubtitle: "Reservado para futuras herramientas y funciones experimentales.",
            .performancePlaceholderTitle: "Panel de rendimiento",
            .performancePlaceholderSubtitle: "Muy pronto podrás ver métricas aquí."
        ]) { _, new in new }

        builder[.german]?.merge([
            .settingsSectionGeneral: "Allgemein",
            .settingsSectionAppearance: "Darstellung & Verhalten",
            .settingsSectionTitles: "App-Namen",
            .settingsSectionPerformance: "Performance",
            .settingsSectionDevelopment: "Entwicklung",
            .settingsSectionAbout: "Info",
            .developmentPlaceholderTitle: "Entwicklerbereich",
            .developmentPlaceholderSubtitle: "Reserviert für zukünftige Tools und experimentelle Features.",
            .performancePlaceholderTitle: "Performance-Dashboard",
            .performancePlaceholderSubtitle: "Kennzahlen folgen in Kürze."
        ]) { _, new in new }

        builder[.russian]?.merge([
            .settingsSectionGeneral: "Общие",
            .settingsSectionAppearance: "Внешний вид и поведение",
            .settingsSectionTitles: "Названия приложений",
            .settingsSectionPerformance: "Производительность",
            .settingsSectionDevelopment: "Разработка",
            .settingsSectionAbout: "О приложении",
            .developmentPlaceholderTitle: "Площадка для разработчиков",
            .developmentPlaceholderSubtitle: "Здесь появятся инструменты и экспериментальные возможности.",
            .performancePlaceholderTitle: "Панель производительности",
            .performancePlaceholderSubtitle: "Скоро здесь появятся показатели эффективности."
        ]) { _, new in new }

        var hindiDictionary = builder[.english] ?? [:]
        hindiDictionary[.languagePickerTitle] = "भाषा"
        hindiDictionary[.languageNameSystem] = "सिस्टम का अनुसरण करें"
        hindiDictionary[.languageNameEnglish] = "English"
        hindiDictionary[.languageNameChinese] = "中文"
        hindiDictionary[.languageNameJapanese] = "日本語"
        hindiDictionary[.languageNameFrench] = "Français"
        hindiDictionary[.languageNameSpanish] = "Español"
        hindiDictionary[.languageNameGerman] = "Deutsch"
        hindiDictionary[.languageNameRussian] = "Русский"
        hindiDictionary[.languageNameHindi] = "हिन्दी"

        hindiDictionary.merge([
            .noAppsFound: "कोई ऐप नहीं मिला",
            .searchPlaceholder: "खोजें",
            .renameSearchPlaceholder: "ऐप खोजें",
            .customTitlePlaceholder: "कस्टम नाम दर्ज करें",
            .customTitleHint: "यहाँ ऐप का नाम बदलें; कस्टम नाम आयात या भाषा बदलने पर भी बने रहेंगे।",
            .customTitleDefaultFormat: "डिफ़ॉल्ट: %@",
            .customTitleReset: "डिफ़ॉल्ट बहाल करें",
            .customTitleAddButton: "ऐप जोड़ें",
            .customTitleEmptyTitle: "अभी कोई कस्टम नाम नहीं",
            .customTitleEmptySubtitle: "ऐप चुनें और नया नाम दें; आयात या भाषा बदलने पर भी ये सुरक्षित रहेंगे।",
            .customTitleNoResults: "कोई मेल नहीं मिला",
            .customTitlePickerMessage: "जिस ऐप का नाम बदलना चाहते हैं उसे चुनें।",
            .customTitleEdit: "संपादित करें",
            .customTitleSave: "सहेजें",
            .customTitleCancel: "रद्द करें",
            .customTitleDelete: "हटाएँ",
            .loadingApplications: "ऐप लोड हो रहे हैं…",
            .showFPSOverlay: "FPS दिखाएँ",
            .showFPSOverlayDisclaimer: "अनुमानित मान; वास्तविक फ्रेम दर से भिन्न हो सकता है।",
            .customIconTitle: "ऐप आइकन",
            .customIconChoose: "चुनें…",
            .customIconReset: "डिफ़ॉल्ट आइकन बहाल करें",
            .customIconHint: "512×512 PNG/ICNS फ़ाइल सर्वोत्तम है। बदलाव तुरंत लागू होंगे।",
            .customIconError: "चयनित चित्र लोड नहीं हो सका।",
            .pageIndicatorOffsetLabel: "पेज संकेतक अंतर",
            .appTitle: "LaunchNext",
            .modifiedFrom: "LaunchNow संस्करण 1.3.1 के आधार पर संशोधित",
            .backgroundHint: "पृष्ठभूमि में चलाने के लिए LaunchNext को Dock में रखें या शॉर्टकट से विंडो खोलें",
            .classicMode: "क्लासिक Launchpad (पूर्ण स्क्रीन)",
            .iconSize: "आइकन आकार",
            .iconsPerRow: "प्रति पंक्ति आइकन",
            .rowsPerPage: "प्रति पृष्ठ पंक्तियाँ",
            .iconHorizontalSpacing: "क्षैतिज दूरी",
            .iconVerticalSpacing: "ऊर्ध्वाधर दूरी",
            .labelFontSize: "लेबल फ़ॉन्ट आकार",
            .smaller: "छोटा",
            .larger: "बड़ा",
            .predictDrop: "ड्रॉप स्थान का अनुमान",
            .showLabels: "आइकन के नीचे नाम दिखाएँ",
            .useLocalizedThirdPartyTitles: "लोकलाइज़्ड ऐप नाम उपयोग करें",
            .enableAnimations: "स्लाइड एनीमेशन सक्षम करें",
            .hoverMagnification: "हॉवर बढ़ोतरी",
            .hoverMagnificationScale: "हॉवर स्केल",
            .activePressEffect: "दबाने पर प्रभाव",
            .activePressScale: "दबाव स्केल",
            .animationDurationLabel: "स्लाइड एनीमेशन अवधि",
            .gridSizeChangeWarning: "ग्रिड आकार बदलने पर कुछ आइकन स्थान बदल सकते हैं।",
            .pageIndicatorHint: "यदि बदलाव कम लगे तो पेज संकेतक का अंतर समायोजित करें।",
            .rememberPageTitle: "अंतिम खुला पृष्ठ याद रखें",
            .globalShortcutTitle: "वैश्विक शॉर्टकट",
            .shortcutSetButton: "शॉर्टकट सेट करें",
            .shortcutSaveButton: "सहेजें",
            .shortcutClearButton: "साफ़ करें",
            .shortcutNotSet: "सेट नहीं",
            .shortcutListening: "कुंजी प्रतीक्षा…",
            .shortcutCapturePrompt: "वांछित संयोजन दबाएँ। Esc से रद्द करें।",
            .shortcutNoModifierWarning: "बिना मॉडिफ़ायर अन्य ऐप्स से टकराव हो सकता है।",
            .scrollSensitivity: "स्क्रॉल संवेदनशीलता",
            .low: "कम",
            .high: "उच्च",
            .importSystem: "सिस्टम Launchpad आयात करें",
            .importLegacy: "Legacy (.lmy) आयात करें",
            .importTip: "सुझाव: “सिस्टम Launchpad आयात करें” पर क्लिक कर वर्तमान लेआउट लाएँ।",
            .exportData: "डेटा निर्यात करें",
            .importData: "डेटा आयात करें",
            .refresh: "रिफ़्रेश",
            .resetLayout: "लेआउट रीसेट करें",
            .resetAlertTitle: "क्या लेआउट रीसेट करें?",
            .resetAlertMessage: "यह सभी फ़ोल्डर हटाकर क्रम साफ़ करेगा और ऐप्स को पुनः स्कैन करेगा। सभी कस्टम बदलाव हटेंगे।",
            .resetConfirm: "रीसेट",
            .cancel: "रद्द करें",
            .quit: "बंद करें",
            .appearanceModeTitle: "रूप मोड",
            .appearanceModeFollowSystem: "सिस्टम के अनुसार",
            .appearanceModeLight: "हल्का",
            .appearanceModeDark: "गहरा",
            .folderWindowWidth: "फ़ोल्डर विंडो चौड़ाई",
            .folderWindowHeight: "फ़ोल्डर विंडो ऊँचाई",
            .folderWindowSizeHint: "केवल विंडो मोड में प्रभावी; क्लासिक फुलस्क्रीन में आकार तय रहता है।",
            .versionPrefix: "v",
            .folderNamePlaceholder: "फ़ोल्डर का नाम",
            .viewOnGitHub: "प्रोजेक्ट लिंक खोलें",
            .chooseButton: "चुनें",
            .exportPanelMessage: "LaunchNext डेटा निर्यात करने के लिए फ़ोल्डर चुनें",
            .importPrompt: "आयात करें",
            .importPanelMessage: "वह फ़ोल्डर चुनें जिसे LaunchNext से निर्यात किया गया था",
            .legacyArchivePanelMessage: "Legacy Launchpad आर्काइव (.lmy/.zip) या db फ़ाइल चुनें",
            .importSuccessfulTitle: "आयात सफल",
            .importFailedTitle: "आयात विफल",
            .okButton: "ठीक",
            .checkForUpdates: "अपडेट जाँचें",
            .checkForUpdatesButton: "अपडेट जाँचें",
            .checkingForUpdates: "अपडेट की जाँच हो रही है…",
            .upToDate: "आप नवीनतम संस्करण पर हैं",
            .updateAvailable: "नया अपडेट उपलब्ध",
            .newVersion: "नया संस्करण:",
            .downloadUpdate: "अपडेट डाउनलोड करें",
            .updateCheckFailed: "अपडेट जाँच विफल",
            .tryAgain: "पुनः प्रयास",
            .autoCheckForUpdates: "स्वचालित रूप से अपडेट जाँचें",
            .versionParseError: "संस्करण पार्स त्रुटि",
            .settingsSectionGeneral: "सामान्य",
            .settingsSectionAppearance: "रूप व व्यवहार",
            .settingsSectionTitles: "ऐप नाम",
            .settingsSectionPerformance: "प्रदर्शन",
            .settingsSectionDevelopment: "विकास",
            .settingsSectionAbout: "परिचय",
            .developmentPlaceholderTitle: "डेवलपर प्लेग्राउंड",
            .developmentPlaceholderSubtitle: "आने वाले टूल और प्रयोगात्मक सुविधाओं के लिए आरक्षित।",
            .performancePlaceholderTitle: "प्रदर्शन डैशबोर्ड",
            .performancePlaceholderSubtitle: "जल्द ही मेट्रिक्स यहाँ दिखेंगे।"
        ]) { _, new in new }

        builder[.hindi] = hindiDictionary

        translations = builder
    }

    func localized(_ key: LocalizationKey, language: AppLanguage) -> String {
        let lang = language == .system ? AppLanguage.resolveSystemDefault() : language
        if let value = translations[lang]?[key] {
            return value
        }
        return translations[.english]?[key] ?? key.rawValue
    }

    func languageDisplayName(for language: AppLanguage, displayLanguage: AppLanguage) -> String {
        let resolvedDisplay = displayLanguage == .system ? AppLanguage.resolveSystemDefault() : displayLanguage
        switch language {
        case .system:
            return localized(.languageNameSystem, language: resolvedDisplay)
        case .english:
            return "English"
        case .simplifiedChinese:
            return "中文"
        case .japanese:
            return "日本語"
        case .french:
            return "Français"
        case .spanish:
            return "Español"
        case .german:
            return "Deutsch"
        case .russian:
            return "Русский"
        case .hindi:
            return "हिन्दी"
        }
    }
}
