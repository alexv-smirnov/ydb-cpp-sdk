# -*- coding: utf-8 -*- 
# Generated by the protocol buffer compiler.  DO NOT EDIT! 
# source: ydb/public/api/grpc/ydb_discovery_v1.proto
"""Generated protocol buffer code.""" 
from google.protobuf import descriptor as _descriptor 
from google.protobuf import message as _message 
from google.protobuf import reflection as _reflection 
from google.protobuf import symbol_database as _symbol_database 
# @@protoc_insertion_point(imports) 
 
_sym_db = _symbol_database.Default() 
 
 
from ydb.public.api.protos import ydb_discovery_pb2 as ydb_dot_public_dot_api_dot_protos_dot_ydb__discovery__pb2 
 
 
DESCRIPTOR = _descriptor.FileDescriptor( 
  name='ydb/public/api/grpc/ydb_discovery_v1.proto',
  package='Ydb.Discovery.V1', 
  syntax='proto3', 
  serialized_options=b'\n\033com.yandex.ydb.discovery.v1', 
  create_key=_descriptor._internal_create_key, 
  serialized_pb=b'\n*ydb/public/api/grpc/ydb_discovery_v1.proto\x12\x10Ydb.Discovery.V1\x1a)ydb/public/api/protos/ydb_discovery.proto2\xb5\x01\n\x10\x44iscoveryService\x12Z\n\rListEndpoints\x12#.Ydb.Discovery.ListEndpointsRequest\x1a$.Ydb.Discovery.ListEndpointsResponse\x12\x45\n\x06WhoAmI\x12\x1c.Ydb.Discovery.WhoAmIRequest\x1a\x1d.Ydb.Discovery.WhoAmIResponseB\x1d\n\x1b\x63om.yandex.ydb.discovery.v1b\x06proto3' 
  , 
  dependencies=[ydb_dot_public_dot_api_dot_protos_dot_ydb__discovery__pb2.DESCRIPTOR,]) 
 
 
 
_sym_db.RegisterFileDescriptor(DESCRIPTOR) 
 
 
DESCRIPTOR._options = None 
 
_DISCOVERYSERVICE = _descriptor.ServiceDescriptor( 
  name='DiscoveryService', 
  full_name='Ydb.Discovery.V1.DiscoveryService', 
  file=DESCRIPTOR, 
  index=0, 
  serialized_options=None, 
  create_key=_descriptor._internal_create_key, 
  serialized_start=108, 
  serialized_end=289, 
  methods=[ 
  _descriptor.MethodDescriptor( 
    name='ListEndpoints', 
    full_name='Ydb.Discovery.V1.DiscoveryService.ListEndpoints', 
    index=0, 
    containing_service=None, 
    input_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__discovery__pb2._LISTENDPOINTSREQUEST, 
    output_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__discovery__pb2._LISTENDPOINTSRESPONSE, 
    serialized_options=None, 
    create_key=_descriptor._internal_create_key, 
  ), 
  _descriptor.MethodDescriptor( 
    name='WhoAmI', 
    full_name='Ydb.Discovery.V1.DiscoveryService.WhoAmI', 
    index=1, 
    containing_service=None, 
    input_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__discovery__pb2._WHOAMIREQUEST, 
    output_type=ydb_dot_public_dot_api_dot_protos_dot_ydb__discovery__pb2._WHOAMIRESPONSE, 
    serialized_options=None, 
    create_key=_descriptor._internal_create_key, 
  ), 
]) 
_sym_db.RegisterServiceDescriptor(_DISCOVERYSERVICE) 
 
DESCRIPTOR.services_by_name['DiscoveryService'] = _DISCOVERYSERVICE 
 
# @@protoc_insertion_point(module_scope) 
