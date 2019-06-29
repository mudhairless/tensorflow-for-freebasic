/' Copyright 2015 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=============================================================================='/

#include once "crt/stddef.bi"
#include once "crt/stdint.bi"

#ifndef TENSORFLOW_C_C_API_H_
#define TENSORFLOW_C_C_API_H_

extern "C"

declare function TF_Version() as const zstring ptr

enum TF_AttrType
    TF_ATTR_STRING = 0,
    TF_ATTR_INT = 1,
    TF_ATTR_FLOAT = 2,
    TF_ATTR_BOOL = 3,
    TF_ATTR_TYPE = 4,
    TF_ATTR_SHAPE = 5,
    TF_ATTR_TENSOR = 6,
    TF_ATTR_PLACEHOLDER = 7,
    TF_ATTR_FUNC = 8,
end enum

enum TF_DataType
    TF_FLOAT = 1,
    TF_DOUBLE = 2,
    TF_INT32 = 3,  ' Int32 tensors are always in 'host' memory.
    TF_UINT8 = 4,
    TF_INT16 = 5,
    TF_INT8 = 6,
    TF_STRING = 7,
    TF_COMPLEX64 = 8,  ' Single-precision complex
    TF_COMPLEX = 8,    ' Old identifier kept for API backwards compatibility
    TF_INT64 = 9,
    TF_BOOL = 10,
    TF_QINT8 = 11,     ' Quantized int8
    TF_QUINT8 = 12,    ' Quantized uint8
    TF_QINT32 = 13,    ' Quantized int32
    TF_BFLOAT16 = 14,  ' Float32 truncated to 16 bits.  Only for cast ops.
    TF_QINT16 = 15,    ' Quantized int16
    TF_QUINT16 = 16,   ' Quantized uint16
    TF_UINT16 = 17,
    TF_COMPLEX128 = 18,  ' Double-precision complex
    TF_HALF = 19,
    TF_RESOURCE = 20,
    TF_VARIANT = 21,
    TF_UINT32 = 22,
    TF_UINT64 = 23,
end enum

declare function TF_DataTypeSize(byval dt as TF_DataType) as size_t

enum TF_Code
    TF_OK = 0,
    TF_CANCELLED = 1,
    TF_UNKNOWN = 2,
    TF_INVALID_ARGUMENT = 3,
    TF_DEADLINE_EXCEEDED = 4,
    TF_NOT_FOUND = 5,
    TF_ALREADY_EXISTS = 6,
    TF_PERMISSION_DENIED = 7,
    TF_UNAUTHENTICATED = 16,
    TF_RESOURCE_EXHAUSTED = 8,
    TF_FAILED_PRECONDITION = 9,
    TF_ABORTED = 10,
    TF_OUT_OF_RANGE = 11,
    TF_UNIMPLEMENTED = 12,
    TF_INTERNAL = 13,
    TF_UNAVAILABLE = 14,
    TF_DATA_LOSS = 15,
end enum

type TF_Status as any

declare function TF_NewStatus() as TF_Status ptr
declare sub TF_DeleteStatus(byval s as TF_Status ptr)
declare sub TF_SetStatus(byval s as TF_Status ptr, byval c as TF_Code, byval msg as const zstring ptr)
declare function TF_GetCode(byval s as const TF_Status ptr) as TF_Code
declare function TF_Message(byval s as const TF_Status ptr) as const zstring ptr

type TF_Buffer
    data_ as const any ptr
    length as size_t
    deallocator as sub(byval d as any ptr, byval l as size_t)
end type

declare function TF_NewBufferFromString(byval s as const zstring ptr, byval l as size_t) as TF_Buffer ptr
declare function TF_NewBuffer() as TF_Buffer ptr
declare sub TF_DeleteBuffer(byval d as TF_Buffer ptr)
declare function TF_GetBuffer(byval d as TF_Buffer ptr) as TF_Buffer

type TF_Tensor as any

declare function TF_NewTensor(byval dt as TF_DataType, byval dims as const int64_t ptr, byval num_dims as integer, byval d as any ptr, byval dlen as size_t, byval f as sub(byval as any ptr, byval as size_t, byval as any ptr), byval farg as any ptr) as TF_Tensor ptr
declare function TF_AllocateTensor(byval dt as TF_DataType, byval dims as const int64_t ptr, byval num_dims as integer, byval len as size_t) as TF_Tensor ptr
declare function TF_TensorMaybeMove(byval t as TF_Tensor ptr) as TF_Tensor ptr
declare sub TF_DeleteTensor(byval t as TF_Tensor ptr)
declare function TF_TensorType(byval t as TF_Tensor ptr) as TF_DataType
declare function TF_NumDims(byval t as TF_Tensor ptr) as integer
declare function TF_Dim(byval t as TF_Tensor ptr, byval dim_index as integer) as int64_t
declare function TF_TEnsorByteSize(byval t as TF_Tensor ptr) as size_t
declare function TF_TensorData(byval t as TF_Tensor ptr) as any ptr
declare function TF_TensorElementCount(byval t as const TF_Tensor ptr) as int64_t
declare sub TF_TensorBitcastFrom(byval f as const TF_Tensor ptr, byval type_ as TF_DataType, byval to_ as TF_Tensor ptr, byval new_dims as const int64_t ptr, byval num_new_dims as integer, byval status as TF_Status ptr)

declare function TF_StringEncode(byval src as const zstring ptr, byval src_len as size_t, byval dst as zstring ptr, byval dst_len as size_t, byval status as TF_Status ptr) as size_t
declare function TF_StringDecode(byval src as const zstring ptr, byval src_len as size_t, byval dst as const zstring ptr ptr, byval dst_len as size_t ptr, byval status as TF_STatus ptr) as size_t
declare function TF_StringEncodedSize(byval length as size_t) as size_t

type TF_SessionOptions as any

declare function TF_NewSessionOptions() as TF_SessionOptions ptr
declare sub TF_SetTarget(byval opts as TF_SessionOptions ptr, byval target as const zstring ptr)
declare sub TF_SetConfig(byval opts as TF_SessionOptions ptr, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_STatus ptr)
declare sub TF_DeleteSessionOptions(byval opts as TF_SessionOptions ptr)


type TF_Graph as any

declare function TF_NewGraph() as TF_Graph ptr
declare sub TF_DeleteGraph(byval g as TF_Graph ptr)

type TF_OperationDescription as any
type TF_Operation as any

type TF_Input
    oper as TF_Operation ptr
    index as integer
end type

type TF_Output
    oper as TF_Operation ptr
    index as integer
end type

type TF_Function as any
type TF_FunctionOptions as any

declare sub TF_GraphSetTensorShape(byval graph as TF_Graph ptr, byval output_ as TF_Output, byval dims as const int64_t ptr, byval num_dims as const integer, byval status as TF_Status ptr)
declare function TF_GraphGetTensorNumDims(byval graph as TF_Graph ptr, byval output_ as TF_Output, byval status as TF_STatus ptr) as integer
declare sub TF_GraphGetTensorShape(byval graph as TF_Graph ptr, byval output_ as TF_Output, byval dims as int64_t ptr, byval num_dims as integer, byval status as TF_Status ptr)

declare function TF_NewOperation(byval graph as TF_Graph ptr, byval op_type as const zstring ptr, byval oper_name as const zstring ptr) as TF_OperationDescription ptr
declare sub TF_SetDevice(byval desc as TF_OperationDescription ptr, byval device as const zstring ptr)
declare sub TF_AddInput(byval desc as TF_OperationDescription ptr, byval input_ as TF_Input)
declare sub TF_AddInputList(byval desc as TF_OperationDescription ptr, byval inputs as const TF_Input ptr, byval num_inputs as integer)
declare sub TF_AddControlInput(byval desc as TF_OperationDescription ptr, byval input_ as TF_Operation ptr)
declare sub TF_ColocateWith(byval desc as TF_OperationDescription ptr, byval op as TF_Operation ptr)
declare sub TF_SetAttrString(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value as const any ptr, byval length as size_t)
declare sub TF_SetAttrStringList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval values as const any const ptr, byval lengths as size_t ptr, byval num_values as integer)
declare sub TF_SetAttrInt(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value_ as int64_t)
declare sub TF_SetAttrIntList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval values_ as const int64_t const ptr, byval num_values as integer)
declare sub TF_SetAttrFloat(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value_ as single)
declare sub TF_SetAttrFloatList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval values_ as const single ptr, byval num_values as integer)
declare sub TF_SetAttrBool(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value_ as ubyte)
declare sub TF_SetAttrBoolList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval values_ as const ubyte ptr, byval num_values as integer)
declare sub TF_SetAttrType(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value_ as TF_DataType)
declare sub TF_SetAttrTypeList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval values_ as const TF_DataType ptr, byval num_values as integer)
declare sub TF_SetAttrPlaceholder(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval placeholder as const zstring ptr)
declare sub TF_SetAttrFuncName(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value_ as const zstring ptr, byval length as size_t)
declare sub TF_SetAttrShape(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval dims as const int64_t ptr, byval num_dims as integer)
declare sub TF_SetAttrShapeList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval dims as const int64_t ptr const ptr, byval num_dims as const integer ptr, byval num_shapes as integer)
declare sub TF_SetAttrTensorShapeProto(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr)
declare sub TF_SetAttrTensorShapeProtoList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval protos as const any ptr const ptr, byval proto_lens as const size_t ptr, byval num_shapes as integer, byval status as TF_Status ptr)
declare sub TF_SetAttrTensor(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval value_ as TF_Tensor ptr)
declare sub TF_SetAttrTensorList(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval values_ as const TF_Tensor ptr const ptr, byval num_values as integer, byval status as TF_Status ptr)
declare sub TF_SetAttrValueProto(byval desc as TF_OperationDescription ptr, byval attr_name as const zstring ptr, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr)

declare function TF_FinishOperation(byval desc as TF_OperationDescription ptr, byval status as TF_Status ptr) as TF_Operation ptr

declare function TF_OperationName(byval oper as TF_Operation ptr) as const zstring ptr
declare function TF_OperationOpType(byval oper as TF_Operation ptr) as const zstring ptr
declare function TF_OperationDevice(byval oper as TF_Operation ptr) as const zstring ptr
declare function TF_OperationNumOutputs(byval oper as TF_Operation ptr) as integer
declare function TF_OperationOutputType(byval oper as TF_Output) as TF_DataType
declare function TF_OperationOutputListLength(byval oper as TF_Operation ptr, byval arg_name as const zstring ptr, byval status as TF_Status ptr) as integer
declare function TF_OperationNumInputs(byval oper as TF_Operation ptr) as integer
declare function TF_OperationInputType(byval oper_in as TF_Input) as TF_DataType
declare function TF_OperationInputListLength(byval oper as TF_Operation ptr, byval arg_name as const zstring ptr, byval status as TF_Status ptr) as integer

declare function TF_OperationInput(byval oper_in as TF_Input) as TF_Output

declare function TF_OperationOutputNumConsumers(byval oper_out as TF_Output) as integer
declare function TF_OperationOutputConsumers(byval oper_out as TF_Output, byval consumers as TF_Input ptr, byval max_consumers as integer) as integer

declare function TF_OperationNumControlInputs(byval oper as TF_Operation ptr) as integer
declare function TF_OperationGetControlInputs(byval oper as TF_Operation ptr, byval control_inputs as TF_Operation ptr ptr, byval max_control_inputs as integer) as integer

declare function TF_OperationNumControlOutputs(byval oper as TF_Operation ptr) as integer
declare function TF_OperationGetControlOutputs(byval oper as TF_Operation ptr, byval control_outputs as TF_Operation ptr ptr, byval max_control_outputs as integer) as integer

type TF_AttrMetadata
    is_list as ubyte
    list_size as int64_t
    type_ as TF_AttrType
    total_size as int64_t
end type

declare function TF_OperationGetAttrMetadata(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval status as TF_Status ptr) as TF_AttrMetadata
declare sub TF_OperationGetAttrString(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as any ptr, byval max_length as size_t, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrStringList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval values_ as any ptr ptr, byval lengths as size_t ptr, byval max_values as integer, byval storage as any ptr, byval storage_size as size_t, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrInt(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as int64_t ptr, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrIntList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval balues as int64_t ptr, byval max_values as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrFloat(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as single ptr, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrFloatList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval values_ as single ptr, byval max_values as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrBool(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as ubyte ptr, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrBoolList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval values_ as ubyte ptr, byval max_values as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrType(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as TF_DataType ptr, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrTypeList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval values_ as TF_DataType ptr, byval max_values as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrShape(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as int64_t ptr, byval num_dims as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrShapeList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval dims as int64_t ptr ptr, byval num_dims as integer ptr, byval num_shapes as integer, byval storage as int64_t ptr, byval storage_size as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrTensorShapeProto(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as TF_Buffer ptr, byval status as Tf_Status ptr)
declare sub TF_OperationGetAttrTensorShapeProtoList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval values_ as TF_Buffer ptr ptr, byval max_values as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrTensor(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval value_ as TF_Tensor ptr ptr, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrTensorList(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval values_ as TF_Tensor ptr ptr, byval max_values as integer, byval status as TF_Status ptr)
declare sub TF_OperationGetAttrValueProto(byval oper as TF_Operation ptr, byval attr_name as const zstring ptr, byval output_attr_value as TF_Buffer ptr, byval status as TF_Status ptr)

declare function TF_GraphOperationByName(byval graph as TF_Graph ptr, byval oper_name as const zstring ptr) as TF_Operation ptr
declare function TF_GraphNextOperation(byval grph as TF_Graph ptr, byval pos as size_t ptr) as TF_Operation ptr
declare sub TF_GraphToGraphDef(byval graph as TF_Graph ptr, byval output_graph_def as TF_Buffer ptr, byval status as Tf_Status ptr)
declare sub TF_GraphGetOpDef(byval graph as TF_Graph ptr, byval op_name as const zstring ptr, byval output_op_def as TF_Buffer ptr, byval status as TF_Status ptr)
declare sub TF_GraphVersions(byval graph as TF_Graph ptr, byval output_version_def as TF_Buffer ptr, byval status as TF_Status ptr)

type TF_ImportGraphDefOptions as any

declare function TF_NewImportGraphDefOptions() as TF_ImportGraphDefOptions ptr
declare sub TF_DeleteImportGraphDefOptions(byval opts as TF_ImportGraphDefOptions ptr)

declare sub TF_ImportGraphDefOptionsSetPrefix(byval opts as TF_ImportGraphDefOptions ptr, byval prefix as const zstring ptr)
declare sub TF_ImportGraphDefOptionsSetDefaultDevice(byval opts as TF_ImportGraphDefOptions ptr, byval device as const zstring ptr)
declare sub TF_ImportGraphDefOptionsSetUniquifyNames(byval opts as TF_ImportGraphDefOptions ptr, byval as ubyte)
declare sub TF_ImportGraphDefOptionsSetUniquifyPrefix(byval opts as TF_ImportGraphDefOptions ptr, byval as ubyte)
declare sub TF_ImportGraphDefOptionsAddInputMapping(byval opts as TF_ImportGraphDefOptions ptr, byval src_name as const zstring ptr, byval src_index as integer, byval dst as TF_Output)
declare sub TF_ImportGraphDefOptionsRemapControlDependency(byval opts as TF_ImportGraphDefOptions ptr, byval src_name as const zstring ptr, byval dst as TF_Operation ptr)
declare sub TF_ImportGraphDefOptionsAddControlDependency(byval opts as TF_ImportGraphDefOptions ptr, byval oper as TF_Operation ptr)
declare sub TF_ImportGraphDefOptionsAddReturnOutput(byval opts as TF_ImportGraphDefOptions ptr, byval oper_name as const zstring ptr, byval index as integer)
declare function TF_ImportGraphDefOptionsNumReturnOutputs(byval opts as TF_ImportGraphDefOptions ptr) as integer
declare sub TF_ImportGraphDefOptionsAddReturnOperation(byval opts as TF_ImportGraphDefOptions ptr, byval oper_name as const zstring ptr)
declare function TF_ImportGraphDefOptionsNumReturnOperations(byval opts as TF_ImportGraphDefOptions ptr) as integer

type TF_ImportGraphDefResults as any

declare sub TF_ImportGraphDefResultsReturnOutputs(byval results as TF_ImportGraphDefResults ptr, byval num_outputs as integer ptr, byval outputs as TF_Output ptr ptr)
declare sub TF_ImportGraphDefResultsReturnOperations(byval results as TF_ImportGraphDefResults ptr, byval num_opers as integer ptr, byval opers as TF_Operation ptr ptr ptr)
declare sub TF_ImportGraphDefResultsMissingUnusedInputMappings(byval results as TF_ImportGraphDefResults ptr, byval num_map as integer ptr, byval src_names as const zstring ptr ptr ptr, byval src_indexes as integer ptr ptr)
declare sub TF_DeleteImportGraphDefResults(byval results as TF_ImportGraphDefResults ptr)
declare function TF_GraphImportGraphDefWithResults(byval graph as TF_Graph ptr, byval graph_def as const TF_Buffer ptr, byval options as const TF_ImportGraphDefOptions ptr, byval status as TF_Status ptr) as TF_ImportGraphDefResults ptr
declare sub TF_GraphImportGraphDefWithReturnOutputs(byval graph as TF_Graph ptr, byval graph_def as const TF_Buffer ptr, byval opts as const TF_ImportGraphDefOptions ptr, byval return_outputs as TF_Output ptr, byval num_return_outputs, byval status as TF_Status ptr)
declare sub TF_GraphImportGraphDef(byval grph as TF_Graph ptr, byval graph_def as const TF_Buffer ptr, byval opts as TF_ImportGraphDefOptions ptr, byval status as TF_Status ptr)
declare sub TF_GraphCopyFunction(byval g as TF_Graph ptr, byval func as const TF_Function ptr, byval grad as const TF_Function ptr, byval status as TF_Status ptr)
declare function TF_GraphNumFunctions(byval g as TF_Graph ptr) as integer
declare function TF_GraphGetFunctions(byval g as TF_Graph ptr, byval funcs as TF_Function ptr ptr, byval max_funcs as itneger, byval status as TF_STatus ptr) as integer

declare sub TF_OperationToNodeDef(byval oper as TF_Operation ptr, byval output_node_def as TF_Buffer ptr, byval status as TF_Status ptr)

type Tf_WhileParams
    ninputs as integer
    cond_graph as TF_Graph ptr
    cond_inputs as TF_Input ptr
    cond_output as TF_Output
    body_graph as TF_Graph ptr
    body_inputs as TF_Input ptr
    body_outputs as TF_Output ptr
    name_ as zstring ptr
end type

declare function TF_NewWhile(byval g as TF_Graph ptr, byval inputs as TF_input ptr, byval ninputs as integer, byval status as TF_Status ptr)
declare sub TF_FinishWhile(byval params as const TF_WhileParams ptr, byval status as TF_Status ptr, byval outputs as TF_Output ptr)
declare sub TF_AbortWhile(byval params as const TF_WhileParams ptr)

declare sub TF_AddGradients(byval g as TF_Graph ptr, byval y as TF_Input ptr, byval ny as integer, byval x as TF_Input ptr, byval nx as integer, byval dx as TF_Output ptr, byval status as Tf_Status ptr, byval dy as TF_Output ptr)
declare sub TF_AddGradientsWithPrefix(byval g as TF_Graph ptr, byval prefix as const zstring ptr, byval y as TF_Input ptr, byval ny as integer, byval x as TF_Input ptr, byval nx as integer, byval dx as TF_Output ptr, byval status as Tf_Status ptr, byval dy as TF_Output ptr)

declare function TF_GraphToFunction(byval fn_body as const TF_Graph ptr, byval fn_name as const zstring ptr, byval append_hash as ubyte, byval num_opers as integer, byval opers as const TF_Operation ptr const ptr, byval ninputs as integer, byval inputs as const TF_Inputs ptr, byval noutputs as integer, byval outputs as const TF_Output ptr, byval output_names as const zstring ptr const ptr, byval opts as const TF_FunctionOptions ptr, byval desc as const zstring ptr, byval status as TF_Status ptr) as TF_Function ptr
declare function TF_GraphToFunctionWithControlOutputs(byval fn_body as const TF_Graph ptr, byval fn_name as const zstring ptr, byval append_hash as ubyte, byval num_opers as integer, byval opers as const TF_Operation ptr const ptr, byval ninputs as integer, byval inputs as const TF_Inputs ptr, byval noutputs as integer, byval outputs as const TF_Output ptr, byval output_names as const zstring ptr const ptr, byval ncontrol_outputs as integer, byval control_outputs as const TF_Operation ptr const ptr, byval control_output_names as const zstring ptr const ptr, byval opts as const TF_FunctionOptions ptr, byval desc as const zstring ptr, byval status as TF_Status ptr) as TF_Function ptr

declare function TF_FunctionName(byval func as TF_Function ptr) as const zstring ptr

declare sub TF_FunctionToFunctionDef(byval func as TF_Function ptr, byval output_func_def as TF_Buffer ptr, byval status as TF_Status ptr)
declare function TF_FunctionImportFunctionDef(byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr) as TF_Function ptr
declare sub TF_FunctionSetAttrValueProto(byval func as TF_Function ptr, byval attr_name as const zstring ptr, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr)
declare sub TF_FunctionGetAttrValueProto(byval func as TF_Function ptr, byval attr_name as const zstring ptr, byval output_attr_value as TF_Buffer ptr, byval status as Tf_Status ptr)
declare sub TF_DeleteFunction(byval func as TF_Function ptr)

declare function TF_TryEvaluateConstant(byval graph as TF_Graph ptr, byval output as TF_Output, byval result as TF_Tensor ptr ptr, byval status as TF_Status ptr) as ubyte

type TF_Session as any

declare function TF_NewSession(byval graph as TF_Graph ptr, byval opts as const TF_SessionOptions ptr, byval status as TF_Status ptr) as Tf_Session ptr
declare function TF_LoadSessionFromSavedModel(byval opts as const TF_SessionOptions ptr, byval run_options as const TF_Buffer ptr, byval export_dir as const zstring ptr, byval tags as const zstring ptr const ptr, byval tags_len as integer, byval graph as TF_Graph ptr, byval meta_graph_def as TF_Buffer ptr, byval status as TF_Status ptr) as TF_Session ptr
declare sub TF_CloseSession(byval s as TF_Session ptr, byval status as TF_Status ptr)
declare sub TF_DeleteSession(byval s as TF_Session ptr, byval status as TF_Status ptr)
declare sub TF_SessionRun(byval s as TF_Session ptr, byval run_opt as const TF_Buffer ptr, byval inputs as const TF_Input ptr, byval input_values as TF_Tensor ptr const ptr, byval ninputs as integer, byval outputs as const TF_Output ptr, byval output_values as TF_Tensor ptr ptr, byval noutputs as integer, byval target_opers as const TF_Operation ptr const ptr, byval ntargets as integer, byval run_metadata as TF_Buffer ptr, byval status as TF_Status ptr)
declare sub TF_SessionPRunSetup(byval s as TF_Session ptr, byval inputs as const TF_Input ptr, byval ninputs, byval outputs as const TF_Output ptr, byval noutputs, byval target_opers as const TF_Operation ptr const ptr, byval ntargets as integer, byval handle as const zstring ptr ptr, byval status as TF_Status ptr)
declare sub TF_SessionPRun(byval s as TF_Session ptr, byval handle as const zstring ptr, byval inputs as const TF_Input ptr, byval input_values as TF_Tensor ptr const ptr, byval ninputs as integer, byval outputs as const TF_Output ptr, byval output_values as TF_Tensor ptr ptr, byval noutputs as integer, byval target_opers as const TF_Operation ptr const ptr, byval ntargets as integer, byval status as TF_STatus ptr)
declare sub TF_DeletePRunHandle(byval handle as const zstring ptr)

// DeprecatedSession not implemented

declare sub TF_Reset(byval opts as const TF_SessionOptions ptr, byval containers as const zstring ptr ptr, byval ncontainers as integer, byval status as TF_Status ptr)

type TF_DeviceList as any

declare function TF_SessionListDevices(byval session as TF_Session ptr, byval status as TF_Status ptr) as TF_DeviceList ptr
declare sub TF_DeleteDeviceList(byval list as TF_DeviceList ptr)
declare function TF_DeviceListCount(byval list as const TF_DeviceList ptr) as integer
declare function TF_DeviceListName(byval list as const TF_DeviceList ptr, byval index as integer, byval status as TF_Status ptr) as const zstring ptr
declare function TF_DeviceListType(byval list as const TF_DeviceList ptr, byval index as integer, byval status as TF_Status ptr) as const zstring ptr
declare function TF_DeviceListMemoryBytes(byval list as const TF_DeviceList ptr, byval index as integer, byval status as TF_Status ptr) as int64_t
declare function TF_DeviceListIncarnation(byval list as const Tf_DeviceList ptr, byval index as integer, byval status as TF_Status ptr) as uint64_t

type TF_Library as any

declare function TF_LoadLibrary(byval filename as const zstring ptr, byval status as TF_Status ptr) as TF_Library ptr
declare function TF_GetOpList(byval lib as TF_Library ptr) as TF_Buffer
declare sub TF_DeleteLibraryHandle(byval lib as TF_Library ptr)
declare sub TF_GetAllOpList() as TF_Buffer ptr

type TF_ApiDefMap as any

declare function TF_NewApiDefMap(byval op_list_buffer as TF_Buffer ptr, byval status as TF_Status ptr) as TF_ApiDefMap ptr
declare sub TF_DeleteApiDefMap(byval apimap as TF_ApiDefMap ptr)
declare sub TF_ApiDefMapPut(byval adm as TF_ApiDefMap ptr, byval text as const zstring ptr, byval text_len as size_t, byval status as TF_Status ptr)
declare function TF_ApiDefMapGet(byval adm as TF_ApiDefMap ptr, byval name_ as const zstring ptr, byval name_len as size_t, byval status as TF_Status ptr) as TF_Buffer ptr

declare function TF_GetAllRegisteredKernels(byval s as TF_Status ptr) as TF_Buffer ptr
declare function TF_GetRegisteredKernelsForOp(byval name_ as const zstring ptr, byval s as TF_Status ptr) as TF_Buffer ptr

type TF_Server as any

declare function TF_NewServer(byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr) as TF_Server ptr
declare sub TF_ServerStart(byval server as TF_Server ptr, byval status as TF_Status ptr)
declare sub TF_ServerStop(byval server as TF_Server ptr, byval status as TF_Status ptr)
declare sub TF_ServerJoin(byval server as TF_Server ptr, byval status as Tf_Status ptr)
declare function TF_ServerTarget(byval server as TF_Server ptr) as const zstring ptr
declare sub TF_DeleteServer(byval server as TF_Server ptr)

declare sub TF_RegisterLogListener(byval listener as sub(byval as const zstring ptr))

end extern

#endif 'TENSORFLOW_C_C_API_H_