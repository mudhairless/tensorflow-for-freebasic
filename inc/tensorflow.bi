'Tensorflow For FreeBASIC

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