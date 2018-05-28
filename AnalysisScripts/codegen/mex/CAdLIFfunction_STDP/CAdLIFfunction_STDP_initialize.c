/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * CAdLIFfunction_STDP_initialize.c
 *
 * Code generation for function 'CAdLIFfunction_STDP_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "CAdLIFfunction_STDP_initialize.h"
#include "_coder_CAdLIFfunction_STDP_mex.h"
#include "CAdLIFfunction_STDP_data.h"

/* Function Definitions */
void CAdLIFfunction_STDP_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (CAdLIFfunction_STDP_initialize.c) */
