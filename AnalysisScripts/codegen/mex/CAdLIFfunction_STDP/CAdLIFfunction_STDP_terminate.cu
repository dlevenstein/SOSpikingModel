/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * CAdLIFfunction_STDP_terminate.cu
 *
 * Code generation for function 'CAdLIFfunction_STDP_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "CAdLIFfunction_STDP_terminate.h"
#include "_coder_CAdLIFfunction_STDP_mex.h"
#include "CAdLIFfunction_STDP_data.h"

/* Function Definitions */
void CAdLIFfunction_STDP_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void CAdLIFfunction_STDP_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (CAdLIFfunction_STDP_terminate.cu) */
