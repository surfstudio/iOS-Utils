//
//  GeolocationServiceTests.swift
//  UtilsTests
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Utils

final class GeolocationServiceTests: XCTestCase {

    // MARK: - Tests

    func testAuthRequest() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var successedCount = 0
        manager.currentStatus = .authorizedWhenInUse
        service.requestAuthorization { result in
            switch result {
            case .success:
                successedCount += 1
            default:
                break
            }
        }
        manager.sendAuthEvent()
        XCTAssertEqual(successedCount, 1)
    }

    func testManyAuthRequests() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var successedCount = 0
        manager.currentStatus = .authorizedWhenInUse
        let block: GeolocationAuthCompletion = { result in
            switch result {
            case .success:
                successedCount += 1
            default:
                break
            }
        }
        service.requestAuthorization(block)
        service.requestAuthorization(block)
        service.requestAuthorization(block)
        manager.sendAuthEvent()
        XCTAssertEqual(successedCount, 3)
    }

    func testRequestOnAuthStatus() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var successedCount = 0
        manager.currentStatus = .notDetermined
        let block: GeolocationAuthCompletion = { result in
            switch result {
            case .requesting:
                successedCount += 1
            default:
                break
            }
        }
        service.requestAuthorization(block)
        service.requestAuthorization(block)
        service.requestAuthorization(block)
        XCTAssertEqual(successedCount, 3)
    }

    func testDeniedAuthStatus() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var successedCount = 0
        manager.currentStatus = .denied
        service.requestAuthorization { result in
            switch result {
            case .denied:
                successedCount += 1
            default:
                break
            }
        }
        XCTAssertEqual(successedCount, 1)
    }

    func testRequestSavingOnNotDeterminedStatus() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var requestingCount = 0
        var failuresCount = 0
        var successCount = 0
        manager.currentStatus = .notDetermined
        let block: GeolocationAuthCompletion = { result in
            switch result {
            case .requesting:
                requestingCount += 1
            case .failure:
                failuresCount += 1
            case .success:
                successCount += 1
            default:
                break
            }
        }

        service.requestAuthorization(block)
        service.requestAuthorization(block)
        service.requestAuthorization(block)
        XCTAssertEqual(requestingCount, 3)
        XCTAssertEqual(failuresCount, 0)
        XCTAssertEqual(successCount, 0)

        manager.sendAuthEvent()
        XCTAssertEqual(requestingCount, 3)
        XCTAssertEqual(failuresCount, 0)
        XCTAssertEqual(successCount, 0)

        manager.currentStatus = .authorizedWhenInUse
        manager.sendAuthEvent()
        XCTAssertEqual(requestingCount, 3)
        XCTAssertEqual(failuresCount, 0)
        XCTAssertEqual(successCount, 3)
    }

    func testFailureAuthStatus() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var successedCount = 0
        manager.currentStatus = .notDetermined
        service.requestAuthorization { result in
            switch result {
            case .failure:
                successedCount += 1
            default:
                break
            }
        }
        manager.currentStatus = .denied
        manager.sendAuthEvent()
        XCTAssertEqual(successedCount, 1)
    }

    func testFullAuthCase() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var responses: [GeolocationAuthResult] = []
        manager.currentStatus = .notDetermined
        service.requestAuthorization { result in
            responses.append(result)
        }
        manager.currentStatus = .authorizedWhenInUse
        manager.sendAuthEvent()
        guard responses.count == 2 else {
            XCTFail()
            return
        }
        XCTAssertEqual(responses[0], .requesting)
        XCTAssertEqual(responses[1], .success)
    }

    func testLocationRequest() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var location: CLLocation?
        manager.currentStatus = .authorizedWhenInUse
        service.getCurrentLocation { result in
            switch result {
            case .success(let newLocation):
                location = newLocation
            default:
                break
            }
        }
        manager.sendLocationEvent()
        XCTAssertNotNil(location)
    }

    func testEmptyLocationRequest() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var location: CLLocation?
        manager.currentStatus = .authorizedWhenInUse
        service.getCurrentLocation { result in
            switch result {
            case .success(let newLocation):
                location = newLocation
            default:
                break
            }
        }
        manager.sendEmptyLocationEvent()
        XCTAssertNil(location)
    }

    func testManyLocationRequests() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var location: CLLocation?
        var locationUpdatesCount = 0
        manager.currentStatus = .authorizedWhenInUse
        let block: GeolocationCompletion = { result in
            switch result {
            case .success(let newLocation):
                if let currentLocation = location {
                    XCTAssertEqual(currentLocation, newLocation)
                }
                location = newLocation
                locationUpdatesCount += 1
            default:
                break
            }
        }
        service.getCurrentLocation(block)
        service.getCurrentLocation(block)
        service.getCurrentLocation(block)
        manager.sendLocationEvent()
        XCTAssertEqual(locationUpdatesCount, 3)
    }

    func testDeniedLocationRequest() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var result: GeolocationResult?
        manager.currentStatus = .denied
        service.getCurrentLocation { serviceResult in
            result = serviceResult
        }
        XCTAssertEqual(result, .denied)
    }

    func testFailureLocationRequest() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        var result: GeolocationResult?
        manager.currentStatus = .authorizedWhenInUse
        service.getCurrentLocation { serviceResult in
            result = serviceResult
        }
        manager.sendErrorEvent()
        XCTAssertEqual(result, .error)
    }

    func testRequestAuthCall() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        XCTAssertFalse(manager.requestOnAuthIsInvoked)
        manager.currentStatus = .notDetermined
        service.requestAuthorization { _ in
        }
        XCTAssertTrue(manager.requestOnAuthIsInvoked)
    }

    func testUpdatingMethodsCalls() {
        let manager = LocationManagerMock()
        let service = GeolocationService(manager: manager)

        XCTAssertFalse(manager.updatingIsEnabled)
        manager.currentStatus = .authorizedWhenInUse
        service.getCurrentLocation { _ in
        }
        XCTAssertTrue(manager.updatingIsEnabled)
        manager.sendLocationEvent()
        XCTAssertFalse(manager.updatingIsEnabled)
    }

}

// MARK: - MockError

enum MockError: Error {
    case `default`
}

// MARK: - LocationManagerMock

final class LocationManagerMock: LocationManagerInterface {

    // MARK: - Properties

    var currentStatus: CLAuthorizationStatus = .denied
    var updatingIsEnabled = false
    var requestOnAuthIsInvoked = false
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyHundredMeters

    // MARK: - LocationManagerInterface

    weak var delegate: CLLocationManagerDelegate?
    var status: CLAuthorizationStatus {
        return currentStatus
    }

    func requestLocation() {
        updatingIsEnabled = true
    }

    func requestWhenInUseAuthorization() {
        requestOnAuthIsInvoked = true
    }

    // MARK: - Internal Methods

    func sendErrorEvent() {
        delegate?.locationManager?(CLLocationManager(),
                                   didFailWithError: MockError.default)
        updatingIsEnabled = false
    }

    func sendLocationEvent() {
        delegate?.locationManager?(CLLocationManager(),
                                   didUpdateLocations: [CLLocation(latitude: 12,
                                                                   longitude: 12)])
        updatingIsEnabled = false
    }

    func sendEmptyLocationEvent() {
        delegate?.locationManager?(CLLocationManager(),
                                   didUpdateLocations: [])
        updatingIsEnabled = false
    }

    func sendAuthEvent() {
        delegate?.locationManager?(CLLocationManager(),
                                   didChangeAuthorization: currentStatus)
    }

}
