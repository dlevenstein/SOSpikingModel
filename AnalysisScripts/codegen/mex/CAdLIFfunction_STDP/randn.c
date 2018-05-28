/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * randn.c
 *
 * Code generation for function 'randn'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "randn.h"
#include "CAdLIFfunction_STDP_emxutil.h"

/* Variable Definitions */
static emlrtRTEInfo nh_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "randn",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\randfun\\randn.m"/* pName */
};

/* Function Definitions */
void randn(const emlrtStack *sp, real_T varargin_1, emxArray_real_T *r)
{
  int32_T i5;
  i5 = r->size[0];
  r->size[0] = (int32_T)varargin_1;
  emxEnsureCapacity_real_T1(sp, r, i5, &nh_emlrtRTEI);
  if (!(r->size[0] == 0)) {
    emlrtRandn(&r->data[0], r->size[0]);
  }
}

/* End of code generation (randn.c) */
