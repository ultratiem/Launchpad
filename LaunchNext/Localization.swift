import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case system = "system"
    case english = "en"
    case simplifiedChinese = "zh-Hans"
    case japanese = "ja"
    case french = "fr"
    case spanish = "es"

    var id: String { rawValue }

    static func resolveSystemDefault() -> AppLanguage {
        guard let preferred = Locale.preferredLanguages.first else { return .english }
        let lower = preferred.lowercased()
        if lower.hasPrefix("zh") { return .simplifiedChinese }
        if lower.hasPrefix("ja") { return .japanese }
        if lower.hasPrefix("fr") { return .french }
        if lower.hasPrefix("es") { return .spanish }
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
    case smaller
    case larger
    case predictDrop
    case showLabels
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
    case versionPrefix
    case languageNameSystem
    case languageNameEnglish
    case languageNameChinese
    case languageNameJapanese
    case languageNameFrench
    case languageNameSpanish
    case folderNamePlaceholder
    case chooseButton
    case exportPanelMessage
    case importPrompt
    case importPanelMessage
    case legacyArchivePanelMessage
    case importSuccessfulTitle
    case importFailedTitle
    case okButton
}

final class LocalizationManager {
    static let shared = LocalizationManager()

    private let translations: [AppLanguage: [LocalizationKey: String]]

    private init() {
        translations = [
            .english: [
                .noAppsFound: "No apps found",
                .searchPlaceholder: "Search",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Modified from LaunchNow version 1.3.1",
                .backgroundHint: "Automatically run on background: add LaunchNext to dock or use keyboard shortcuts to open the application window",
                .classicMode: "Classic Launchpad (Fullscreen)",
                .iconSize: "Icon size",
                .smaller: "Smaller",
                .larger: "Larger",
                .predictDrop: "Predict drop position",
                .showLabels: "Show labels under icons",
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
                .versionPrefix: "v",
                .languageNameSystem: "Follow System",
                .languageNameEnglish: "英语",
                .languageNameChinese: "中文",
                .languageNameJapanese: "日语",
                .languageNameFrench: "法语",
                .languageNameSpanish: "西班牙语",
                .folderNamePlaceholder: "Folder Name",
                .chooseButton: "Choose",
                .exportPanelMessage: "Choose a destination folder to export LaunchNext data",
                .importPrompt: "Import",
                .importPanelMessage: "Choose a folder previously exported from LaunchNext",
                .legacyArchivePanelMessage: "Choose a legacy Launchpad archive (.lmy/.zip) or a db file",
                .importSuccessfulTitle: "Import Successful",
                .importFailedTitle: "Import Failed",
                .okButton: "OK"
            ],
            .simplifiedChinese: [
                .noAppsFound: "未找到任何应用",
                .searchPlaceholder: "搜索",
                .appTitle: "LaunchNext",
                .modifiedFrom: "基于 LaunchNow 1.3.1 修改",
                .backgroundHint: "保持后台运行：可将 LaunchNext 固定在 Dock 或使用快捷键打开窗口",
                .classicMode: "经典 Launchpad（全屏）",
                .iconSize: "图标大小",
                .smaller: "更小",
                .larger: "更大",
                .predictDrop: "启用落点预判",
                .showLabels: "显示图标文字",
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
                .versionPrefix: "版本 ",
                .languageNameSystem: "跟随系统",
                .languageNameEnglish: "英語",
                .languageNameChinese: "中国語",
                .languageNameJapanese: "日本語",
                .languageNameFrench: "フランス語",
                .languageNameSpanish: "スペイン語",
                .folderNamePlaceholder: "文件夹名称",
                .chooseButton: "选择",
                .exportPanelMessage: "选择一个目标文件夹导出 LaunchNext 数据",
                .importPrompt: "导入",
                .importPanelMessage: "请选择之前由 LaunchNext 导出的文件夹",
                .legacyArchivePanelMessage: "请选择 Legacy Launchpad 归档（.lmy/.zip）或 db 文件",
                .importSuccessfulTitle: "导入成功",
                .importFailedTitle: "导入失败",
                .okButton: "确定"
            ],
            .japanese: [
                .noAppsFound: "アプリが見つかりません",
                .searchPlaceholder: "検索",
                .appTitle: "LaunchNext",
                .modifiedFrom: "LaunchNow 1.3.1 をベースに改良",
                .backgroundHint: "バックグラウンドで実行するには、LaunchNext を Dock に追加するかショートカットで開いてください",
                .classicMode: "クラシック Launchpad（フルスクリーン）",
                .iconSize: "アイコンサイズ",
                .smaller: "小さく",
                .larger: "大きく",
                .predictDrop: "ドロップ位置を予測",
                .showLabels: "アイコン名を表示",
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
                .versionPrefix: "v",
                .languageNameSystem: "システムに従う",
                .languageNameEnglish: "Anglais",
                .languageNameChinese: "Chinois",
                .languageNameJapanese: "Japonais",
                .languageNameFrench: "Français",
                .languageNameSpanish: "Espagnol",
                .folderNamePlaceholder: "フォルダ名",
                .chooseButton: "選択",
                .exportPanelMessage: "LaunchNext のデータを書き出す保存先フォルダを選択してください",
                .importPrompt: "インポート",
                .importPanelMessage: "以前 LaunchNext から書き出したフォルダを選択してください",
                .legacyArchivePanelMessage: "Legacy Launchpad アーカイブ（.lmy/.zip）または db ファイルを選択してください",
                .importSuccessfulTitle: "インポート成功",
                .importFailedTitle: "インポート失敗",
                .okButton: "OK"
            ],
            .french: [
                .noAppsFound: "Aucune app trouvée",
                .searchPlaceholder: "Recherche",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Modifié à partir de LaunchNow 1.3.1",
                .backgroundHint: "Pour l’exécuter en arrière-plan, épinglez LaunchNext au Dock ou utilisez un raccourci clavier pour ouvrir la fenêtre",
                .classicMode: "Launchpad classique (plein écran)",
                .iconSize: "Taille des icônes",
                .smaller: "Plus petit",
                .larger: "Plus grand",
                .predictDrop: "Prédire la position de dépôt",
                .showLabels: "Afficher les étiquettes des icônes",
                .scrollSensitivity: "Sensibilité de défilement",
                .low: "Faible",
                .high: "Élevée",
                .importSystem: "Importer le Launchpad système",
                .importLegacy: "Importer Legacy (.lmy)",
                .importTip: "Astuce : cliquez sur « Importer le Launchpad système » pour récupérer la disposition d’origine.",
                .exportData: "Exporter les données",
                .importData: "Importer des données",
                .refresh: "Actualiser",
                .resetLayout: "Réinitialiser la disposition",
                .resetAlertTitle: "Confirmer la réinitialisation ?",
                .resetAlertMessage: "Toute la disposition sera réinitialisée : dossiers supprimés, ordre effacé et apps rescannées. Toutes les personnalisations seront perdues.",
                .resetConfirm: "Réinitialiser",
                .cancel: "Annuler",
                .quit: "Quitter",
                .languagePickerTitle: "Langue",
                .versionPrefix: "v",
                .languageNameSystem: "Suivre le système",
                .languageNameEnglish: "Inglés",
                .languageNameChinese: "Chino",
                .languageNameJapanese: "Japonés",
                .languageNameFrench: "Francés",
                .languageNameSpanish: "Español",
                .folderNamePlaceholder: "Nom du dossier",
                .chooseButton: "Choisir",
                .exportPanelMessage: "Choisissez un dossier de destination pour exporter les données LaunchNext",
                .importPrompt: "Importer",
                .importPanelMessage: "Sélectionnez un dossier précédemment exporté depuis LaunchNext",
                .legacyArchivePanelMessage: "Sélectionnez une archive Launchpad Legacy (.lmy/.zip) ou un fichier db",
                .importSuccessfulTitle: "Import réussi",
                .importFailedTitle: "Import échoué",
                .okButton: "OK"
            ],
            .spanish: [
                .noAppsFound: "No se encontraron apps",
                .searchPlaceholder: "Buscar",
                .appTitle: "LaunchNext",
                .modifiedFrom: "Modificado a partir de LaunchNow versión 1.3.1",
                .backgroundHint: "Para ejecutarlo en segundo plano, fija LaunchNext en el Dock o usa atajos de teclado para abrir la ventana",
                .classicMode: "Launchpad clásico (pantalla completa)",
                .iconSize: "Tamaño de iconos",
                .smaller: "Más pequeño",
                .larger: "Más grande",
                .predictDrop: "Predecir posición de caída",
                .showLabels: "Mostrar nombres de iconos",
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
                .versionPrefix: "v",
                .languageNameSystem: "Seguir sistema",
                .languageNameEnglish: "English",
                .languageNameChinese: "中文",
                .languageNameJapanese: "日本語",
                .languageNameFrench: "Français",
                .languageNameSpanish: "Español",
                .folderNamePlaceholder: "Nombre de la carpeta",
                .chooseButton: "Elegir",
                .exportPanelMessage: "Elige una carpeta de destino para exportar los datos de LaunchNext",
                .importPrompt: "Importar",
                .importPanelMessage: "Selecciona una carpeta previamente exportada desde LaunchNext",
                .legacyArchivePanelMessage: "Elige un archivo de Launchpad Legacy (.lmy/.zip) o un archivo db",
                .importSuccessfulTitle: "Importación completada",
                .importFailedTitle: "Importación fallida",
                .okButton: "OK"
            ]
        ]
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
        }
    }
}
