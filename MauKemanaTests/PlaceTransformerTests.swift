//
//  PlaceTransformerTests.swift
//
//
//  Created by Moch Fariz Al Hazmi on 13/12/20.
//

import XCTest
@testable import Place

final class PlaceTransformerTests: XCTestCase {
    
    var sut: PlaceTransformer!
    
    override func setUp() {
        sut = PlaceTransformer()
    }
    
    func test_transformResponsesToDomains() {
        // Given
        let placeResponse: PlaceResponse = PlaceResponse(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        )
        let placeResponses: [PlaceResponse] = [placeResponse]
        
        let placeDomainModel: PlaceDomainModel = PlaceDomainModel(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
            favorite: false
        )
        
        // When
        let results = sut.transformResponsesToDomains(responses: placeResponses)
        
        // Then
        XCTAssertEqual(results.count, 1)
        if let result: PlaceDomainModel = results.first as? PlaceDomainModel {
            XCTAssertEqual(result.id, placeDomainModel.id)
            XCTAssertEqual(result.name, placeDomainModel.name)
            XCTAssertEqual(result.description, placeDomainModel.description)
            XCTAssertEqual(result.address, placeDomainModel.address)
            XCTAssertEqual(result.longitude, placeDomainModel.longitude)
            XCTAssertEqual(result.latitude, placeDomainModel.latitude)
            XCTAssertEqual(result.longitude, placeDomainModel.longitude)
            XCTAssertEqual(result.like, placeDomainModel.like)
            XCTAssertEqual(result.image, placeDomainModel.image)
        }
    }
    
    func test_transformResponsesToEntities() {
        // Given
        let placeResponse: PlaceResponse = PlaceResponse(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        )
        let placeResponses: [PlaceResponse] = [placeResponse]
        
        let placeModuleEntity: PlaceModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = 1
        placeModuleEntity.name = "Gunung Bromo"
        placeModuleEntity.desc = "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo."
        placeModuleEntity.address = "Podokoyo, Tosari, Pasuruan"
        placeModuleEntity.longitude = 112.9355026
        placeModuleEntity.latitude = -7.9424931
        placeModuleEntity.like = 8
        placeModuleEntity.image = "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        placeModuleEntity.favorite = false
        
        // When
        let results = sut.transformResponsesToEntities(responses: placeResponses)
        
        // Then
        XCTAssertEqual(results.count, 1)
        if let result: PlaceModuleEntity = results.first as? PlaceModuleEntity {
            XCTAssertEqual(result.id, placeModuleEntity.id)
            XCTAssertEqual(result.name, placeModuleEntity.name)
            XCTAssertEqual(result.desc, placeModuleEntity.desc)
            XCTAssertEqual(result.address, placeModuleEntity.address)
            XCTAssertEqual(result.longitude, placeModuleEntity.longitude)
            XCTAssertEqual(result.latitude, placeModuleEntity.latitude)
            XCTAssertEqual(result.longitude, placeModuleEntity.longitude)
            XCTAssertEqual(result.like, placeModuleEntity.like)
            XCTAssertEqual(result.image, placeModuleEntity.image)
        }
    }
    
    func test_transformEntitiesToDomains() {
        // Given
        let placeModuleEntity: PlaceModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = 1
        placeModuleEntity.name = "Gunung Bromo"
        placeModuleEntity.desc = "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo."
        placeModuleEntity.address = "Podokoyo, Tosari, Pasuruan"
        placeModuleEntity.longitude = 112.9355026
        placeModuleEntity.latitude = -7.9424931
        placeModuleEntity.like = 8
        placeModuleEntity.image = "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        placeModuleEntity.favorite = false
        let placeModuleEntities: [PlaceModuleEntity] = [placeModuleEntity]
        
        let placeDomainModel: PlaceDomainModel = PlaceDomainModel(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
            favorite: false
        )
        
        // When
        let results = sut.transformEntitiesToDomains(
            entities: placeModuleEntities
        )
        
        // Then
        XCTAssertEqual(results.count, 1)
        if let result: PlaceDomainModel = results.first as? PlaceDomainModel {
            XCTAssertEqual(result.id, placeDomainModel.id)
            XCTAssertEqual(result.name, placeDomainModel.name)
            XCTAssertEqual(result.description, placeDomainModel.description)
            XCTAssertEqual(result.address, placeDomainModel.address)
            XCTAssertEqual(result.longitude, placeDomainModel.longitude)
            XCTAssertEqual(result.latitude, placeDomainModel.latitude)
            XCTAssertEqual(result.longitude, placeDomainModel.longitude)
            XCTAssertEqual(result.like, placeDomainModel.like)
            XCTAssertEqual(result.image, placeDomainModel.image)
        }
    }
    
    func test_transformDomainsToEntities() {
        // Given
        let placeDomainModel: PlaceDomainModel = PlaceDomainModel(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
            favorite: false
        )
        let placeDomainModels: [PlaceDomainModel] = [placeDomainModel]
        
        let placeModuleEntity: PlaceModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = 1
        placeModuleEntity.name = "Gunung Bromo"
        placeModuleEntity.desc = "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo."
        placeModuleEntity.address = "Podokoyo, Tosari, Pasuruan"
        placeModuleEntity.longitude = 112.9355026
        placeModuleEntity.latitude = -7.9424931
        placeModuleEntity.like = 8
        placeModuleEntity.image = "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        placeModuleEntity.favorite = false
        
        // When
        let results = sut.transformDomainsToEntities(
            domains: placeDomainModels
        )
        
        // Then
        XCTAssertEqual(results.count, 1)
        if let result: PlaceModuleEntity = results.first as? PlaceModuleEntity {
            XCTAssertEqual(result.id, placeModuleEntity.id)
            XCTAssertEqual(result.name, placeModuleEntity.name)
            XCTAssertEqual(result.desc, placeModuleEntity.desc)
            XCTAssertEqual(result.address, placeModuleEntity.address)
            XCTAssertEqual(result.longitude, placeModuleEntity.longitude)
            XCTAssertEqual(result.latitude, placeModuleEntity.latitude)
            XCTAssertEqual(result.longitude, placeModuleEntity.longitude)
            XCTAssertEqual(result.like, placeModuleEntity.like)
            XCTAssertEqual(result.image, placeModuleEntity.image)
        }
    }
    
    func test_transformEntityToDomain() {
        // Given
        let placeModuleEntity: PlaceModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = 1
        placeModuleEntity.name = "Gunung Bromo"
        placeModuleEntity.desc = "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo."
        placeModuleEntity.address = "Podokoyo, Tosari, Pasuruan"
        placeModuleEntity.longitude = 112.9355026
        placeModuleEntity.latitude = -7.9424931
        placeModuleEntity.like = 8
        placeModuleEntity.image = "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        placeModuleEntity.favorite = false
        
        let placeDomainModel: PlaceDomainModel = PlaceDomainModel(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
            favorite: false
        )
        
        // When
        let result = sut.transformEntityToDomain(
            entity: placeModuleEntity
        )
        
        // Then
        XCTAssertEqual(result.id, placeDomainModel.id)
        XCTAssertEqual(result.name, placeDomainModel.name)
        XCTAssertEqual(result.description, placeDomainModel.description)
        XCTAssertEqual(result.address, placeDomainModel.address)
        XCTAssertEqual(result.longitude, placeDomainModel.longitude)
        XCTAssertEqual(result.latitude, placeDomainModel.latitude)
        XCTAssertEqual(result.longitude, placeDomainModel.longitude)
        XCTAssertEqual(result.like, placeDomainModel.like)
        XCTAssertEqual(result.image, placeDomainModel.image)
    }
    
    func test_transformDomainToEntity() {
        // Given
        let placeDomainModel: PlaceDomainModel = PlaceDomainModel(
            id: 1,
            name: "Gunung Bromo",
            description: "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo.",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 8,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
            favorite: false
        )
        
        let placeModuleEntity: PlaceModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = 1
        placeModuleEntity.name = "Gunung Bromo"
        placeModuleEntity.desc = "Gunung Bromo (dari bahasa Sanskerta: Brahma, salah seorang Dewa Utama dalam agama Hindu) atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan berada dalam empat wilayah kabupaten, yakni Kabupaten Probolinggo, Kabupaten Pasuruan, Kabupaten Lumajang, dan Kabupaten Malang. Gunung Bromo terkenal sebagai objek wisata utama di Jawa Timur. Sebagai sebuah objek wisata, Bromo menjadi menarik karena statusnya sebagai gunung berapi yang masih aktif. Gunung Bromo termasuk dalam kawasan Taman Nasional Bromo Tengger Semeru. Bentuk tubuh Gunung Bromo bertautan antara lembah dan ngarai dengan kaldera atau lautan pasir seluas sekitar 10 kilometer persegi. Ia mempunyai sebuah kawah dengan garis tengah ± 800 meter (utara-selatan) dan ± 600 meter (timur-barat). Sedangkan daerah bahayanya berupa lingkaran dengan jari-jari 4 km dari pusat kawah Bromo."
        placeModuleEntity.address = "Podokoyo, Tosari, Pasuruan"
        placeModuleEntity.longitude = 112.9355026
        placeModuleEntity.latitude = -7.9424931
        placeModuleEntity.like = 8
        placeModuleEntity.image = "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
        placeModuleEntity.favorite = false
        
        // When
        let result = sut.transformDomainToEntity(
            domain: placeDomainModel
        )
        
        // Then
        XCTAssertEqual(result.id, placeModuleEntity.id)
        XCTAssertEqual(result.name, placeModuleEntity.name)
        XCTAssertEqual(result.desc, placeModuleEntity.desc)
        XCTAssertEqual(result.address, placeModuleEntity.address)
        XCTAssertEqual(result.longitude, placeModuleEntity.longitude)
        XCTAssertEqual(result.latitude, placeModuleEntity.latitude)
        XCTAssertEqual(result.longitude, placeModuleEntity.longitude)
        XCTAssertEqual(result.like, placeModuleEntity.like)
        XCTAssertEqual(result.image, placeModuleEntity.image)
    }
    
}
