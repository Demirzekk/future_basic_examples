// enumlar bizim için bir olayı veya durumu işaretlememize yardımcı olur
const String userAvatar = "https://picsum.photos/800";
const String errorImage =
    "https://www.shutterstock.com/image-vector/caution-exclamation-mark-white-red-260nw-1055269061.jpg";
const String loadingImage =
    "https://media.istockphoto.com/id/1302436594/video/loading-circle-icon-animation-on-white-background-4k-video-loopable-preloader.jpg?s=640x640&k=20&c=JQzv8UsXNfUnqQSULYW8B858UOM2O5CoXRgG9a0hRFk=";
const String image =
    "https://cdn1.vectorstock.com/i/1000x1000/50/20/no-photo-or-blank-image-icon-loading-images-vector-37375020.jpg";

enum StatusEnum { idle, waiting, success, failure }

extension StatusEnumX on StatusEnum {
  translateStatusEnum() {
    switch (this) {
      case StatusEnum.idle:
        return "Bağlanmak için dokunun";
      case StatusEnum.waiting:
        return "Bağlantı Bekliyor";
      case StatusEnum.success:
        return "Bağlandı";
      case StatusEnum.failure:
        return "Bir hata meydana geldi";

      default:
        return "Null Status";
    }
  }
}

extension StatusImageX on StatusEnum {
  statusToImageUrl() {
    switch (this) {
      case StatusEnum.idle:
        return image;
      case StatusEnum.waiting:
        return loadingImage;
      case StatusEnum.success:
        return userAvatar;
      case StatusEnum.failure:
        return errorImage;

      default:
        return image;
    }
  }
}
