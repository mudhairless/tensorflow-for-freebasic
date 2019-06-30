/' Copyright 2018 The TensorFlow Authors. All Rights Reserved.

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

#ifndef TENSORFLOW_C_C_API_EXPERIMENTAL_H_
#define TENSORFLOW_C_C_API_EXPERIMENTAL_H_

#include "crt/stddef.bi"
#include "crt/stdint.bi"

#include "tensorflow/advanced.bi"
#include "tensorflow/advanced_eager.bi"

extern "C"

declare sub TF_EnableXLACompilation(byval options as TF_SessionOptions ptr, byval enable as ubyte)
declare function TF_SetXlaEnableLazyCompilation(byval enable as ubyte) as ubyte
declare sub TF_SetXLaAutoJitMode(byval mode as const zstring ptr)
declare sub TF_SetXlaMinClusterSize(byval size as integer)

declare function TF_CreateConfig(byval as ubyte, byval as ubyte, byval as uinteger) as TF_Buffer ptr
declare function TF_CreateRunOptions(byval as ubyte) as TF_Buffer ptr

declare function TF_GraphDebugString(byval g as TF_Graph ptr, byval length as size_t ptr) as const zstring ptr
declare function TF_FunctionDebugString(byval func as TF_Function ptr, byval length as size_t ptr) as zstring ptr

declare function TF_DequeueNamedTensor(byval session as TF_Session ptr, byval tid as integer, byval status as TF_Status ptr) as TF_Tensor ptr
declare sub TF_EnqueueNamedTensor(byval session as TF_Session ptr, byval tid as integer, byval tensor as TF_Tensor ptr, byval status as TF_Status ptr)

declare function TFE_GetServerDef(byval text_proto as const zstring ptr, byval status as TF_Status ptr) as TF_Buffer ptr

declare function TFE_NewContextFromSession(byval opts as const TFE_ContextOptions ptr, byval s as TF_Session ptr, byval status as TF_Status ptr) as TFE_Context ptr
declare function TFE_CreateContextFromSession(byval session as TF_Session ptr, byval status as TF_Status ptr) as TFE_Context ptr

declare function TFE_DequeueNamedTensor(byval session as TF_Session ptr, byval tid as integer, byval inputtype as TF_DataType, byval status as TF_Status ptr) as TFE_TensorHandle ptr
declare function TFE_DequeueNamedTensorFromCtx(byval ctx as TFE_Context ptr, byval tid as integer, byval inputtype as TF_DataType, byval status as TF_Status ptr) as TFE_TensorHandle ptr

declare sub TFE_EnqueueNamedTensor(byval s as TF_Session ptr, byval tid as integer, byval tensor as TFE_TensorHandle ptr, byval status as TF_Status ptr)
declare sub TFE_EnqueueNamedTensorFromCtx(byval ctx as TFE_Context ptr, byval tid as integer, byval tensor as TFE_TensorHandle ptr, byval status as TF_Status ptr)

declare sub TFE_EnqueueVariantTensor(byval s as TF_Session ptr, byval tid as integer, byval tensor as TFE_TensorHandle ptr, byval status as TF_Status ptr)
declare function TFE_DequeueVariantTensor(byval s as TF_Session ptr, byval tid as integer, byval status as TF_Status ptr) as TFE_TensorHandle ptr

declare sub TFE_TensorHandlePrintDebugString(byval hndl as TFE_TensorHandle ptr)

declare sub TFE_OpPrintDebugString(byval op as TFE_Op ptr)

type TFE_ExecuteOpNotification as any

declare function TFE_ExecuteOpInNewThread(byval op as TFE_Op ptr, byval retvals as TFE_TensorHandle ptr ptr, byval num_retvals as integer ptr, byval status as TF_Status ptr) as TFE_ExecuteOpNotification ptr
declare sub TFE_ExecuteOpNotificationWaitAndDelete(byval n as TFE_ExecuteOpNotification ptr, byval status as TF_Status ptr)

declare sub TF_MakeInternalErrorStatus(byval status as TF_Status ptr, byval errMsg as const zstring ptr)

type TF_AttrBuilder as any

declare function TF_NewAttrBuilder(byval op_name as const zstring ptr) as TF_AttrBuilder ptr
declare sub DeleteAttrBuilder(byval builder as TF_AttrBuilder ptr)
declare sub TF_AttrBuilderSetType(byval b as TF_AttrBuilder ptr, byval attr_name as const zstring ptr, byval value as TF_DataType)
declare sub TF_AttrBuilderSetTypeList(byval b as TF_AttrBuilder ptr, byval attr_name as const zstring ptr, byval values as const TF_DataType ptr, byval num_values as integer)
declare sub TF_AttrBuilderCheckCanRunOnDevice(byval b as TF_AttrBuilder ptr, byval device_type as const zstring ptr, byval status as TF_Status ptr)

declare function TF_GetNumberAttrForOpListInput(byval opname as const zstring ptr, byval input_idx as integer, byval status as TF_Status ptr) as const zstring ptr

declare function Tf_OpIsStateful(byval op_type as const zstring ptr, byval status as TF_Status ptr) as integer

declare sub TF_InitMain(byval usage as const zstring ptr, byval argc as integer ptr, byval argv as zstring ptr ptr ptr)

declare function TF_PickUnusedPortOrDie() as integer

declare function TFE_NewTensorHandleFromScalar(byval dtype as TF_DataType, byval scalar as any ptr, byval length as size_t) as TFE_TensorHandle ptr

declare sub TFE_EnableCollectiveOps(byval ctx as TFE_Context ptr, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr)

declare function TFE_NewTensorHandleFromTFOutput(byval t as TF_Output, byval data_type as TF_DataType) as TFE_TensorHandle ptr

declare function TFE_TensorHandleIsConcrete(byval hndl as TFE_TensorHandle ptr) as ubyte
declare function TFE_GetTFOutputFromTensorHandle(byval hndl as TFE_TensorHandle ptr, byval status as TF_Status ptr) as TF_Output

type TFE_TraceContext as any

declare function TFE_NewTraceContext(byval g as TF_Graph ptr) as TFE_TraceContext ptr
declare sub TFE_DeleteTraceContext(byval tctx as TFE_TraceContext ptr)

declare function TFE_AddEagerOpToGraph(byval op as TFE_Op ptr, byval tctx as TFE_TraceContext ptr, byval retvals as TFE_TensorHandle ptr ptr, byval num_retvals as integer ptr, byval status as TF_Status ptr) as TF_Operation ptr

declare function TFE_FinalizeInputTensorsFromTraceContext(byval tctx as TFE_TraceContext ptr) as integer

declare function TFE_GetInputGraphNodeFromTraceContext(byval ctx as TFE_TraceContext ptr, byval idx as uinteger) as TF_Output

declare function TFE_ConsumeInputConcreteTensorFromTraceContext(byval ctx as TFE_TraceContext ptr, byval idx as uinteger) as TFE_TensorHandle ptr

end extern

#endif 'TENSORFLOW_C_C_API_EXPERIMENTAL_H_