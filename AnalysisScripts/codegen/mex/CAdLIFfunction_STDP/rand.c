/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rand.c
 *
 * Code generation for function 'rand'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "CAdLIFfunction_STDP.h"
#include "rand.h"
#include "CAdLIFfunction_STDP_emxutil.h"

/* Variable Definitions */
static emlrtRTEInfo ih_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "rand",                              /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\randfun\\rand.m"/* pName */
};

static emlrtDCInfo wc_emlrtDCI = { 100,/* lineNo */
  34,                                  /* colNo */
  "rand",                              /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\randfun\\rand.m",/* pName */
  4                                    /* checkKind */
};

/* Function Definitions */
void b_rand(const emlrtStack *sp, real_T varargin_1, emxArray_real_T *r)
{
  int32_T i1;
  if (!(varargin_1 >= 0.0)) {
    emlrtNonNegativeCheckR2012b(varargin_1, &wc_emlrtDCI, sp);
  }

  i1 = r->size[0] * r->size[1];
  r->size[0] = (int32_T)varargin_1;
  r->size[1] = (int32_T)varargin_1;
  emxEnsureCapacity_real_T(sp, r, i1, &ih_emlrtRTEI);
  if (!((r->size[0] == 0) || (r->size[1] == 0))) {
    emlrtRandu(&r->data[0], r->size[0] * r->size[1]);
  }
}

void c_rand(const emlrtStack *sp, real_T varargin_1, real_T varargin_2,
            emxArray_real_T *r)
{
  int32_T i3;
  i3 = r->size[0] * r->size[1];
  if (!(varargin_1 >= 0.0)) {
    emlrtNonNegativeCheckR2012b(varargin_1, &wc_emlrtDCI, sp);
  }

  r->size[0] = (int32_T)varargin_1;
  if (!(varargin_2 >= 0.0)) {
    emlrtNonNegativeCheckR2012b(varargin_2, &wc_emlrtDCI, sp);
  }

  r->size[1] = (int32_T)varargin_2;
  emxEnsureCapacity_real_T(sp, r, i3, &ih_emlrtRTEI);
  if (!((r->size[0] == 0) || (r->size[1] == 0))) {
    emlrtRandu(&r->data[0], r->size[0] * r->size[1]);
  }
}

void d_rand(const emlrtStack *sp, real_T varargin_1, emxArray_real_T *r)
{
  int32_T i4;
  i4 = r->size[0];
  r->size[0] = (int32_T)varargin_1;
  emxEnsureCapacity_real_T1(sp, r, i4, &ih_emlrtRTEI);
  if (!(r->size[0] == 0)) {
    emlrtRandu(&r->data[0], r->size[0]);
  }
}

/* End of code generation (rand.c) */
