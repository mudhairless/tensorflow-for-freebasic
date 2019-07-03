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

#include once "tensorflow/common.bi"

namespace TensorFlow

    constructor Status()
        this._d = TF_NewStatus()
    end constructor

    destructor Status()
        TF_DeleteStatus(this._d)
    end destructor

    property Status.statusCode() as Code
        return TF_GetCode(this._d)
    end property

    property Status.message() as const zstring ptr
        return TF_Message(this._d)
    end property

end namespace