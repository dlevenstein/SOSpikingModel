/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * toLogicalCheck.c
 *
 * Code generation for function 'toLogicalCheck'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "toLogicalCheck.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo kc_emlrtRSI = { 12, /* lineNo */
  "toLogicalCheck",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\toLogicalCheck.m"/* pathName */
};

/* Function Definitions */
void toLogicalCheck(const emlrtStack *sp, real_T x)
{
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  if (muDoubleScalarIsNaN(x)) {
    st.site = &kc_emlrtRSI;
    b_error(&st);
  }
}

/* End of code generation (toLogicalCheck.c) */
