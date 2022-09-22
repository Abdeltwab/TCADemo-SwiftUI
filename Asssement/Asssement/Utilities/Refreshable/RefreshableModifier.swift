///  ** Credits **
///  Created by Geri Borbás on 14/03/2022.
///  https://blog.eppz.eu/swiftui-pull-to-refresh/
///  https://github.com/Geri-Borbas/iOS.Blog.SwiftUI_Pull_to_Refresh

import SwiftUI


struct RefreshAction {
	
	let action: () async -> Void
	
	func callAsFunction() async {
		await action()
	}
}


struct RefreshActionKey: EnvironmentKey {
	
	static let defaultValue: RefreshAction? = nil
}


extension EnvironmentValues {
	
	var refresh: RefreshAction? {
		get { self[RefreshActionKey.self] }
		set { self[RefreshActionKey.self] = newValue }
	}
}


struct RefreshableModifier: ViewModifier {
	
	let action: () async -> Void
	
	func body(content: Content) -> some View {
		content
			.environment(\.refresh, RefreshAction(action: action))
			.onRefresh { refreshControl in
				Task {
					await action()
					refreshControl.endRefreshing()
				}
			}
	}
}


public extension View {
	
	@available(iOS, obsoleted: 15)
	func refreshable(action: @escaping @Sendable () async -> Void) -> some View {
		self.modifier(RefreshableModifier(action: action))
	}
}
