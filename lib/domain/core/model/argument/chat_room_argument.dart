import '../model_data/detail_product.dart';

class ChatRoomArgument {
  int? chatId;
  int? fromId;
  int? toId;
  String? fromRole;
  String? toRole;
  String? image;
  String? name;
  String? createdAt;
  int? unreadCount;
  Variants? variants;
  String? lifecycle;

  ChatRoomArgument(
      {this.chatId,
      this.fromId,
      this.toId,
      this.fromRole,
      this.toRole,
      this.image,
      this.name,
      this.createdAt,
      this.unreadCount,
      this.variants,
      this.lifecycle});
}
