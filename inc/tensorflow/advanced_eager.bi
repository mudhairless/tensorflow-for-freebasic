/' Copyright 2017 The TensorFlow Authors. All Rights Reserved.

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

#ifndef TENSORFLOW_C_EAGER_C_API_H_
#define TENSORFLOW_C_EAGER_C_API_H_

#include "tensorflow/advanced.bi"

extern "C"

type TFE_ContextOptions as any

declare function TFE_NewContextOptions() as TFE_ContextOptions ptr
declare sub TFE_ContextOptionsSetConfig(byval o as TFE_ContextOptions ptr, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr)

enum TFE_ContextDevicePlacementPolicy
  TFE_DEVICE_PLACEMENT_EXPLICIT = 0,
  TFE_DEVICE_PLACEMENT_WARN = 1,
  TFE_DEVICE_PLACEMENT_SILENT = 2,
  TFE_DEVICE_PLACEMENT_SILENT_FOR_INT32 = 3,
end enum

declare sub TFE_ContextOptionsSetAsync(byval o as TFE_ContextOptions ptr, byval enable as ubyte)
declare sub TFE_ContextOptionsSetDevicePlacementPolicy(byval o as TFE_ContextOptions ptr, byval pol as TFE_ContextDevicePlacementPolicy)

declare sub TFE_DeleteContextOptions(byval as TFE_ContextOptions ptr)

type TFE_Context as any

declare function TFE_NewContext(byval o as const TFE_ContextOptions ptr, byval status as TF_Status ptr) as TFE_Context ptr
declare sub TFE_DeleteContext(byval c as TFE_Context ptr)
declare function TFE_ContextListDevices(byval c as TFE_Context ptr, byval status as TF_Status ptr) as TF_DeviceList ptr

declare sub TFE_ContextClearCaches(byval c as TFE_Context ptr)

declare sub TFE_ContextSetThreadLocalDevicePlacementPolicy(byval c as TFE_Context ptr, byval as TFE_ContextDevicePlacementPolicy)
declare function TFE_ContextGetDevicePlacementPolicy(byval as TFE_Context ptr) as TFE_ContextDevicePlacementPolicy

declare sub TFE_ContextSetAsyncForThread(byval as TFE_Context ptr, byval enable as ubyte, byval status as TF_Status ptr)
declare sub TFE_ContextSetServerDef(byval as TFE_Context ptr, byval keep_alive as integer, byval proto as const any ptr, byval proto_len as size_t, byval status as TF_Status ptr)
declare sub TFE_ContextAsyncWait(byal as TFE_Context, byval status as TF_Status ptr)
declare sub TFE_ContextAsyncClearError(byval as TFE_Context ptr)

type TFE_TensorHandle as any

declare function TFE_NewTensorHandle(byval t as TF_Tensor ptr, byval status as TF_Status ptr) as TFE_TensorHandle ptr
declare sub TFE_DeleteTensorHandle(byval as TFE_TensorHandle ptr)
declare function TFE_TensorHandleDataType(byval as TFE_TensorHandle ptr) as TF_DataType
declare function TFE_TensorHandleNumDims(byval as TFE_TensorHandle ptr, byval status as TF_Status ptr) as integer
declare function TFE_TensorHandleNumElements(byval as TFE_TensorHandle ptr, byval as TF_Status ptr) as int64_t
declare function TFE_TensorHandleDim(byval as TFE_TensorHandle ptr, byval dim_index as integer, byval as TF_Status ptr) as int64_t
declare function TFE_TensorHandleDeviceName(byval as TFE_TensorHandle ptr, byval as TF_Status ptr) as const zstring ptr
declare function TFE_TensorHandleBackingDeviceName(byval as TFE_TensorHandle ptr, byval as TF_Status ptr) as const zstring ptr
declare function TFE_TensorHandleCopySharingTensor(byval as TFE_TensorHandle ptr, byval as TF_Status ptr) as TFE_TensorHandle ptr
declare function TFE_TensorHandleResolve(byval as TFE_TensorHandle ptr, byval as TF_Status ptr) as TF_Tensor ptr
declare function TFE_TensorHandleCopyToDevice(byval h as TFE_TensorHandle ptr, byval ctx as TFE_Context ptr, byval device_name as const zstring ptr, byval status as TF_Status ptr) as TFE_TensorHandle ptr

type TFE_TensorDebugInfo as any

declare function TFE_TensorHandleTensorDebugInfo(byval hndl as TFE_TensorHandle ptr, byval status as TF_Status ptr) as TFE_TensorDebugInfo ptr
declare sub TFE_DeleteTensorDebugInfo(byval di as TFE_TensorDebugInfo ptr)
declare function TFE_TensorDebugInfoOnDeviceNumDims(byval di as TFE_TensorDebugInfo ptr) as integer
declare function TFE_TensorDebugInfoOnDeviceDim(byval di as TFE_TensorDebugInfo ptr, byval dim_index as integer) as int64_t

type TFE_Op as any

declare function TFE_NewOp(byval ctx as TFE_Context ptr, byval op_or_func_name as const zstring ptr, byval status as TF_Status ptr) as TFE_Op ptr
declare sub TFE_DeleteOp(byval op as TFE_Op ptr)
declare sub TFE_OpSetDevice(byval op as TFE_Op ptr, byval dev_name as const zstring ptr, byval status as TF_Status ptr)
declare function TFE_OpGetDevice(byval op as TFE_Op ptr, byval status as TF_Status ptr) as const zstring ptr
declare sub TFE_OpSetXLACompilation(byval op as TFE_Op ptr, byval enable as ubyte)
declare sub TFE_OpAddInput(byval op as TFE_Op ptr, byval input_ as TFE_TensorHandle ptr, byval status as TF_Status ptr)
declare sub TFE_OpAddInputList(byval op as TFE_Op ptr, byval inputs as TFE_TensorHandle ptr ptr, byval num_inputs as integer, byval status as TF_Status ptr)
declare function TFE_OpGetAttrType(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval is_list as ubyte ptr, byval status as TF_Status ptr) as TF_AttrType
declare function TFE_OpNameGetAttrType(byval ctx as TFE_Context ptr, byval o_or_f_name as const zstring ptr, byval attr_name as const zstring ptr, byval is_list as ubyte ptr, byval status as TF_Status ptr) as TF_AttrType

declare sub TFE_OpSetAttrString(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as const any ptr, byval length as size_t)
declare sub TFE_OpSetAttrInt(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as int64_t)
declare sub TFE_OpSetAttrFloat(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as single)
declare sub TFE_OpSetAttrBool(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as ubyte)
declare sub TFE_OpSetAttrType(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as TF_DataType)
declare sub TFE_OpSetAttrShape(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval dims as const int64_t ptr, byval num_dims as const integer, byval out_status as TF_Status ptr)
declare sub TFE_OpSetAttrFunction(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as const TFE_Op ptr)
declare sub TFE_OpSetAttrFunctionName(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as const zstring ptr, byval length as size_t)
declare sub TFE_OpSetAttrTensor(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval value_ as TF_Tensor ptr, byval status as TF_Status ptr)
declare sub TFE_OpSetAttrStringList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval values as const any ptr const ptr, byval lengths as const size_t ptr, byval num_values as integer)
declare sub TFE_OpSetAttrIntList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval values as const int64_t ptr, byval num_values as integer)
declare sub TFE_OpSetAttrFloatList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval values as const single ptr, byval num_values as integer)
declare sub TFE_OpSetAttrBoolList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval values as const ubyte ptr, byval num_values as integer)
declare sub TFE_OpSetAttrTypeList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval values as const TF_DataType ptr, byval num_values as integer)
declare sub TFE_OpSetAttrShapeList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval dims as const int64_t ptr ptr, byval num_dims as const integer ptr, byval num_values as integer, byval status as TF_Status ptr)
declare sub TFE_OpSetAttrFunctionList(byval op as TFE_Op ptr, byval attr_name as const zstring ptr, byval values as const TFE_Op ptr ptr, byval num_values as integer)

declare function TFE_OpGetInputLength(byval op as TFE_Op ptr, byval input_name as const zstring ptr, byval status as TF_Status ptr) as integer
declare function TFE_OpGetOutputLength(byval op as TFE_Op ptr, byval output_name as const zstring ptr, byval status as TF_Status ptr) as integer

declare sub TFE_Execute(byval op as TFE_Op ptr, byval retvals as TFE_TensorHandle ptr ptr, byval num_retvals as integer ptr, byval status as TF_Status ptr)

declare sub TFE_ContextAddFunctionDef(byval ctx as TFE_Context ptr, byval sfd as const zstring ptr, byval size_ as size_t, byval status as TF_Status ptr)
declare sub TFE_ContextRemoveFunction(byval ctx as TFE_Context ptr, byval name_ as const zstring ptr, byval status as TF_Status ptr)
declare function TFE_ContextHasFunction(byval ctx as TFE_Context ptr, byval name_ as const zstring ptr) as ubyte
declare sub TFE_ContextEnableRunMetadata(byval ctx as TFE_Context ptr)
declare sub TFE_ContextDisableRunMetadata(byval ctx as TFE_Context ptr)
declare sub TFE_ContextExportRunMetadata(byval ctx as TFE_Context ptr, byval buf as TF_Buffer ptr, byval status as TF_Status ptr)
declare sub TFE_ContextStartStep(byval ctx as TFE_Context ptr)
declare sub TFE_ContextEndStep(byval ctx as TFE_Context ptr)



end extern

#endif 'TENSORFLOW_C_EAGER_C_API_H_