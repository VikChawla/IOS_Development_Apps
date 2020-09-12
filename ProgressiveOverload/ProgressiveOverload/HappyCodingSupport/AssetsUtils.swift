#if os(OSX)
    typealias Image     = NSImage
    typealias ImageName = NSImage.Name
#elseif os(iOS)
    import UIKit

    typealias Image     = UIImage
    typealias ImageName = String
#endif

extension Image {
    static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
  //  static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
  //  static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
  //  static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
    static var assetsBeginner: Image { return Image(named: ImageName("beginner"))! }
    static var assetsBlue: Image { return Image(named: ImageName("blue"))! }
    static var assetsBlue2: Image { return Image(named: ImageName("blue2"))! }
    static var assetsCrop: Image { return Image(named: ImageName("crop"))! }
    static var assetsF1: Image { return Image(named: ImageName("f1"))! }
    static var assetsF100: Image { return Image(named: ImageName("f100"))! }
    static var assetsF11: Image { return Image(named: ImageName("f11"))! }
    static var assetsF2: Image { return Image(named: ImageName("f2"))! }
    static var assetsF22: Image { return Image(named: ImageName("f22"))! }
    static var assetsF3: Image { return Image(named: ImageName("f3"))! }
    static var assetsF4: Image { return Image(named: ImageName("f4"))! }
    static var assetsF44: Image { return Image(named: ImageName("f44"))! }
    static var assetsF5: Image { return Image(named: ImageName("f5"))! }
    static var assetsF55: Image { return Image(named: ImageName("f55"))! }
    static var assetsF6: Image { return Image(named: ImageName("f6"))! }
    static var assetsF66: Image { return Image(named: ImageName("f66"))! }
    static var assetsF7: Image { return Image(named: ImageName("f7"))! }
    static var assetsF77: Image { return Image(named: ImageName("f77"))! }
    static var assetsF8: Image { return Image(named: ImageName("f8"))! }
    static var assetsF88: Image { return Image(named: ImageName("f88"))! }
    static var assetsF9: Image { return Image(named: ImageName("f9"))! }
    static var assetsF99: Image { return Image(named: ImageName("f99"))! }
    static var assetsIntermediate: Image { return Image(named: ImageName("Intermediate"))! }
    static var assetsIonIosAdd: Image { return Image(named: ImageName("Ion_ios_add"))! }
    static var assetsIonIosTimer: Image { return Image(named: ImageName("Ion_ios_timer"))! }
    static var assetsItunesartwork: Image { return Image(named: ImageName("iTunesArtwork"))! }
  //  static var assetsItunesartwork: Image { return Image(named: ImageName("iTunesArtwork"))! }
 //   static var assetsItunesartwork: Image { return Image(named: ImageName("iTunesArtwork"))! }
    static var assetsSfPencilTipCropCircleBadgePlus: Image { return Image(named: ImageName("SF_pencil_tip_crop_circle_badge_plus"))! }
    static var assetsSfPlusSquareOnSquareFill: Image { return Image(named: ImageName("SF_plus_square_on_square_fill"))! }
    static var assetsSfPlusSquareOnSquareFill1: Image { return Image(named: ImageName("SF_plus_square_on_square_fill-1"))! }
    static var assetsSfTimer: Image { return Image(named: ImageName("SF_timer"))! }
    static var assetsSfTimer1: Image { return Image(named: ImageName("SF_timer-1"))! }
    static var assetsSfXmarkSquareFill: Image { return Image(named: ImageName("SF_xmark_square_fill"))! }
    static var assetsTrash: Image { return Image(named: ImageName("Trash"))! }
    static var assetsTrashdelete: Image { return Image(named: ImageName("trashDelete"))! }
    static var assetsTrashdelete1: Image { return Image(named: ImageName("trashDelete-1"))! }
    static var assetsTrashdelete2: Image { return Image(named: ImageName("trashDelete-2"))! }
    static var assetsWorkoutstuff: Image { return Image(named: ImageName("workoutStuff"))! }
  //  static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
  //  static var assetsItunesartwork: Image { return Image(named: ImageName("iTunesArtwork"))! }
  //  static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
  //  static var assetsItunesartwork: Image { return Image(named: ImageName("iTunesArtwork"))! }
  //  static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
  //  static var assetsItunesartwork: Image { return Image(named: ImageName("iTunesArtwork"))! }
}
