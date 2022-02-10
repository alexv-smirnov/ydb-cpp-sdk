# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: ydb/public/api/grpc/ydb_export_v1.proto 
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from ydb.public.api.protos import ydb_export_pb2 as ydb_dot_public_dot_api_dot_protos_dot_ydb__export__pb2


DESCRIPTOR = _descriptor.FileDescriptor(
  name='ydb/public/api/grpc/ydb_export_v1.proto', 
  package='Ydb.Export.V1',
  syntax='proto3',
  serialized_options=b'\n\030com.yandex.ydb.export.v1',
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\'ydb/public/api/grpc/ydb_export_v1.proto\x12\rYdb.Export.V1\x1a&ydb/public/api/protos/ydb_export.proto2\xa9\x01\n\rExportService\x12K\n\nExportToYt\x12\x1d.Ydb.Export.ExportToYtRequest\x1a\x1e.Ydb.Export.ExportToYtResponse\x12K\n\nExportToS3\x12\x1d.Ydb.Export.ExportToS3Request\x1a\x1e.Ydb.Export.ExportToS3ResponseB\x1a\n\x18\x63om.yandex.ydb.export.v1b\x06proto3'
  ,
  dependencies=[ydb_dot_public_dot_api_dot_protos_dot_ydb__export__pb2.DESCRIPTOR,])



_sym_db.RegisterFileDescriptor(DESCRIPTOR)


DESCRIPTOR._options = None

_EXPORTSERVICE = _descriptor.ServiceDescriptor(
  name='ExportService',
  full_name='Ydb.Export.V1.ExportService',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=99,
  serialized_end=268,
  methods=[
  _descriptor.MethodDescriptor(
    name='ExportToYt',
    full_name='Ydb.Export.V1.ExportService.ExportToYt',
    index=0,
    containing_service=None,
    input_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__export__pb2._EXPORTTOYTREQUEST,
    output_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__export__pb2._EXPORTTOYTRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='ExportToS3',
    full_name='Ydb.Export.V1.ExportService.ExportToS3',
    index=1,
    containing_service=None,
    input_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__export__pb2._EXPORTTOS3REQUEST,
    output_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__export__pb2._EXPORTTOS3RESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_EXPORTSERVICE)

DESCRIPTOR.services_by_name['ExportService'] = _EXPORTSERVICE

# @@protoc_insertion_point(module_scope)
