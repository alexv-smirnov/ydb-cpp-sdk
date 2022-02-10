# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: ydb/public/api/protos/draft/persqueue_error_codes.proto 
"""Generated protocol buffer code."""
from google.protobuf.internal import enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='ydb/public/api/protos/draft/persqueue_error_codes.proto', 
  package='NPersQueue.NErrorCode',
  syntax='proto3',
  serialized_options=b'\n\030com.yandex.ydb.persqueue',
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n7ydb/public/api/protos/draft/persqueue_error_codes.proto\x12\x15NPersQueue.NErrorCode*\xef\x04\n\nEErrorCode\x12\x06\n\x02OK\x10\x00\x12\x10\n\x0cINITIALIZING\x10\x01\x12\x0c\n\x08OVERLOAD\x10\x02\x12\x0f\n\x0b\x42\x41\x44_REQUEST\x10\x03\x12\x10\n\x0cWRONG_COOKIE\x10\x04\x12\x14\n\x10SOURCEID_DELETED\x10\x18\x12!\n\x1dWRITE_ERROR_PARTITION_IS_FULL\x10\x05\x12\x1c\n\x18WRITE_ERROR_DISK_IS_FULL\x10\x0f\x12\x1a\n\x16WRITE_ERROR_BAD_OFFSET\x10\x13\x12!\n\x1d\x43REATE_SESSION_ALREADY_LOCKED\x10\x06\x12\x1d\n\x19\x44\x45LETE_SESSION_NO_SESSION\x10\x07\x12\x1a\n\x16READ_ERROR_IN_PROGRESS\x10\x08\x12\x19\n\x15READ_ERROR_NO_SESSION\x10\t\x12\x10\n\x0cREAD_TIMEOUT\x10\n\x12\x1f\n\x1bREAD_ERROR_TOO_SMALL_OFFSET\x10\x0b\x12\x1d\n\x19READ_ERROR_TOO_BIG_OFFSET\x10\x0c\x12%\n!SET_OFFSET_ERROR_COMMIT_TO_FUTURE\x10\r\x12\x15\n\x11TABLET_IS_DROPPED\x10\x0e\x12\x11\n\rREAD_NOT_DONE\x10\x10\x12\x11\n\rUNKNOWN_TOPIC\x10\x11\x12\x11\n\rACCESS_DENIED\x10\x12\x12\x14\n\x10\x43LUSTER_DISABLED\x10\x14\x12\x1a\n\x16WRONG_PARTITION_NUMBER\x10\x15\x12\x12\n\x0e\x43REATE_TIMEOUT\x10\x16\x12\x10\n\x0cIDLE_TIMEOUT\x10\x17\x12\t\n\x05\x45RROR\x10\x64\x42\x1a\n\x18\x63om.yandex.ydb.persqueueb\x06proto3'
)

_EERRORCODE = _descriptor.EnumDescriptor(
  name='EErrorCode',
  full_name='NPersQueue.NErrorCode.EErrorCode',
  filename=None,
  file=DESCRIPTOR,
  create_key=_descriptor._internal_create_key,
  values=[
    _descriptor.EnumValueDescriptor(
      name='OK', index=0, number=0,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='INITIALIZING', index=1, number=1,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='OVERLOAD', index=2, number=2,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='BAD_REQUEST', index=3, number=3,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='WRONG_COOKIE', index=4, number=4,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='SOURCEID_DELETED', index=5, number=24,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='WRITE_ERROR_PARTITION_IS_FULL', index=6, number=5,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='WRITE_ERROR_DISK_IS_FULL', index=7, number=15,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='WRITE_ERROR_BAD_OFFSET', index=8, number=19,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='CREATE_SESSION_ALREADY_LOCKED', index=9, number=6,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='DELETE_SESSION_NO_SESSION', index=10, number=7,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_ERROR_IN_PROGRESS', index=11, number=8,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_ERROR_NO_SESSION', index=12, number=9,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_TIMEOUT', index=13, number=10,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_ERROR_TOO_SMALL_OFFSET', index=14, number=11,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_ERROR_TOO_BIG_OFFSET', index=15, number=12,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='SET_OFFSET_ERROR_COMMIT_TO_FUTURE', index=16, number=13,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='TABLET_IS_DROPPED', index=17, number=14,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='READ_NOT_DONE', index=18, number=16,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='UNKNOWN_TOPIC', index=19, number=17,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='ACCESS_DENIED', index=20, number=18,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='CLUSTER_DISABLED', index=21, number=20,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='WRONG_PARTITION_NUMBER', index=22, number=21,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='CREATE_TIMEOUT', index=23, number=22,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='IDLE_TIMEOUT', index=24, number=23,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='ERROR', index=25, number=100,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
  ],
  containing_type=None,
  serialized_options=None,
  serialized_start=83,
  serialized_end=706,
)
_sym_db.RegisterEnumDescriptor(_EERRORCODE)

EErrorCode = enum_type_wrapper.EnumTypeWrapper(_EERRORCODE)
OK = 0
INITIALIZING = 1
OVERLOAD = 2
BAD_REQUEST = 3
WRONG_COOKIE = 4
SOURCEID_DELETED = 24
WRITE_ERROR_PARTITION_IS_FULL = 5
WRITE_ERROR_DISK_IS_FULL = 15
WRITE_ERROR_BAD_OFFSET = 19
CREATE_SESSION_ALREADY_LOCKED = 6
DELETE_SESSION_NO_SESSION = 7
READ_ERROR_IN_PROGRESS = 8
READ_ERROR_NO_SESSION = 9
READ_TIMEOUT = 10
READ_ERROR_TOO_SMALL_OFFSET = 11
READ_ERROR_TOO_BIG_OFFSET = 12
SET_OFFSET_ERROR_COMMIT_TO_FUTURE = 13
TABLET_IS_DROPPED = 14
READ_NOT_DONE = 16
UNKNOWN_TOPIC = 17
ACCESS_DENIED = 18
CLUSTER_DISABLED = 20
WRONG_PARTITION_NUMBER = 21
CREATE_TIMEOUT = 22
IDLE_TIMEOUT = 23
ERROR = 100


DESCRIPTOR.enum_types_by_name['EErrorCode'] = _EERRORCODE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)


DESCRIPTOR._options = None
# @@protoc_insertion_point(module_scope)
