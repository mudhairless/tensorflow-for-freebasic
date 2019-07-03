/'Tensorflow For FreeBASIC
Copyright 2019 Ebben Feagan. All Rights Reserved.

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

#ifndef __TENSORFLOW_FOR_FREEBASIC_BI__
    
    #define __TENSORFLOW_FOR_FREEBASIC_BI__

    #inclib "tensorflow" ' <- the main lib here
    ' Download the appropriate package for your platform from https://www.tensorflow.org/install/lang_c#download
    ' You will need to have both the tensorflow and tensorflow_framework libraries from the downloaded package.

    ' when higher level api is available the c api will not
    ' be included by default
    '#ifdef TENSORFLOW_C_API
        #include "tensorflow/advanced.bi"
        #include "tensorflow/advanced_experimental.bi"
    '#endif

    

#endif '__TENSORFLOW_FOR_FREEBASIC_BI__