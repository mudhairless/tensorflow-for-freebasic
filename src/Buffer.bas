
#include once "tensorflow/advanced.bi"
#include once "tensorflow/Buffer.bi"

namespace TensorFlow

    constructor Buffer()
        this._buf = TF_NewBuffer()
    end constructor

    constructor Buffer(byval contents as const string)
        this._buf = TF_NewBufferFromString(contents, len(contents))
    end constructor

    destructor Buffer()
        TF_DeleteBuffer(this._buf)
        this._buf = 0
    end destructor

    operator Buffer.@() as TF_Buffer ptr
        return cptr(TF_Buffer ptr, this._buf)
    end operator

end namespace