/' Copyright 2019 Ebben Feagan. All Rights Reserved.

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

#ifndef _TENSORFLOW_FOR_FB_TENSOR_BI__
#define _TENSORFLOW_FOR_FB_TENSOR_BI__

#include once "tensorflow/common.bi"

namespace TensorFlow

    type Tensor
        public:
        declare constructor()
        declare destructor()

        declare property lenDimensions() as integer
        declare property lenDimension(byval index as integer) as ulongint
        declare property lenElements() as ulongint
        declare property sizeInBytes() as size_t

        declare property type_of() as DataType
        private:
        _d as any ptr
    end type

end namespace

#endif