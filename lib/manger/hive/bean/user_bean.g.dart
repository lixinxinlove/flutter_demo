// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bean.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBeanAdapter extends TypeAdapter<UserBean> {
  @override
  final int typeId = 0;

  @override
  UserBean read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBean()
      ..userId = fields[0] as int?
      ..name = fields[1] as String?
      ..age = fields[2] as int?
      ..gender = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, UserBean obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBeanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
