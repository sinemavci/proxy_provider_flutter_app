// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterModelAdapter extends TypeAdapter<FilterModel> {
  @override
  final int typeId = 1;

  @override
  FilterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterModel(
      type: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FilterModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
