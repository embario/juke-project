import SwiftUI
import UIKit

// MARK: - Tokens

enum JukePalette {
    static let background = Color(hex: "#030712")
    static let panel = Color(hex: "#090f1f")
    static let panelAlt = Color(hex: "#0f172a")
    static let accent = Color(hex: "#f97316")
    static let accentSoft = Color(hex: "#fb923c")
    static let text = Color(hex: "#e2e8f0")
    static let muted = Color(hex: "#94a3b8")
    static let border = Color.white.opacity(0.08)
    static let success = Color(hex: "#16a34a")
    static let warning = Color(hex: "#facc15")
    static let error = Color(hex: "#ef4444")
}

extension Color {
    init(hex: String) {
        let hexValue = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hexValue.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 3:
            let divisor: UInt64 = 17
            (r, g, b) = ((int >> 8) * divisor, (int >> 4 & 0xF) * divisor, (int & 0xF) * divisor)
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}

// MARK: - Background

struct JukeBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [JukePalette.background, JukePalette.panel],
                startPoint: .top,
                endPoint: .bottom
            )
            RadialGradient(
                gradient: Gradient(colors: [Color(hex: "#1e3a8a").opacity(0.6), .clear]),
                center: .topTrailing,
                startRadius: 0,
                endRadius: 400
            )
            RadialGradient(
                gradient: Gradient(colors: [JukePalette.accent.opacity(0.35), .clear]),
                center: .topLeading,
                startRadius: 0,
                endRadius: 350
            )
        }
        .ignoresSafeArea()
    }
}

// MARK: - Card

struct JukeCard<Content: View>: View {
    private let padding: CGFloat
    private let content: Content

    init(padding: CGFloat = 24, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [JukePalette.panel.opacity(0.95), JukePalette.panelAlt.opacity(0.9)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(JukePalette.border, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.45), radius: 35, x: 0, y: 25)
            )
    }
}

// MARK: - Button Style

struct JukeButtonStyle: ButtonStyle {
    enum Variant {
        case primary
        case ghost
        case link
    }

    var variant: Variant = .primary

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(background(isPressed: configuration.isPressed))
            .foregroundColor(foregroundColor)
            .overlay(borderOverlay)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }

    @ViewBuilder
    private func background(isPressed: Bool) -> some View {
        switch variant {
        case .primary:
            LinearGradient(
                colors: [JukePalette.accent, JukePalette.accentSoft],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .brightness(isPressed ? -0.05 : 0)
        case .ghost:
            JukePalette.panelAlt.opacity(isPressed ? 0.7 : 0.5)
        case .link:
            Color.clear
        }
    }

    private var foregroundColor: Color {
        switch variant {
        case .primary:
            return Color(hex: "#0f172a")
        case .ghost:
            return JukePalette.text
        case .link:
            return JukePalette.accent
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        switch variant {
        case .ghost:
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(JukePalette.border, lineWidth: 1)
        case .primary, .link:
            EmptyView()
        }
    }
}

// MARK: - Input Field

struct JukeInputField: View {
    enum FieldKind {
        case text
        case secure
    }

    let label: String
    let placeholder: String
    @Binding var text: String
    var kind: FieldKind = .text
    var keyboard: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .never
    var error: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label.uppercased())
                .font(.caption)
                .foregroundColor(JukePalette.muted)
                .kerning(1.2)
            field
                .textInputAutocapitalization(autocapitalization)
                .keyboardType(keyboard)
                .textContentType(textContentType)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .background(JukePalette.panelAlt.opacity(0.65))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(error == nil ? JukePalette.border : JukePalette.error, lineWidth: 1)
                )
                .cornerRadius(16)
                .foregroundColor(JukePalette.text)
            if let error {
                Text(error)
                    .font(.footnote)
                    .foregroundColor(JukePalette.error)
            }
        }
    }

    @ViewBuilder
    private var field: some View {
        switch kind {
        case .text:
            TextField(placeholder, text: $text)
        case .secure:
            SecureField(placeholder, text: $text)
        }
    }
}

// MARK: - Status Banner

struct JukeStatusBanner: View {
    enum Variant {
        case info
        case success
        case warning
        case error
    }

    var message: String?
    var variant: Variant = .info

    private var palette: (color: Color, background: Color) {
        switch variant {
        case .info:
            return (JukePalette.accent, JukePalette.accent.opacity(0.12))
        case .success:
            return (JukePalette.success, JukePalette.success.opacity(0.18))
        case .warning:
            return (JukePalette.warning, JukePalette.warning.opacity(0.18))
        case .error:
            return (JukePalette.error, JukePalette.error.opacity(0.2))
        }
    }

    var body: some View {
        Group {
            if let message {
                HStack(alignment: .top, spacing: 12) {
                    Circle()
                        .fill(palette.color)
                        .frame(width: 10, height: 10)
                        .shadow(color: palette.color.opacity(0.65), radius: 8)
                        .padding(.top, 6)
                    Text(message)
                        .foregroundColor(JukePalette.text)
                        .font(.subheadline)
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(palette.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(palette.color.opacity(0.35), lineWidth: 1)
                        )
                )
            }
        }
    }
}

// MARK: - Spinner

struct JukeSpinner: View {
    @State private var animate = false

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(JukePalette.accent)
                    .frame(width: 10, height: 10)
                    .scaleEffect(animate ? 1 : 0.6)
                    .opacity(animate ? 1 : 0.4)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever()
                            .delay(Double(index) * 0.15),
                        value: animate
                    )
            }
        }
        .onAppear { animate = true }
        .accessibilityLabel("Loading")
    }
}

// MARK: - Chip

struct JukeChip: View {
    var label: String
    var isActive: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.subheadline)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    Capsule(style: .continuous)
                        .fill(isActive ? JukePalette.accent.opacity(0.18) : Color.clear)
                )
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(isActive ? JukePalette.accent : JukePalette.border, lineWidth: 1)
                )
                .foregroundColor(isActive ? JukePalette.text : JukePalette.muted)
        }
        .buttonStyle(.plain)
    }
}
