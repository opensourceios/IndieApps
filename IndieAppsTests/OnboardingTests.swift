//
//  Copyright © 2020 An Tran. All rights reserved.
//

@testable import IndieApps
import ComposableArchitecture
import Combine
import XCTest

class OnboardingTests: XCTestCase {
    
    let scheduler = DispatchQueue.testScheduler
    
    func testOnboardingSucceed() {
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MockMainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler())
        )
        
        store.assert(
            .send(.startOnboarding) {
                $0.isDataAvailable = false
            },
            .do {
                self.scheduler.advance()
            },
            .receive(.updateContent) {
                $0.isDataAvailable = true
            },
            .do {
                self.scheduler.advance()
            },
            .receive(.endOnboarding) {
                $0.isDataAvailable = true
                $0.snackbarData = SnackbarModifier.SnackbarData.makeSuccess(detail: "Content is ready!")
            }
        )
    }
    
    func testOnboardingFailed() {
        let expectedError = NSError(domain: "SomeError", code: -1, userInfo: nil)
        let store = TestStore(
            initialState: MainState(),
            reducer: mainReducer,
            environment: MockMainEnvironment(
                mainQueue: self.scheduler.eraseToAnyScheduler(),
                onboardingService: MockOnboardingService(unpackContentResult: {
                    Future<OnboardingState, Error>{ $0(.failure(expectedError))}.eraseToAnyPublisher()
                })
            )
        )
        
        store.assert(
            .send(.startOnboarding) {
                $0.isDataAvailable = false
            },
            .do {
                self.scheduler.advance()
            },
            .receive(.showError(expectedError)) {
                $0.snackbarData = SnackbarModifier.SnackbarData.makeError(error: expectedError)
            }
        )
    }
}
