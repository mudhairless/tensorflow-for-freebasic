#include "file.bi"

declare sub do_clean()
declare sub do_build()

function realmain() as integer
    do_clean
    do_build
    return 0
end function

sub do_clean()
    ? "Starting clean..."
    dim platform as string
    #ifdef __FB_WINDOWS__
        platform = "windows"
    #endif
    #ifdef __FB_LINUX__
        platform = "linux"
    #endif
    chdir(exepath)
    chdir("src")
    dim filename as string = Dir("*.o")
    while(len(filename) > 0)
        ? "Removing object file: " & filename
        kill filename
        filename = dir()
    wend

    
    chdir(exepath)
    if(fileexists("lib/" & platform & "/libtensorflow4fb.a")) then
        ? "Removing library..."
        kill "lib/" & platform & "/libtensorflow4fb.a"
    end if
end sub

sub do_build()
    ? "Starting Build..."
    dim obj_files as string = ""
    dim compiler as string = environ("FBC")
    if(len(compiler) = 0) then
        compiler = "fbc"
    end if
    dim compile_opts as string = environ("FBCFLAGS")
    if (len(compile_opts) = 0) then
        compile_opts = "-w all"
    end if
    dim link_opts as string = environ("FBCLINK")
    dim platform as string
    #ifdef __FB_WINDOWS__
        platform = "windows"
    #endif
    #ifdef __FB_LINUX__
        platform = "linux"
    #endif
    chdir(exepath)
    chdir("src")
    dim filename as string = Dir("*.bas")
    while(len(filename) > 0)
        var filename_o = left(filename, len(filename) - 3) & "o"
        obj_files = obj_files & "./src/" & filename_o & " "
        ? compiler & " -i " & exepath & "/inc " & "-c " & filename & " -o " & filename_o & " " & compile_opts
        var x = exec(compiler, "-i " & exepath & "/inc -c " & exepath & "/src/" & filename & " -o " & exepath & "/src/" & filename_o & " " & compile_opts)
        if (x > 0) then
            system x
        end if
        filename = dir()
    wend
    chdir(exepath)
    ? compiler & " " & "-lib " & obj_files & " -x ./lib/" & platform & "/libtensorflow4fb.a " & link_opts
    exec(compiler, "-lib " & obj_files & " -x ./lib/" & platform & "/libtensorflow4fb.a " & link_opts)
    
    
end sub

system realmain()