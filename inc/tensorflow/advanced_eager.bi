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


end extern

#endif 'TENSORFLOW_C_EAGER_C_API_H_