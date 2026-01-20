//
//  MusicResource.swift
//  juke-iOS
//
//  Created by Mario Barrenechea on 3/28/22.
//

import Foundation

protocol MusicResource: Identifiable, Codable {
    var id: Int? { get }
    var spotifyID: String { get }
    var name: String { get }
}

struct Artist: MusicResource {
    let id: Int?
    let spotifyID: String
    let name: String
    let genres: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case spotifyID = "spotify_id"
        case name
        case genres
    }
}

struct Album: MusicResource {
    let id: Int?
    let spotifyID: String
    let name: String
    let artists: [ArtistReference]?
    let totalTracks: Int
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case spotifyID = "spotify_id"
        case name
        case artists
        case totalTracks = "total_tracks"
        case releaseDate = "release_date"
    }
}

enum ArtistReference: Codable, Identifiable {
    case full(Artist)
    case identifier(Int)
    case name(String)

    var id: String {
        switch self {
        case .full(let artist):
            return artist.id.map(String.init) ?? artist.spotifyID
        case .identifier(let identifier):
            return String(identifier)
        case .name(let name):
            return name
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let artist = try? container.decode(Artist.self) {
            self = .full(artist)
        } else if let identifier = try? container.decode(Int.self) {
            self = .identifier(identifier)
        } else if let name = try? container.decode(String.self) {
            self = .name(name)
        } else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unsupported artist reference"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .full(let artist):
            try container.encode(artist)
        case .identifier(let identifier):
            try container.encode(identifier)
        case .name(let name):
            try container.encode(name)
        }
    }
}

struct Track: MusicResource {
    let id: Int?
    let spotifyID: String
    let name: String
    let album: AlbumReference?
    let duration: Int
    let trackNumber: Int
    let explicit: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case spotifyID = "spotify_id"
        case name
        case album
        case duration = "duration_ms"
        case trackNumber = "track_number"
        case explicit
    }
}

enum AlbumReference: Codable, Identifiable {
    case full(Album)
    case identifier(Int)
    case name(String)
    case none

    var id: String {
        switch self {
        case .full(let album):
            return album.id.map(String.init) ?? album.spotifyID
        case .identifier(let identifier):
            return String(identifier)
        case .name(let name):
            return name
        case .none:
            return "none"
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .none
        } else if let album = try? container.decode(Album.self) {
            self = .full(album)
        } else if let identifier = try? container.decode(Int.self) {
            self = .identifier(identifier)
        } else if let name = try? container.decode(String.self) {
            self = .name(name)
        } else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unsupported album reference"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .full(let album):
            try container.encode(album)
        case .identifier(let identifier):
            try container.encode(identifier)
        case .name(let name):
            try container.encode(name)
        case .none:
            try container.encodeNil()
        }
    }
}

struct CatalogResults: Codable {
    let artists: [Artist]
    let albums: [Album]
    let tracks: [Track]
}
