import NavigationTransitions
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transition"), footer: transitionFooter) {
                    picker("Transition", $appState.transition)
                }

                Section(header: Text("Animation"), footer: animationFooter) {
                    picker("Curve", $appState.animation.curve)
                    picker("Duration", $appState.animation.duration)
                }

                Section(header: Text("Interactivity"), footer: interactivityFooter) {
                    picker("Interactivity", $appState.interactivity)
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Shuffle", action: shuffle),
                trailing: Button(action: dismiss) { Text("Done").bold() }
            )
        }
        .navigationViewStyle(.stack)
    }

    var transitionFooter: some View {
        Text(
            """
            "Swing" is a custom transition exclusive to this demo (only 12 lines of code!).
            """
        )
    }

    var animationFooter: some View {
        Text(
            """
            Note: Duration is ignored when the Spring curve is selected.
            """
        )
    }

    var interactivityFooter: some View {
        Text(
            """
            You can choose the swipe-back gesture to be:

            • Disabled.
            • Edge Pan: recognized from the edge of the screen only.
            • Pan: recognized anywhere on the screen! ✨
            """
        )
    }

    @ViewBuilder
    func picker<Selection: CaseIterable & Hashable & CustomStringConvertible>(
        _ label: String,
        _ selection: Binding<Selection>
    ) -> some View where Selection.AllCases: RandomAccessCollection {
        Picker(
            selection: selection,
            label: Text(label)
        ) {
            ForEach(Selection.allCases, id: \.self) {
                Text($0.description).tag($0)
            }
        }
    }

    func shuffle() {
        appState.transition = .allCases.randomElement()!
        appState.animation.curve = .allCases.randomElement()!
        appState.animation.duration = .allCases.randomElement()!
        appState.interactivity = .allCases.randomElement()!
    }

    func dismiss() {
        appState.isPresentingSettings = false
    }
}

struct SettingsViewPreview: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AppState())
    }
}