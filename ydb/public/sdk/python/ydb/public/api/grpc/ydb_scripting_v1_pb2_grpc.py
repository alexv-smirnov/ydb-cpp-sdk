# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT! 
"""Client and server classes corresponding to protobuf-defined services.""" 
import grpc 
 
from ydb.public.api.protos import ydb_scripting_pb2 as ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2 
 
 
class ScriptingServiceStub(object): 
    """Missing associated documentation comment in .proto file.""" 
 
    def __init__(self, channel): 
        """Constructor. 
 
        Args: 
            channel: A grpc.Channel. 
        """ 
        self.ExecuteYql = channel.unary_unary( 
                '/Ydb.Scripting.V1.ScriptingService/ExecuteYql', 
                request_serializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlRequest.SerializeToString, 
                response_deserializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlResponse.FromString, 
                ) 
        self.StreamExecuteYql = channel.unary_stream( 
                '/Ydb.Scripting.V1.ScriptingService/StreamExecuteYql', 
                request_serializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlRequest.SerializeToString, 
                response_deserializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlPartialResponse.FromString, 
                ) 
        self.ExplainYql = channel.unary_unary( 
                '/Ydb.Scripting.V1.ScriptingService/ExplainYql', 
                request_serializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExplainYqlRequest.SerializeToString, 
                response_deserializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExplainYqlResponse.FromString, 
                ) 
 
 
class ScriptingServiceServicer(object): 
    """Missing associated documentation comment in .proto file.""" 
 
    def ExecuteYql(self, request, context): 
        """Missing associated documentation comment in .proto file.""" 
        context.set_code(grpc.StatusCode.UNIMPLEMENTED) 
        context.set_details('Method not implemented!') 
        raise NotImplementedError('Method not implemented!') 
 
    def StreamExecuteYql(self, request, context): 
        """Executes yql request with streaming result. 
        """ 
        context.set_code(grpc.StatusCode.UNIMPLEMENTED) 
        context.set_details('Method not implemented!') 
        raise NotImplementedError('Method not implemented!') 
 
    def ExplainYql(self, request, context): 
        """Missing associated documentation comment in .proto file.""" 
        context.set_code(grpc.StatusCode.UNIMPLEMENTED) 
        context.set_details('Method not implemented!') 
        raise NotImplementedError('Method not implemented!') 
 
 
def add_ScriptingServiceServicer_to_server(servicer, server): 
    rpc_method_handlers = { 
            'ExecuteYql': grpc.unary_unary_rpc_method_handler( 
                    servicer.ExecuteYql, 
                    request_deserializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlRequest.FromString, 
                    response_serializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlResponse.SerializeToString, 
            ), 
            'StreamExecuteYql': grpc.unary_stream_rpc_method_handler( 
                    servicer.StreamExecuteYql, 
                    request_deserializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlRequest.FromString, 
                    response_serializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlPartialResponse.SerializeToString, 
            ), 
            'ExplainYql': grpc.unary_unary_rpc_method_handler( 
                    servicer.ExplainYql, 
                    request_deserializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExplainYqlRequest.FromString, 
                    response_serializer=ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExplainYqlResponse.SerializeToString, 
            ), 
    } 
    generic_handler = grpc.method_handlers_generic_handler( 
            'Ydb.Scripting.V1.ScriptingService', rpc_method_handlers) 
    server.add_generic_rpc_handlers((generic_handler,)) 
 
 
 # This class is part of an EXPERIMENTAL API. 
class ScriptingService(object): 
    """Missing associated documentation comment in .proto file.""" 
 
    @staticmethod 
    def ExecuteYql(request, 
            target, 
            options=(), 
            channel_credentials=None, 
            call_credentials=None, 
            insecure=False, 
            compression=None, 
            wait_for_ready=None, 
            timeout=None, 
            metadata=None): 
        return grpc.experimental.unary_unary(request, target, '/Ydb.Scripting.V1.ScriptingService/ExecuteYql', 
            ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlRequest.SerializeToString, 
            ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlResponse.FromString, 
            options, channel_credentials, 
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata) 
 
    @staticmethod 
    def StreamExecuteYql(request, 
            target, 
            options=(), 
            channel_credentials=None, 
            call_credentials=None, 
            insecure=False, 
            compression=None, 
            wait_for_ready=None, 
            timeout=None, 
            metadata=None): 
        return grpc.experimental.unary_stream(request, target, '/Ydb.Scripting.V1.ScriptingService/StreamExecuteYql', 
            ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlRequest.SerializeToString, 
            ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExecuteYqlPartialResponse.FromString, 
            options, channel_credentials, 
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata) 
 
    @staticmethod 
    def ExplainYql(request, 
            target, 
            options=(), 
            channel_credentials=None, 
            call_credentials=None, 
            insecure=False, 
            compression=None, 
            wait_for_ready=None, 
            timeout=None, 
            metadata=None): 
        return grpc.experimental.unary_unary(request, target, '/Ydb.Scripting.V1.ScriptingService/ExplainYql', 
            ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExplainYqlRequest.SerializeToString, 
            ydb_dot_public_dot_api_dot_protos_dot_ydb__scripting__pb2.ExplainYqlResponse.FromString, 
            options, channel_credentials, 
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata) 
