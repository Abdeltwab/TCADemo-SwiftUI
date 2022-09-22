//
//  AuthenticationView.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

struct AuthenticationView: View {
    var signUpButtonAction: () -> Void
    var loginButtonAction: () -> Void
    
    init(
        signUpButtonAction: @escaping () -> Void,
        loginButtonAction: @escaping () -> Void
    ){
        self.signUpButtonAction = signUpButtonAction
        self.loginButtonAction = loginButtonAction
    }
    
    var body: some View {
        HStack{
            PrimaryButtonView(
                title: AppString.signupTitle,
                isFilled: true) {
                    signUpButtonAction()
                }

            PrimaryButtonView(
                title: AppString.loginTitle,
                isFilled: false) {
                   loginButtonAction()
                }
        }
    }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(
            signUpButtonAction: {},
            loginButtonAction: {})
        .previewLayout(.sizeThatFits)
    }
}
