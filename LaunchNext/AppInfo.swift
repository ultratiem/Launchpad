import Foundation
import AppKit
import CoreServices

struct AppInfo: Identifiable, Equatable, Hashable {
    let name: String
    let icon: NSImage
    let url: URL

    // 使用应用路径作为稳定唯一标识
    var id: String { url.path }

    static func == (lhs: AppInfo, rhs: AppInfo) -> Bool {
        lhs.url == rhs.url
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(url.path)
    }

    // MARK: - 创建 AppInfo
    static func from(url: URL, preferredName: String? = nil, customTitle: String? = nil) -> AppInfo {
        let fallbackName = normalizeCandidate(url.deletingPathExtension().lastPathComponent)
        let bundle = Bundle(url: url)
        let localizedName = localizedAppName(for: url,
                                             preferredName: preferredName,
                                             fallbackName: fallbackName,
                                             bundle: bundle)
        let englishName = englishAppName(preferredName: preferredName,
                                         fallbackName: fallbackName,
                                         bundle: bundle)

        let shouldUseLocalized = shouldUseLocalizedTitles()
        let chosenName = shouldUseLocalized ? localizedName : englishName
        let icon = NSWorkspace.shared.icon(forFile: url.path)

        if let override = customTitle.flatMap({ title -> String? in
            let normalized = normalizeCandidate(title)
            return normalized.isEmpty ? nil : normalized
        }) {
            return AppInfo(name: override, icon: icon, url: url)
        }

        return AppInfo(name: chosenName, icon: icon, url: url)
    }

    // MARK: - 获取本地化应用名
    private static func localizedAppName(for url: URL,
                                         preferredName: String?,
                                         fallbackName: String,
                                         bundle: Bundle?) -> String {
        var resolvedName: String? = nil

        func consider(_ rawValue: String?, source: String) {
            guard let rawValue = rawValue else {
                return
            }
            let normalized = normalizeCandidate(rawValue)
            if normalized.isEmpty {
                return
            }
            guard resolvedName == nil else { return }
            if normalized != fallbackName {
                resolvedName = normalized
            }
        }

        consider(preferredName, source: "preferredName")

        if let metadataItem = NSMetadataItem(url: url) {
            if let displayName = metadataItem.value(forAttribute: kMDItemDisplayName as String) as? String {
                consider(displayName, source: "MDItemDisplayName")
            }

            let alternateNamesKey = "kMDItemAlternateNames"
            if let alternatesValue = metadataItem.value(forAttribute: alternateNamesKey) {
                if let names = alternatesValue as? [String] {
                    for name in names { consider(name, source: "MDItemAlternateNames") }
                } else if let names = alternatesValue as? NSArray {
                    for case let name as String in names { consider(name, source: "MDItemAlternateNames") }
                }
            }
        }

        if let bundle {
            consider(localizedInfoValue(for: "CFBundleDisplayName", in: bundle), source: "InfoPlist.strings CFBundleDisplayName")
            consider(localizedInfoValue(for: "CFBundleName", in: bundle), source: "InfoPlist.strings CFBundleName")
            consider(bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String, source: "Info.plist CFBundleDisplayName")
            consider(bundle.object(forInfoDictionaryKey: "CFBundleName") as? String, source: "Info.plist CFBundleName")
        }

        let resourceValues = try? url.resourceValues(forKeys: [.localizedNameKey])
        consider(resourceValues?.localizedName, source: "resourceValues.localizedName")

        if let components = FileManager.default.componentsToDisplay(forPath: url.path) {
            consider(components.last, source: "FileManager.componentsToDisplay.last")
        }

        var unmanagedName: Unmanaged<CFString>?
        let lsStatus = LSCopyDisplayNameForURL(url as CFURL, &unmanagedName)
        if lsStatus == noErr, let cfName = unmanagedName?.takeRetainedValue() as String? {
            consider(cfName, source: "LSCopyDisplayNameForURL")
        }

        consider(FileManager.default.displayName(atPath: url.path), source: "FileManager.displayName")

        if resolvedName == nil {
            // Fall back to the persisted title only when we fail to resolve a localized display name.
            consider(preferredName, source: "preferredName")
        }

        return resolvedName ?? fallbackName
    }

    private static func englishAppName(preferredName: String?,
                                       fallbackName: String,
                                       bundle: Bundle?) -> String {
        var candidates: [String] = []

        if let bundle {
            let englishLocales = ["en", "en-US", "en-GB"]
            for locale in englishLocales {
                if let path = bundle.path(forResource: "InfoPlist",
                                           ofType: "strings",
                                           inDirectory: nil,
                                           forLocalization: locale),
                   let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                    for key in ["CFBundleDisplayName", "CFBundleName"] {
                        if let value = dict[key], !value.isEmpty {
                            candidates.append(value)
                        }
                    }
                }
            }

            for key in ["CFBundleDisplayName", "CFBundleName"] {
                if let value = bundle.infoDictionary?[key] as? String, !value.isEmpty {
                    candidates.append(value)
                }
            }
        }

        if let preferredName, !preferredName.isEmpty {
            candidates.append(preferredName)
        }

        for raw in candidates {
            let normalized = normalizeCandidate(raw)
            if !normalized.isEmpty {
                return normalized
            }
        }

        return fallbackName
    }

    private static func shouldUseLocalizedTitles() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "useLocalizedThirdPartyTitles") == nil {
            return true
        }
        return defaults.bool(forKey: "useLocalizedThirdPartyTitles")
    }

    private static func normalizeCandidate(_ value: String) -> String {
        var trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.lowercased().hasSuffix(".app") {
            trimmed = String(trimmed.dropLast(4))
        }
        return trimmed
    }

    private static func localizedInfoValue(for key: String, in bundle: Bundle) -> String? {
        let preferred = Bundle.preferredLocalizations(from: bundle.localizations, forPreferences: Locale.preferredLanguages)
        let development = bundle.developmentLocalization.map { [$0] } ?? []
        let candidates = preferred + development + bundle.localizations

        for locale in candidates {
            if let path = bundle.path(forResource: "InfoPlist", ofType: "strings", inDirectory: nil, forLocalization: locale),
               let dict = NSDictionary(contentsOfFile: path),
               let value = dict[key] as? String,
               !value.isEmpty {
                return value
            }
        }

        if let localizedInfo = bundle.localizedInfoDictionary,
           let value = localizedInfo[key] as? String,
           !value.isEmpty {
            return value
        }
        return nil
    }
}
