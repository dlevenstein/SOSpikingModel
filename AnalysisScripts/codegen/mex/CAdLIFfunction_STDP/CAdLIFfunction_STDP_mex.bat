@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2018a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2018a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=CAdLIFfunction_STDP_mex
set MEX_NAME=CAdLIFfunction_STDP_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2018a\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for CAdLIFfunction_STDP > CAdLIFfunction_STDP_mex.mki
echo COMPILER=%COMPILER%>> CAdLIFfunction_STDP_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> CAdLIFfunction_STDP_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> CAdLIFfunction_STDP_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> CAdLIFfunction_STDP_mex.mki
echo LINKER=%LINKER%>> CAdLIFfunction_STDP_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> CAdLIFfunction_STDP_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> CAdLIFfunction_STDP_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> CAdLIFfunction_STDP_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> CAdLIFfunction_STDP_mex.mki
echo BORLAND=%BORLAND%>> CAdLIFfunction_STDP_mex.mki
echo NVCC=nvcc >> CAdLIFfunction_STDP_mex.mki
echo CUDA_FLAGS= -c -rdc=true -Xcompiler "/wd 4819" -Xcompiler "/MD" -Xcudafe "--diag_suppress=unsigned_compare_with_zero --diag_suppress=useless_type_qualifier_on_return_type" -D_GNU_SOURCE -DMATLAB_MEX_FILE -Wno-deprecated-declarations  >> CAdLIFfunction_STDP_mex.mki
echo LD=nvcc >> CAdLIFfunction_STDP_mex.mki
echo MAPLIBS=libemlrt.lib,libcovrt.lib,libut.lib,libmwmathutil.lib,/export:mexFunction,/export:emlrtMexFcnProperties,/export:CAdLIFfunction_STDP,/export:emxEnsureCapacity_boolean_T,/export:emxEnsureCapacity_boolean_T1,/export:emxEnsureCapacity_int32_T,/export:emxEnsureCapacity_int32_T1,/export:emxEnsureCapacity_int8_T,/export:emxEnsureCapacity_real32_T,/export:emxEnsureCapacity_real32_T1,/export:emxEnsureCapacity_real_T,/export:emxEnsureCapacity_real_T1,/export:emxEnsureCapacity_real_T2,/export:emxFreeMatrix_cell_wrap_1,/export:emxFreeStruct_struct2_T,/export:emxFree_boolean_T,/export:emxFree_int32_T,/export:emxFree_int8_T,/export:emxFree_real32_T,/export:emxFree_real_T,/export:emxInitMatrix_cell_wrap_1,/export:emxInitStruct_struct2_T,/export:emxInit_boolean_T,/export:emxInit_boolean_T1,/export:emxInit_int32_T,/export:emxInit_int32_T1,/export:emxInit_int8_T,/export:emxInit_real32_T,/export:emxInit_real32_T1,/export:emxInit_real_T,/export:emxInit_real_T1,/export:emxInit_real_T2,/export:CAdLIFfunction_STDP_initialize,/export:CAdLIFfunction_STDP_terminate,/export:CAdLIFfunction_STDP_atexit >> CAdLIFfunction_STDP_mex.mki
echo OMPFLAGS= >> CAdLIFfunction_STDP_mex.mki
echo OMPLINKFLAGS= >> CAdLIFfunction_STDP_mex.mki
echo EMC_COMPILER=lcc64>> CAdLIFfunction_STDP_mex.mki
echo EMC_CONFIG=optim>> CAdLIFfunction_STDP_mex.mki
"C:\Program Files\MATLAB\R2018a\bin\win64\gmake" -B -f CAdLIFfunction_STDP_mex.mk
