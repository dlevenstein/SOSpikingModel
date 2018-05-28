/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_CAdLIFfunction_STDP_mex.c
 *
 * Code generation for function '_coder_CAdLIFfunction_STDP_mex'
 *
 */

/* Include files */
#include "CAdLIFfunction_STDP.h"
#include "_coder_CAdLIFfunction_STDP_mex.h"
#include "CAdLIFfunction_STDP_terminate.h"
#include "_coder_CAdLIFfunction_STDP_api.h"
#include "CAdLIFfunction_STDP_initialize.h"
#include "CAdLIFfunction_STDP_data.h"

/* Function Declarations */
static void CAdLIFfunction_STDP_mexFunction(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2]);

/* Function Definitions */
static void CAdLIFfunction_STDP_mexFunction(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        19, "CAdLIFfunction_STDP");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 19,
                        "CAdLIFfunction_STDP");
  }

  /* Call the function. */
  CAdLIFfunction_STDP_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  CAdLIFfunction_STDP_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(CAdLIFfunction_STDP_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  CAdLIFfunction_STDP_initialize();

  /* Dispatch the entry-point. */
  CAdLIFfunction_STDP_mexFunction(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_CAdLIFfunction_STDP_mex.c) */
