//
//  AudioUtil.swift
//  SwiftFFmpeg
//
//  Created by sunlubo on 2018/8/2.
//

import CFFmpeg

// MARK: - Audio Channel

// A channel layout is a 64-bits integer with a bit set for every channel.
// The number of bits set must be equal to the number of channels.
// The value 0 means that the channel layout is not known.
//
// - Note: this data structure is not powerful enough to handle channels
// combinations that have the same channel multiple times, such as dual-mono.

public struct AVChannel: Equatable {
  /// FL
  public static let frontLeft = AVChannel(rawValue: AV_CHAN_FRONT_LEFT.rawValue)
  /// FR
  public static let frontRight = AVChannel(rawValue: AV_CHAN_FRONT_RIGHT.rawValue)
  /// FC
  public static let frontCenter = AVChannel(rawValue: AV_CHAN_FRONT_CENTER.rawValue)
  /// LFE
  public static let lowFrequency = AVChannel(rawValue: AV_CHAN_LOW_FREQUENCY.rawValue)
  /// BL
  public static let backLeft = AVChannel(rawValue: AV_CHAN_BACK_LEFT.rawValue)
  /// BR
  public static let backRight = AVChannel(rawValue: AV_CHAN_BACK_RIGHT.rawValue)
  /// FLC
  public static let frontLeftOfCenter = AVChannel(rawValue: AV_CHAN_FRONT_LEFT_OF_CENTER.rawValue)
  /// FRC
  public static let frontRightOfCenter = AVChannel(rawValue: AV_CHAN_FRONT_RIGHT_OF_CENTER.rawValue)
  /// BC
  public static let backCenter = AVChannel(rawValue: AV_CHAN_BACK_CENTER.rawValue)
  /// SL
  public static let sideLeft = AVChannel(rawValue: AV_CHAN_SIDE_LEFT.rawValue)
  /// SR
  public static let sideRight = AVChannel(rawValue: AV_CHAN_SIDE_RIGHT.rawValue)
  /// TC
  public static let topCenter = AVChannel(rawValue: AV_CHAN_TOP_CENTER.rawValue)
  /// TFL
  public static let topFrontLeft = AVChannel(rawValue: AV_CHAN_TOP_FRONT_LEFT.rawValue)
  /// TFC
  public static let topFrontCenter = AVChannel(rawValue: AV_CHAN_TOP_FRONT_CENTER.rawValue)
  /// TFR
  public static let topFrontRight = AVChannel(rawValue: AV_CHAN_TOP_FRONT_RIGHT.rawValue)
  /// TBL
  public static let topBackLeft = AVChannel(rawValue: AV_CHAN_TOP_BACK_LEFT.rawValue)
  /// TBC
  public static let topBackCenter = AVChannel(rawValue: AV_CHAN_TOP_BACK_CENTER.rawValue)
  /// TBR
  public static let topBackRight = AVChannel(rawValue: AV_CHAN_TOP_BACK_RIGHT.rawValue)
  /// DL
  ///
  /// Stereo downmix.
  public static let stereoLeft = AVChannel(rawValue: AV_CHAN_STEREO_LEFT.rawValue)
  /// DR
  ///
  /// See `stereoLeft`.
  public static let stereoRight = AVChannel(rawValue: AV_CHAN_STEREO_RIGHT.rawValue)
  /// WL
  public static let wideLeft = AVChannel(rawValue: AV_CHAN_WIDE_LEFT.rawValue)
  /// WR
  public static let wideRight = AVChannel(rawValue: AV_CHAN_WIDE_RIGHT.rawValue)
  /// SDL
  public static let surroundDirectLeft = AVChannel(rawValue: AV_CHAN_SURROUND_DIRECT_LEFT.rawValue)
  /// SDR
  public static let surroundDirectRight = AVChannel(rawValue: AV_CHAN_SURROUND_DIRECT_RIGHT.rawValue)
  /// LFE2
  public static let lowFrequency2 = AVChannel(rawValue: AV_CHAN_LOW_FREQUENCY_2.rawValue)

  public let rawValue: UInt64

  public init(rawValue: Int32) { self.rawValue = UInt64(rawValue) }

  /// The name of the audio channel.
  public var name: String {
    String(cString: av_get_channel_name(rawValue))
  }
}

extension AVChannel: CustomStringConvertible {

  public var description: String {
    name
  }
}

// MARK: - Audio Channel Layout

public struct AVChannelLayout: Equatable {
  public static let none = AVChannelLayout(rawValue: 0)
  /// Channel mask value used for `AVCodecContext.request_channel_layout` to indicate that
  /// the user requests the channel order of the decoder output to be the native codec channel order.
  public static let CHL_NATIVE = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_NATIVE)
  /// FC
  public static let CHL_MONO = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_MONO)
  /// FL+FR
  public static let CHL_STEREO = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_STEREO)
  /// FL+FR+LFE
  public static let CHL_2POINT1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_2POINT1)
  /// FL+FR+BC
  public static let CHL_2_1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_2_1)
  /// FL+FR+FC
  public static let CHL_SURROUND = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_SURROUND)
  /// FL+FR+FC+LFE
  public static let CHL_3POINT1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_3POINT1)
  /// FL+FR+FC+BC
  public static let CHL_4POINT0 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_4POINT0)
  /// FL+FR+FC+BC+LFE
  public static let CHL_4POINT1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_4POINT1)
  /// FL+FR+SL+SR
  public static let CHL_2_2 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_2_2)
  /// FL+FR+BL+BR
  public static let CHL_QUAD = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_QUAD)
  /// FL+FR+FC+SL+SR
  public static let CHL_5POINT0 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_5POINT0)
  /// FL+FR+FC+SL+SR+LFE
  public static let CHL_5POINT1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_5POINT1)
  /// FL+FR+FC+BL+BR
  public static let CHL_5POINT0_BACK = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_5POINT0_BACK)
  /// FL+FR+FC+BL+BR+LFE
  public static let CHL_5POINT1_BACK = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_5POINT1_BACK)
  /// FL+FR+SL+SR+FLC+FRC
  public static let CHL_6POINT0 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_6POINT0)
  /// FL+FR+FLC+FRC+SL+SR
  public static let CHL_6POINT0_FRONT = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_6POINT0_FRONT)
  /// FL+FR+FC+BL+BR+BC
  public static let CHL_HEXAGONAL = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_HEXAGONAL)
  /// FL+FR+FC+SL+SR+LFE+BC
  public static let CHL_6POINT1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_6POINT1)
  /// FL+FR+FC+BL+BR+LFE+BC
  public static let CHL_6POINT1_BACK = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_6POINT1_BACK)
  /// FL+FR+FLC+FRC+SL+SR+LFE
  public static let CHL_6POINT1_FRONT = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_6POINT1_FRONT)
  /// FL+FR+FC+SL+SR+BL+BR
  public static let CHL_7POINT0 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_7POINT0)
  /// FL+FR+FC+SL+SR+FLC+FRC
  public static let CHL_7POINT0_FRONT = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_7POINT0_FRONT)
  /// FL+FR+FC+SL+SR+LFE+BL+BR
  public static let CHL_7POINT1 = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_7POINT1)
  /// FL+FR+FC+SL+SR+LFE+FLC+FRC
  public static let CHL_7POINT1_WIDE = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_7POINT1_WIDE)
  /// FL+FR+FC+BL+BR+LFE+FLC+FRC
  public static let CHL_7POINT1_WIDE_BACK = AVChannelLayout(
    rawValue: swift_AV_CH_LAYOUT_7POINT1_WIDE_BACK)
  /// FL+FR+FC+SL+SR+BL+BC+BR
  public static let CHL_OCTAGONAL = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_OCTAGONAL)
  /// FL+FR+FC+SL+SR+BL+BC+BR+WL+WR+TBL+TBR+TBC+TFC+TFL+TFR
  public static let CHL_HEXADECAGONAL = AVChannelLayout(rawValue: swift_AV_CH_LAYOUT_HEXADECAGONAL)
  /// DL+DR
  public static let CHL_STEREO_DOWNMIX = AVChannelLayout(
    rawValue: swift_AV_CH_LAYOUT_STEREO_DOWNMIX)

  public let rawValue: UInt64

  public init(rawValue: UInt64) { self.rawValue = rawValue }

  /// Return a channel layout id that matches name, or `nil` if no match is found.
  ///
  /// - Parameter name: Name can be one or several of the following notations, separated by '+' or '|':
  ///   - the name of an usual channel layout (mono, stereo, 4.0, quad, 5.0, 5.0(side), 5.1, 5.1(side), 7.1,
  ///     7.1(wide), downmix);
  ///   - the name of a single channel (FL, FR, FC, LFE, BL, BR, FLC, FRC, BC, SL, SR, TC, TFL, TFC, TFR, TBL,
  ///     TBC, TBR, DL, DR);
  ///   - a number of channels, in decimal, followed by 'c', yielding the default channel layout for that number
  ////    of channels (@see av_get_default_channel_layout);
  ///   - a channel layout mask, in hexadecimal starting with "0x" (see the AV_CH_* macros).
  ///
  ///     Example: "stereo+FC" = "2c+FC" = "2c+1c" = "0x7"
  public init?(name: String) {
    let layout = av_get_channel_layout(name)
    guard layout != 0 else {
      return nil
    }
    self.init(rawValue: layout)
  }

  /// The number of channels in the channel layout.
  public var channelCount: Int {
    Int(av_get_channel_layout_nb_channels(rawValue))
  }

  /// Get the index of a channel in channel layout.
  ///
  /// - Parameter channel: A channel layout describing exactly one channel which must be present in channel layout.
  /// - Returns: The index of channel in channel layout, `nil` on error.
  public func index(for channel: AVChannel) -> Int? {
    let i = av_get_channel_layout_channel_index(rawValue, channel.rawValue)
    return i >= 0 ? Int(i) : nil
  }

  public func channel(at index: Int32) -> AVChannel {
    AVChannel(rawValue: Int32(av_channel_layout_extract_channel(rawValue, index)))
  }

  /// Get the default channel layout for a given number of channels.
  ///
  /// - Parameter count: The number of channels.
  /// - Returns: AVChannelLayout
  public static func `default`(for count: Int) -> AVChannelLayout {
    AVChannelLayout(rawValue: UInt64(av_get_default_channel_layout(Int32(count))))
  }
}

extension AVChannelLayout: CustomStringConvertible {

  public var description: String {
    let buf = UnsafeMutablePointer<Int8>.allocate(capacity: 256)
    buf.initialize(to: 0)
    defer { buf.deallocate() }
    av_get_channel_layout_string(buf, 256, Int32(channelCount), rawValue)
    return String(cString: buf)
  }
}
