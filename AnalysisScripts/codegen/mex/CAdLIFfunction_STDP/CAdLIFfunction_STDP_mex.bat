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
echo OMPFLAGS= >> CAdLIFfunction_STDP_mex.mki
echo OMPLINKFLAGS= >> CAdLIFfunction_STDP_mex.mki
echo EMC_COMPILER=lcc64>> CAdLIFfunction_STDP_mex.mki
echo EMC_CONFIG=optim>> CAdLIFfunction_STDP_mex.mki
"C:\Program Files\MATLAB\R2018a\bin\win64\gmake" -j 1 -B -f CAdLIFfunction_STDP_mex.mk
