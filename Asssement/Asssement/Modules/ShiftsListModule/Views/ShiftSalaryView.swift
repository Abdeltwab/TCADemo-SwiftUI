//  Created by Abdeltawab Mohamed
//

import SwiftUI

struct ShiftSalaryView: View {
    
    private let backgroundColor: Color
    private let salary: String

    init(
        salary: String,
        backgroundColor: Color = .white
    ) {
        self.salary = salary
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        HStack(spacing: .appSpacing(.xsss)) {
            Text(salary)
        }
        .padding(.all, .appSpacing(.xsss))
        .font(.appFont(.semiBold, relativeTo: .body))
        .background(Color.white.opacity(2.2))
    }
}

struct ShiftSalaryView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftSalaryView(
            salary: "15.00"
        )
        .previewLayout(.sizeThatFits)
    }
}


