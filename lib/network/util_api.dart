import 'package:tang_network/tang_network.dart';
import 'package:tang_util/review/review_model.dart';

class UtilApi {
  /// Uploading single file.
  Future<Map<String, dynamic>> uploadingSingle(List<int> bytes) {
    return NetworkHttp.shared.upload(
      '/dy/other/uploadFile',
      type: FileUploadingType.multipleFileData,
      fileBytes: [bytes],
      fileKey: 'uploadFile',
    );
  }

  /// Review json.
  Future<UtilReviewModel> getReviewInfo(String reviewJsonUrl) {
    return NetworkHttp.shared
        .request(
          reviewJsonUrl,
          {},
          method: NetworkMethodType.get,
          absoluteUrl: true,
          isSimpleResponse: true,
          needsAutoSetupDeviceInfo: false,
        )
        .then((resp) => UtilReviewModel.fromJson(resp));
  }
}
